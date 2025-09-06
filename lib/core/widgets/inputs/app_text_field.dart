import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shemanit/core/accessibility/accessibility_utils.dart';
import 'package:shemanit/core/responsive/responsive_utils.dart';

/// Enumeration for text field variants
enum AppTextFieldVariant {
  standard,
  outlined,
  filled,
}

/// Platform-adaptive text field with accessibility support and hooks
class AppTextField extends HookWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.decoration,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.autofocus = false,
    this.readOnly = false,
    this.showCursor,
    this.obscureText = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.selectionHeightStyle = BoxHeightStyle.tight,
    this.selectionWidthStyle = BoxWidthStyle.tight,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableInteractiveSelection,
    this.selectionControls,
    this.onTap,
    this.onTapOutside,
    this.mouseCursor,
    this.buildCounter,
    this.scrollController,
    this.scrollPhysics,
    this.autofillHints,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.scribbleEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.contextMenuBuilder,
    this.canRequestFocus = true,
    this.spellCheckConfiguration,
    this.magnifierConfiguration,
    this.variant = AppTextFieldVariant.outlined,
    this.label,
    this.hint,
    this.helper,
    this.error,
    this.prefix,
    this.suffix,
    this.prefixIcon,
    this.suffixIcon,
    this.semanticLabel,
    this.isRequired = false,
    this.validator,
    this.debounceDelay = const Duration(milliseconds: 300),
    this.animationDuration = const Duration(milliseconds: 200),
    this.autoValidate = true,
  });

  // Standard TextField properties
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final bool autofocus;
  final bool readOnly;
  final bool? showCursor;
  final bool obscureText;
  final bool autocorrect;
  final bool enableSuggestions;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final AppPrivateCommandCallback? onAppPrivateCommand;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final BoxHeightStyle selectionHeightStyle;
  final BoxWidthStyle selectionWidthStyle;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final DragStartBehavior dragStartBehavior;
  final bool? enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final GestureTapCallback? onTap;
  final TapRegionCallback? onTapOutside;
  final MouseCursor? mouseCursor;
  final InputCounterWidgetBuilder? buildCounter;
  final ScrollController? scrollController;
  final ScrollPhysics? scrollPhysics;
  final Iterable<String>? autofillHints;
  final Clip clipBehavior;
  final String? restorationId;
  final bool scribbleEnabled;
  final bool enableIMEPersonalizedLearning;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final bool canRequestFocus;
  final SpellCheckConfiguration? spellCheckConfiguration;
  final TextMagnifierConfiguration? magnifierConfiguration;

  // Custom properties
  final AppTextFieldVariant variant;
  final String? label;
  final String? hint;
  final String? helper;
  final String? error;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? semanticLabel;
  final bool isRequired;
  final String? Function(String?)? validator;
  final Duration debounceDelay;
  final Duration animationDuration;
  final bool autoValidate;

  @override
  Widget build(BuildContext context) {
    // Hooks for state management
    final effectiveController = controller ?? useTextEditingController();
    final effectiveFocusNode = focusNode ?? useFocusNode();
    final errorText = useState<String?>(error);
    final isFocused = useState(false);
    
    // Debounced validation
    final debouncedValue = useMemoized(() {
      final notifier = ValueNotifier(effectiveController.text);
      Timer? debounceTimer;
      
      void listener() {
        debounceTimer?.cancel();
        debounceTimer = Timer(debounceDelay, () {
          notifier.value = effectiveController.text;
        });
      }
      
      effectiveController.addListener(listener);
      return notifier;
    }, [effectiveController, debounceDelay]);
    
    final debouncedText = useListenable(debouncedValue).value;
    
    // Auto-validation with debouncing
    useEffect(() {
      if (autoValidate && validator != null) {
        final validationError = validator!(debouncedText);
        errorText.value = validationError;
      }
      return null;
    }, [debouncedText, validator, autoValidate]);
    
    // Handle text changes
    final handleChanged = useCallback((String value) {
      if (!autoValidate && validator != null) {
        final validationError = validator!(value);
        errorText.value = validationError;
      }
      onChanged?.call(value);
    }, [validator, autoValidate, onChanged]);
    
    // Focus state management
    useEffect(() {
      void focusListener() {
        isFocused.value = effectiveFocusNode.hasFocus;
      }
      
      effectiveFocusNode.addListener(focusListener);
      return () => effectiveFocusNode.removeListener(focusListener);
    }, [effectiveFocusNode]);

    // Use platform-specific text field on iOS
    if (Platform.isIOS && variant == AppTextFieldVariant.standard) {
      return _buildCupertinoTextField(
        context, 
        effectiveController, 
        effectiveFocusNode,
        errorText.value,
        handleChanged,
      );
    }
    
    // Use Material text field for all other cases
    return _buildMaterialTextField(
      context, 
      effectiveController, 
      effectiveFocusNode,
      errorText.value,
      handleChanged,
      isFocused.value,
    );
  }

  Widget _buildCupertinoTextField(
    BuildContext context,
    TextEditingController effectiveController,
    FocusNode effectiveFocusNode,
    String? currentErrorText,
    ValueChanged<String> handleChanged,
  ) {
    final theme = Theme.of(context);
    
    Widget textField = CupertinoTextField(
      controller: effectiveController,
      focusNode: effectiveFocusNode,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      style: widget.style,
      textAlign: widget.textAlign,
      autofocus: widget.autofocus,
      readOnly: widget.readOnly,
      showCursor: widget.showCursor,
      obscureText: widget.obscureText,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.enableSuggestions,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      expands: widget.expands,
      maxLength: widget.maxLength,
      maxLengthEnforcement: widget.maxLengthEnforcement,
      onChanged: _handleChanged,
      onEditingComplete: widget.onEditingComplete,
      onSubmitted: widget.onSubmitted,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      cursorWidth: widget.cursorWidth,
      cursorHeight: widget.cursorHeight,
      cursorRadius: widget.cursorRadius,
      cursorColor: widget.cursorColor,
      keyboardAppearance: widget.keyboardAppearance,
      scrollPadding: widget.scrollPadding,
      dragStartBehavior: widget.dragStartBehavior,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      selectionControls: widget.selectionControls,
      onTap: widget.onTap,
      scrollController: widget.scrollController,
      scrollPhysics: widget.scrollPhysics,
      autofillHints: widget.autofillHints,
      clipBehavior: widget.clipBehavior,
      restorationId: widget.restorationId,
      scribbleEnabled: widget.scribbleEnabled,
      enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
      placeholder: widget.hint,
      prefix: widget.prefixIcon,
      suffix: widget.suffixIcon,
      padding: ResponsiveUtils.responsiveValue(
        context: context,
        mobile: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        tablet: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: ResponsiveUtils.responsiveBorderRadius(context),
        border: _errorText != null
            ? Border.all(color: theme.colorScheme.error)
            : Border.all(color: theme.colorScheme.outline),
      ),
    );

    return _wrapWithLabelsAndAccessibility(context, textField);
  }

  Widget _buildMaterialTextField(BuildContext context) {
    final theme = Theme.of(context);
    final decoration = _buildInputDecoration(context, theme);

    Widget textField = TextField(
      controller: widget.controller,
      focusNode: _focusNode,
      decoration: decoration,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      style: widget.style,
      strutStyle: widget.strutStyle,
      textDirection: widget.textDirection,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      autofocus: widget.autofocus,
      readOnly: widget.readOnly,
      showCursor: widget.showCursor,
      obscureText: widget.obscureText,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.enableSuggestions,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      expands: widget.expands,
      maxLength: widget.maxLength,
      maxLengthEnforcement: widget.maxLengthEnforcement,
      onChanged: _handleChanged,
      onEditingComplete: widget.onEditingComplete,
      onSubmitted: widget.onSubmitted,
      onAppPrivateCommand: widget.onAppPrivateCommand,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      cursorWidth: widget.cursorWidth,
      cursorHeight: widget.cursorHeight,
      cursorRadius: widget.cursorRadius,
      cursorColor: widget.cursorColor,
      selectionHeightStyle: widget.selectionHeightStyle,
      selectionWidthStyle: widget.selectionWidthStyle,
      keyboardAppearance: widget.keyboardAppearance,
      scrollPadding: widget.scrollPadding,
      dragStartBehavior: widget.dragStartBehavior,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      selectionControls: widget.selectionControls,
      onTap: widget.onTap,
      onTapOutside: widget.onTapOutside,
      mouseCursor: widget.mouseCursor,
      buildCounter: widget.buildCounter,
      scrollController: widget.scrollController,
      scrollPhysics: widget.scrollPhysics,
      autofillHints: widget.autofillHints,
      clipBehavior: widget.clipBehavior,
      restorationId: widget.restorationId,
      scribbleEnabled: widget.scribbleEnabled,
      enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
      contextMenuBuilder: widget.contextMenuBuilder,
      canRequestFocus: widget.canRequestFocus,
      spellCheckConfiguration: widget.spellCheckConfiguration,
      magnifierConfiguration: widget.magnifierConfiguration,
    );

    return _wrapWithLabelsAndAccessibility(context, textField);
  }

  InputDecoration _buildInputDecoration(BuildContext context, ThemeData theme) {
    final baseDecoration = widget.decoration ?? const InputDecoration();
    
    return baseDecoration.copyWith(
      labelText: widget.label,
      hintText: widget.hint,
      helperText: widget.helper,
      errorText: _errorText ?? widget.error,
      prefixIcon: widget.prefixIcon,
      suffixIcon: widget.suffixIcon,
      prefix: widget.prefix,
      suffix: widget.suffix,
      filled: widget.variant == AppTextFieldVariant.filled,
      border: _getBorder(context, theme),
      enabledBorder: _getBorder(context, theme),
      focusedBorder: _getFocusedBorder(context, theme),
      errorBorder: _getErrorBorder(context, theme),
      focusedErrorBorder: _getFocusedErrorBorder(context, theme),
    );
  }

  InputBorder _getBorder(BuildContext context, ThemeData theme) {
    final borderRadius = ResponsiveUtils.responsiveBorderRadius(context);
    
    return switch (widget.variant) {
      AppTextFieldVariant.standard => UnderlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.outline),
        ),
      AppTextFieldVariant.outlined => OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: theme.colorScheme.outline),
        ),
      AppTextFieldVariant.filled => OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide.none,
        ),
    };
  }

  InputBorder _getFocusedBorder(BuildContext context, ThemeData theme) {
    final borderRadius = ResponsiveUtils.responsiveBorderRadius(context);
    
    return switch (widget.variant) {
      AppTextFieldVariant.standard => UnderlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
        ),
      AppTextFieldVariant.outlined => OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
        ),
      AppTextFieldVariant.filled => OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
        ),
    };
  }

  InputBorder _getErrorBorder(BuildContext context, ThemeData theme) {
    final borderRadius = ResponsiveUtils.responsiveBorderRadius(context);
    
    return switch (widget.variant) {
      AppTextFieldVariant.standard => UnderlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.error),
        ),
      AppTextFieldVariant.outlined => OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: theme.colorScheme.error),
        ),
      AppTextFieldVariant.filled => OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: theme.colorScheme.error),
        ),
    };
  }

  InputBorder _getFocusedErrorBorder(BuildContext context, ThemeData theme) {
    final borderRadius = ResponsiveUtils.responsiveBorderRadius(context);
    
    return switch (widget.variant) {
      AppTextFieldVariant.standard => UnderlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.error, width: 2),
        ),
      AppTextFieldVariant.outlined => OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: theme.colorScheme.error, width: 2),
        ),
      AppTextFieldVariant.filled => OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: theme.colorScheme.error, width: 2),
        ),
    };
  }

  Widget _wrapWithLabelsAndAccessibility(BuildContext context, Widget textField) {
    final theme = Theme.of(context);
    
    Widget result = textField;

    // Add semantic label for accessibility
    if (widget.semanticLabel != null) {
      result = Semantics(
        label: widget.semanticLabel,
        textField: true,
        child: result,
      );
    }

    // Add label for Cupertino text field (Material handles this automatically)
    if (Platform.isIOS && widget.label != null) {
      result = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                widget.label!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              if (widget.isRequired)
                Text(
                  ' *',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          result,
          if (_errorText != null) ...[
            const SizedBox(height: 8),
            Text(
              _errorText!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          ],
          if (widget.helper != null && _errorText == null) ...[
            const SizedBox(height: 8),
            Text(
              widget.helper!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      );
    }

    return result;
  }

  void _handleChanged(String value) {
    // Validate if validator is provided
    if (widget.validator != null) {
      setState(() {
        _errorText = widget.validator!(value);
      });
    }

    // Call the original onChanged callback
    widget.onChanged?.call(value);
  }
}
