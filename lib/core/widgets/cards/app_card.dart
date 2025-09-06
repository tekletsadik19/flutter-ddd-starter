import 'package:flutter/material.dart';
import 'package:shemanit/core/responsive/responsive_utils.dart';

/// Enumeration for card variants
enum AppCardVariant {
  elevated,
  outlined,
  filled,
}

/// Reusable card widget with responsive design and accessibility
class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    super.key,
    this.variant = AppCardVariant.elevated,
    this.padding,
    this.margin,
    this.onTap,
    this.semanticLabel,
    this.borderRadius,
    this.elevation,
    this.backgroundColor,
    this.borderColor,
    this.shadowColor,
    this.width,
    this.height,
    this.clipBehavior = Clip.antiAlias,
  });

  /// Convenience constructor for elevated card
  const AppCard.elevated({
    required this.child,
    super.key,
    this.padding,
    this.margin,
    this.onTap,
    this.semanticLabel,
    this.borderRadius,
    this.elevation,
    this.backgroundColor,
    this.shadowColor,
    this.width,
    this.height,
    this.clipBehavior = Clip.antiAlias,
  }) : variant = AppCardVariant.elevated,
       borderColor = null;

  /// Convenience constructor for outlined card
  const AppCard.outlined({
    required this.child,
    super.key,
    this.padding,
    this.margin,
    this.onTap,
    this.semanticLabel,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.width,
    this.height,
    this.clipBehavior = Clip.antiAlias,
  }) : variant = AppCardVariant.outlined,
       elevation = null,
       shadowColor = null;

  /// Convenience constructor for filled card
  const AppCard.filled({
    required this.child,
    super.key,
    this.padding,
    this.margin,
    this.onTap,
    this.semanticLabel,
    this.borderRadius,
    this.backgroundColor,
    this.width,
    this.height,
    this.clipBehavior = Clip.antiAlias,
  }) : variant = AppCardVariant.filled,
       elevation = null,
       shadowColor = null,
       borderColor = null;

  final Widget child;
  final AppCardVariant variant;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final VoidCallback? onTap;
  final String? semanticLabel;
  final BorderRadius? borderRadius;
  final double? elevation;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? shadowColor;
  final double? width;
  final double? height;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectivePadding = padding ?? ResponsiveUtils.responsivePadding(context);
    final effectiveBorderRadius = borderRadius ?? ResponsiveUtils.responsiveBorderRadius(context);

    Widget card = Container(
      width: width,
      height: height,
      margin: margin,
      child: Card(
        elevation: _getEffectiveElevation(context),
        color: _getEffectiveBackgroundColor(context, theme),
        shadowColor: shadowColor ?? theme.colorScheme.shadow,
        shape: _getCardShape(context, theme, effectiveBorderRadius),
        clipBehavior: clipBehavior,
        child: Padding(
          padding: effectivePadding,
          child: child,
        ),
      ),
    );

    // Make card tappable if onTap is provided
    if (onTap != null) {
      card = InkWell(
        onTap: onTap,
        borderRadius: effectiveBorderRadius,
        child: card,
      );
    }

    // Add semantic label for accessibility
    if (semanticLabel != null) {
      card = Semantics(
        label: semanticLabel,
        button: onTap != null,
        child: card,
      );
    }

    return card;
  }

  double? _getEffectiveElevation(BuildContext context) {
    return switch (variant) {
      AppCardVariant.elevated => elevation ?? ResponsiveUtils.responsiveElevation(context),
      AppCardVariant.outlined => 0,
      AppCardVariant.filled => 0,
    };
  }

  Color? _getEffectiveBackgroundColor(BuildContext context, ThemeData theme) {
    if (backgroundColor != null) return backgroundColor;

    return switch (variant) {
      AppCardVariant.elevated => theme.cardColor,
      AppCardVariant.outlined => theme.cardColor,
      AppCardVariant.filled => theme.colorScheme.surfaceVariant,
    };
  }

  ShapeBorder _getCardShape(BuildContext context, ThemeData theme, BorderRadius borderRadius) {
    return switch (variant) {
      AppCardVariant.elevated => RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
      AppCardVariant.outlined => RoundedRectangleBorder(
          borderRadius: borderRadius,
          side: BorderSide(
            color: borderColor ?? theme.colorScheme.outline,
            width: 1,
          ),
        ),
      AppCardVariant.filled => RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
    };
  }
}

/// Card with header and optional actions
class AppCardWithHeader extends StatelessWidget {
  const AppCardWithHeader({
    required this.title,
    required this.child,
    super.key,
    this.subtitle,
    this.leading,
    this.actions,
    this.variant = AppCardVariant.elevated,
    this.padding,
    this.margin,
    this.onTap,
    this.semanticLabel,
    this.headerPadding,
    this.contentPadding,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final List<Widget>? actions;
  final Widget child;
  final AppCardVariant variant;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final VoidCallback? onTap;
  final String? semanticLabel;
  final EdgeInsets? headerPadding;
  final EdgeInsets? contentPadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultPadding = ResponsiveUtils.responsivePadding(context);
    final effectiveHeaderPadding = headerPadding ?? 
        EdgeInsets.fromLTRB(
          defaultPadding.left,
          defaultPadding.top,
          defaultPadding.right,
          ResponsiveUtils.spacing8,
        );
    final effectiveContentPadding = contentPadding ?? 
        EdgeInsets.fromLTRB(
          defaultPadding.left,
          0,
          defaultPadding.right,
          defaultPadding.bottom,
        );

    return AppCard(
      variant: variant,
      padding: EdgeInsets.zero,
      margin: margin,
      onTap: onTap,
      semanticLabel: semanticLabel,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Padding(
            padding: effectiveHeaderPadding,
            child: Row(
              children: [
                if (leading != null) ...[
                  leading!,
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleMedium,
                        semanticsLabel: 'Card title: $title',
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          semanticsLabel: 'Card subtitle: $subtitle',
                        ),
                      ],
                    ],
                  ),
                ),
                if (actions != null) ...[
                  const SizedBox(width: 8),
                  ...actions!,
                ],
              ],
            ),
          ),
          // Divider
          Divider(
            height: 1,
            thickness: 1,
            color: theme.colorScheme.outlineVariant,
          ),
          // Content
          Padding(
            padding: effectiveContentPadding,
            child: child,
          ),
        ],
      ),
    );
  }
}

/// Statistics card widget
class AppStatsCard extends StatelessWidget {
  const AppStatsCard({
    required this.title,
    required this.value,
    super.key,
    this.subtitle,
    this.icon,
    this.trend,
    this.trendColor,
    this.onTap,
    this.variant = AppCardVariant.elevated,
    this.semanticLabel,
  });

  final String title;
  final String value;
  final String? subtitle;
  final Widget? icon;
  final String? trend;
  final Color? trendColor;
  final VoidCallback? onTap;
  final AppCardVariant variant;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppCard(
      variant: variant,
      onTap: onTap,
      semanticLabel: semanticLabel ?? 'Statistics card: $title, $value',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with icon
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              if (icon != null) icon!,
            ],
          ),
          const SizedBox(height: 8),
          // Value
          Text(
            value,
            style: ResponsiveUtils.responsiveValue(
              context: context,
              mobile: theme.textTheme.headlineMedium,
              tablet: theme.textTheme.headlineLarge,
            )?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          // Subtitle and trend
          if (subtitle != null || trend != null) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                if (subtitle != null)
                  Expanded(
                    child: Text(
                      subtitle!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                if (trend != null)
                  Text(
                    trend!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: trendColor ?? theme.colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
