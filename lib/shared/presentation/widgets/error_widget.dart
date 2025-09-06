import 'package:flutter/material.dart';
import 'package:shemanit/core/responsive/responsive_utils.dart';

/// Reusable error widget with accessibility and responsive design
class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    required this.message,
    super.key,
    this.onRetry,
    this.icon = Icons.error_outline,
    this.title,
    this.semanticLabel,
  });

  final String message;
  final VoidCallback? onRetry;
  final IconData icon;
  final String? title;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconSize = ResponsiveUtils.responsiveValue(
      context: context,
      mobile: 48.0,
      tablet: 56.0,
      desktop: 64.0,
    );

    return Semantics(
      label: semanticLabel ?? 'Error: $message',
      child: Center(
        child: ResponsiveContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: iconSize,
                color: theme.colorScheme.error,
              ),
              SizedBox(height: ResponsiveUtils.spacing16),
              Text(
                title ?? 'Oops! Something went wrong',
                style: ResponsiveUtils.responsiveValue(
                  context: context,
                  mobile: theme.textTheme.headlineSmall,
                  tablet: theme.textTheme.headlineMedium,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: ResponsiveUtils.spacing8),
              Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              if (onRetry != null) ...[
                SizedBox(height: ResponsiveUtils.spacing24),
                ElevatedButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Try Again'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.error,
                    foregroundColor: theme.colorScheme.onError,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Loading widget with accessibility and responsive design
class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({
    super.key,
    this.message = 'Loading...',
    this.semanticLabel,
    this.size,
  });

  final String message;
  final String? semanticLabel;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final indicatorSize = size ?? ResponsiveUtils.responsiveValue(
      context: context,
      mobile: 24.0,
      tablet: 28.0,
      desktop: 32.0,
    );

    return Semantics(
      label: semanticLabel ?? 'Loading: $message',
      liveRegion: true,
      child: Center(
        child: ResponsiveContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: indicatorSize,
                height: indicatorSize,
                child: CircularProgressIndicator(
                  strokeWidth: ResponsiveUtils.responsiveValue(
                    context: context,
                    mobile: 2.0,
                    tablet: 2.5,
                    desktop: 3.0,
                  ),
                ),
              ),
              SizedBox(height: ResponsiveUtils.spacing16),
              Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Empty state widget with accessibility and responsive design
class AppEmptyWidget extends StatelessWidget {
  const AppEmptyWidget({
    required this.message,
    super.key,
    this.icon = Icons.inbox_outlined,
    this.onAction,
    this.actionLabel,
    this.title,
    this.semanticLabel,
  });

  final String message;
  final IconData icon;
  final VoidCallback? onAction;
  final String? actionLabel;
  final String? title;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconSize = ResponsiveUtils.responsiveValue(
      context: context,
      mobile: 48.0,
      tablet: 56.0,
      desktop: 64.0,
    );

    return Semantics(
      label: semanticLabel ?? 'Empty state: $message',
      child: Center(
        child: ResponsiveContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: iconSize,
                color: theme.colorScheme.outline,
              ),
              SizedBox(height: ResponsiveUtils.spacing16),
              if (title != null) ...[
                Text(
                  title!,
                  style: ResponsiveUtils.responsiveValue(
                    context: context,
                    mobile: theme.textTheme.titleLarge,
                    tablet: theme.textTheme.headlineSmall,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: ResponsiveUtils.spacing8),
              ],
              Text(
                message,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              if (onAction != null && actionLabel != null) ...[
                SizedBox(height: ResponsiveUtils.spacing24),
                ElevatedButton(
                  onPressed: onAction,
                  child: Text(actionLabel!),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
