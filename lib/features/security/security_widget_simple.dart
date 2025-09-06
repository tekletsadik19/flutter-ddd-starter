import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'security_bloc_simple.dart';

/// Simple security wrapper widget
class SimpleSecurityWrapper extends StatelessWidget {
  const SimpleSecurityWrapper({
    required this.child,
    super.key,
  });
  
  final Widget child;
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SimpleSecurityBloc()..add(const SecurityEvent.checkSecurity()),
      child: BlocBuilder<SimpleSecurityBloc, SecurityState>(
        builder: (context, state) {
          return state.when(
            initial: () => const _LoadingWidget(),
            loading: () => const _LoadingWidget(),
            secure: (deviceInfo, isCompromised, isEmulator) {
              // Show warning if compromised but still allow access
              if (isCompromised || isEmulator) {
                return _SecurityWarningWrapper(
                  isCompromised: isCompromised,
                  isEmulator: isEmulator,
                  child: child,
                );
              }
              return child;
            },
            blocked: (reason) => _BlockedWidget(reason: reason),
          );
        },
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _SecurityWarningWrapper extends StatefulWidget {
  const _SecurityWarningWrapper({
    required this.isCompromised,
    required this.isEmulator,
    required this.child,
  });
  
  final bool isCompromised;
  final bool isEmulator;
  final Widget child;
  
  @override
  State<_SecurityWarningWrapper> createState() => _SecurityWarningWrapperState();
}

class _SecurityWarningWrapperState extends State<_SecurityWarningWrapper> {
  bool _showWarning = true;
  
  @override
  Widget build(BuildContext context) {
    if (!_showWarning) return widget.child;
    
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.security,
                size: 64,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                'Security Warning',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              if (widget.isCompromised)
                const Text(
                  'Device appears to be jailbroken/rooted',
                  textAlign: TextAlign.center,
                ),
              if (widget.isEmulator)
                const Text(
                  'Running on emulator/simulator',
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => setState(() => _showWarning = false),
                child: const Text('Continue Anyway'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BlockedWidget extends StatelessWidget {
  const _BlockedWidget({required this.reason});
  
  final String reason;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.block,
                size: 64,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                'Access Blocked',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                reason,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}