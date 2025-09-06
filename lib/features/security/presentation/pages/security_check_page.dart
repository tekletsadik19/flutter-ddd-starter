import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../application/blocs/security_bloc.dart';
import '../widgets/security_warning_dialog.dart';

class SecurityCheckPage extends StatefulWidget {
  const SecurityCheckPage({
    required this.onSecurityCheckComplete,
    super.key,
  });

  final VoidCallback onSecurityCheckComplete;

  @override
  State<SecurityCheckPage> createState() => _SecurityCheckPageState();
}

class _SecurityCheckPageState extends State<SecurityCheckPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ));

    _animationController.repeat(reverse: true);

    // Start security check
    context.read<SecurityBloc>().add(const SecurityEvent.checkSecurity());
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.primary.withOpacity(0.1),
              theme.colorScheme.secondary.withOpacity(0.1),
            ],
          ),
        ),
        child: SafeArea(
          child: BlocConsumer<SecurityBloc, SecurityState>(
            listener: (context, state) {
              state.whenOrNull(
                loaded: (securityStatus, appVersion, warningDismissed, _, __) {
                  if (!securityStatus.threatLevel.isSecure || appVersion.mustUpdate) {
                    if (!warningDismissed) {
                      _showSecurityDialog(context, securityStatus, appVersion);
                    }
                  } else {
                    // Security check passed, continue to app
                    widget.onSecurityCheckComplete();
                  }
                },
                error: (message) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Security check failed: $message'),
                      backgroundColor: theme.colorScheme.error,
                      action: SnackBarAction(
                        label: 'Retry',
                        onPressed: () => context
                            .read<SecurityBloc>()
                            .add(const SecurityEvent.retryCheck()),
                      ),
                    ),
                  );
                },
              );
            },
            builder: (context, state) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _scaleAnimation.value,
                          child: Transform.rotate(
                            angle: _rotationAnimation.value * 2 * 3.14159,
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(60),
                                border: Border.all(
                                  color: theme.colorScheme.primary.withOpacity(0.3),
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/svg/shield_alert.svg',
                                  width: 60,
                                  height: 60,
                                  colorFilter: ColorFilter.mode(
                                    theme.colorScheme.primary,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Security Check',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.when(
                        initial: () => 'Initializing security check...',
                        loading: () => 'Checking device security...',
                        loaded: (_, __, ___, ____, _____) => 'Security check complete',
                        error: (message) => 'Security check failed',
                      ),
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    state.when(
                      initial: () => const CircularProgressIndicator(),
                      loading: () => Column(
                        children: [
                          const CircularProgressIndicator(),
                          const SizedBox(height: 16),
                          Text(
                            'Scanning for security threats...',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      loaded: (securityStatus, appVersion, warningDismissed, _, __) {
                        if (securityStatus.threatLevel.isSecure && !appVersion.mustUpdate) {
                          return Column(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 48,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Device is secure',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              Icon(
                                Icons.warning,
                                color: Colors.orange,
                                size: 48,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Security issues detected',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          );
                        }
                      },
                      error: (message) => Column(
                        children: [
                          Icon(
                            Icons.error,
                            color: theme.colorScheme.error,
                            size: 48,
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton.icon(
                            onPressed: () => context
                                .read<SecurityBloc>()
                                .add(const SecurityEvent.retryCheck()),
                            icon: const Icon(Icons.refresh),
                            label: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showSecurityDialog(
    BuildContext context,
    securityStatus,
    appVersion,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SecurityWarningDialog(
        securityStatus: securityStatus,
        appVersion: appVersion,
        onDismiss: () {
          Navigator.of(context).pop();
          if (!securityStatus.threatLevel.shouldBlockApp && !appVersion.mustUpdate) {
            context.read<SecurityBloc>().add(const SecurityEvent.dismissWarning());
            widget.onSecurityCheckComplete();
          }
        },
        onRetry: () {
          Navigator.of(context).pop();
          context.read<SecurityBloc>().add(const SecurityEvent.retryCheck());
        },
      ),
    );
  }
}