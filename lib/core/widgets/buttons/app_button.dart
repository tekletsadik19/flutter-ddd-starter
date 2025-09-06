import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shemanit/core/responsive/responsive_utils.dart';

/// Enumeration for button variants
enum AppButtonVariant {
  primary,
  secondary,
  outlined,
  text,
  destructive,
}

/// Enumeration for button sizes
enum AppButtonSize {
  small,
  medium,
  large,
}

/// Platform-adaptive button widget with accessibility support
class AppButton extends StatelessWidget {
  const AppButton({
    required this.onPressed,
    required this.child,
    super.key,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isEnabled = true,
    this.fullWidth = false,
    this.icon,
    this.semanticLabel,
    this.tooltip,
  });

  /// Convenience constructor for primary button
  const AppButton.primary({
    required this.onPressed,
    required this.child,
    super.key,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isEnabled = true,
    this.fullWidth = false,
    this.icon,
    this.semanticLabel,
    this.tooltip,
  }) : variant = AppButtonVariant.primary;

  /// Convenience constructor for secondary button
  const AppButton.secondary({
    required this.onPressed,
    required this.child,
    super.key,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isEnabled = true,
    this.fullWidth = false,
    this.icon,
    this.semanticLabel,
    this.tooltip,
  }) : variant = AppButtonVariant.secondary;

  /// Convenience constructor for outlined button
  const AppButton.outlined({
    required this.onPressed,
    required this.child,
    super.key,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isEnabled = true,
    this.fullWidth = false,
    this.icon,
    this.semanticLabel,
    this.tooltip,
  }) : variant = AppButtonVariant.outlined;

  /// Convenience constructor for text button
  const AppButton.text({
    required this.onPressed,
    required this.child,
    super.key,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isEnabled = true,
    this.fullWidth = false,
    this.icon,
    this.semanticLabel,
    this.tooltip,
  }) : variant = AppButtonVariant.text;

  /// Convenience constructor for destructive button
  const AppButton.destructive({
    required this.onPressed,
    required this.child,
    super.key,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isEnabled = true,
    this.fullWidth = false,
    this.icon,
    this.semanticLabel,
    this.tooltip,
  }) : variant = AppButtonVariant.destructive;

  final VoidCallback? onPressed;
  final Widget child;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final bool isLoading;
  final bool isEnabled;
  final bool fullWidth;
  final Widget? icon;
  final String? semanticLabel;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final isEffectivelyEnabled = isEnabled && !isLoading && onPressed != null;
    
    Widget button = _buildPlatformButton(context, isEffectivelyEnabled);

    if (fullWidth) {
      button = SizedBox(width: double.infinity, child: button);
    }

    // Add tooltip if provided
    if (tooltip != null) {
      button = Tooltip(
        message: tooltip!,
        child: button,
      );
    }

    // Add semantic label for accessibility
    if (semanticLabel != null) {
      button = Semantics(
        label: semanticLabel,
        button: true,
        enabled: isEffectivelyEnabled,
        child: button,
      );
    }

    return button;
  }

  Widget _buildPlatformButton(BuildContext context, bool isEffectivelyEnabled) {
    // Use Cupertino buttons on iOS for native feel
    if (Platform.isIOS) {
      return _buildCupertinoButton(context, isEffectivelyEnabled);
    }
    
    // Use Material buttons on Android and other platforms
    return _buildMaterialButton(context, isEffectivelyEnabled);
  }

  Widget _buildCupertinoButton(BuildContext context, bool isEffectivelyEnabled) {
    final theme = Theme.of(context);
    final buttonChild = _buildButtonChild(context);
    final padding = _getButtonPadding(context);

    switch (variant) {
      case AppButtonVariant.primary:
        return CupertinoButton.filled(
          onPressed: isEffectivelyEnabled ? onPressed : null,
          padding: padding,
          child: buttonChild,
        );
      
      case AppButtonVariant.secondary:
      case AppButtonVariant.outlined:
        return CupertinoButton(
          onPressed: isEffectivelyEnabled ? onPressed : null,
          padding: padding,
          color: theme.colorScheme.surfaceVariant,
          child: buttonChild,
        );
      
      case AppButtonVariant.text:
        return CupertinoButton(
          onPressed: isEffectivelyEnabled ? onPressed : null,
          padding: padding,
          child: buttonChild,
        );
      
      case AppButtonVariant.destructive:
        return CupertinoButton.filled(
          onPressed: isEffectivelyEnabled ? onPressed : null,
          padding: padding,
          child: buttonChild,
        );
    }
  }

  Widget _buildMaterialButton(BuildContext context, bool isEffectivelyEnabled) {
    final buttonChild = _buildButtonChild(context);
    final theme = Theme.of(context);

    switch (variant) {
      case AppButtonVariant.primary:
        return ElevatedButton(
          onPressed: isEffectivelyEnabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            padding: _getButtonPadding(context),
            minimumSize: _getMinimumSize(context),
          ),
          child: buttonChild,
        );
      
      case AppButtonVariant.secondary:
        return ElevatedButton(
          onPressed: isEffectivelyEnabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.surfaceVariant,
            foregroundColor: theme.colorScheme.onSurfaceVariant,
            padding: _getButtonPadding(context),
            minimumSize: _getMinimumSize(context),
          ),
          child: buttonChild,
        );
      
      case AppButtonVariant.outlined:
        return OutlinedButton(
          onPressed: isEffectivelyEnabled ? onPressed : null,
          style: OutlinedButton.styleFrom(
            padding: _getButtonPadding(context),
            minimumSize: _getMinimumSize(context),
          ),
          child: buttonChild,
        );
      
      case AppButtonVariant.text:
        return TextButton(
          onPressed: isEffectivelyEnabled ? onPressed : null,
          style: TextButton.styleFrom(
            padding: _getButtonPadding(context),
            minimumSize: _getMinimumSize(context),
          ),
          child: buttonChild,
        );
      
      case AppButtonVariant.destructive:
        return ElevatedButton(
          onPressed: isEffectivelyEnabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.error,
            foregroundColor: theme.colorScheme.onError,
            padding: _getButtonPadding(context),
            minimumSize: _getMinimumSize(context),
          ),
          child: buttonChild,
        );
    }
  }

  Widget _buildButtonChild(BuildContext context) {
    if (isLoading) {
      return _buildLoadingIndicator(context);
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon!,
          const SizedBox(width: 8),
          child,
        ],
      );
    }

    return child;
  }

  Widget _buildLoadingIndicator(BuildContext context) {
    final theme = Theme.of(context);
    final size = _getLoadingIndicatorSize();

    if (Platform.isIOS) {
      return CupertinoActivityIndicator(
        radius: size / 2,
        color: theme.colorScheme.onPrimary,
      );
    }

    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(
          theme.colorScheme.onPrimary,
        ),
      ),
    );
  }

  EdgeInsets _getButtonPadding(BuildContext context) {
    return ResponsiveUtils.responsiveValue(
      context: context,
      mobile: switch (size) {
        AppButtonSize.small => const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        AppButtonSize.medium => const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        AppButtonSize.large => const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      },
      tablet: switch (size) {
        AppButtonSize.small => const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        AppButtonSize.medium => const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        AppButtonSize.large => const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      },
      desktop: switch (size) {
        AppButtonSize.small => const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        AppButtonSize.medium => const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        AppButtonSize.large => const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
      },
    );
  }

  Size _getMinimumSize(BuildContext context) {
    return ResponsiveUtils.responsiveValue(
      context: context,
      mobile: switch (size) {
        AppButtonSize.small => const Size(64, 32),
        AppButtonSize.medium => const Size(80, 40),
        AppButtonSize.large => const Size(96, 48),
      },
      tablet: switch (size) {
        AppButtonSize.small => const Size(72, 36),
        AppButtonSize.medium => const Size(88, 44),
        AppButtonSize.large => const Size(104, 52),
      },
      desktop: switch (size) {
        AppButtonSize.small => const Size(80, 40),
        AppButtonSize.medium => const Size(96, 48),
        AppButtonSize.large => const Size(112, 56),
      },
    );
  }

  double _getLoadingIndicatorSize() {
    return switch (size) {
      AppButtonSize.small => 16,
      AppButtonSize.medium => 20,
      AppButtonSize.large => 24,
    };
  }
}
