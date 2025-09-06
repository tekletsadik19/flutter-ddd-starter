import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Hot reload optimization utilities
class HotReloadUtils {
  HotReloadUtils._();

  static bool _initialized = false;
  static final Map<String, dynamic> _preservedState = {};

  /// Initialize hot reload utilities
  static void initialize() {
    if (_initialized || !kDebugMode) return;

    // Listen for hot reload events
    developer.registerExtension('ext.flutter.hotReload', _handleHotReload);
    developer.log('🔥 Hot reload utilities initialized');
    
    _initialized = true;
  }

  /// Handle hot reload events
  static Future<developer.ServiceExtensionResponse> _handleHotReload(
    String method,
    Map<String, String> parameters,
  ) async {
    developer.log('🔥 Hot reload detected');
    HapticFeedback.lightImpact();
    
    return developer.ServiceExtensionResponse.result('{"result":"success"}');
  }

  /// Preserve state during hot reload
  static void preserveState(String key, dynamic value) {
    if (!kDebugMode) return;
    _preservedState[key] = value;
    developer.log('🔥 State preserved: $key');
  }

  /// Restore preserved state
  static T? restoreState<T>(String key) {
    if (!kDebugMode) return null;
    final value = _preservedState[key] as T?;
    if (value != null) {
      developer.log('🔥 State restored: $key');
    }
    return value;
  }

  /// Clear preserved state
  static void clearPreservedState([String? key]) {
    if (!kDebugMode) return;
    
    if (key != null) {
      _preservedState.remove(key);
      developer.log('🔥 State cleared: $key');
    } else {
      _preservedState.clear();
      developer.log('🔥 All preserved state cleared');
    }
  }

  /// Get all preserved state keys
  static List<String> getPreservedStateKeys() {
    return _preservedState.keys.toList();
  }
}

/// Mixin for widgets that need to preserve state during hot reload
mixin HotReloadPreservation<T extends StatefulWidget> on State<T> {
  /// Key for preserving this widget's state
  String get preservationKey => widget.runtimeType.toString();

  /// Preserve state before hot reload
  void preserveState(Map<String, dynamic> state) {
    HotReloadUtils.preserveState(preservationKey, state);
  }

  /// Restore state after hot reload
  Map<String, dynamic>? restoreState() {
    return HotReloadUtils.restoreState<Map<String, dynamic>>(preservationKey);
  }

  @override
  void dispose() {
    // Preserve state when widget is disposed (potentially due to hot reload)
    if (kDebugMode) {
      final stateToPreserve = getStateToPreserve();
      if (stateToPreserve.isNotEmpty) {
        preserveState(stateToPreserve);
      }
    }
    super.dispose();
  }

  /// Override this to specify what state should be preserved
  Map<String, dynamic> getStateToPreserve() => {};

  /// Override this to handle restored state
  void handleRestoredState(Map<String, dynamic> state) {}
}

/// Widget that preserves its child's state during hot reload
class HotReloadPreserver extends StatefulWidget {
  const HotReloadPreserver({
    required this.child,
    this.preservationKey,
    super.key,
  });

  final Widget child;
  final String? preservationKey;

  @override
  State<HotReloadPreserver> createState() => _HotReloadPreserverState();
}

class _HotReloadPreserverState extends State<HotReloadPreserver> {
  late String _key;

  @override
  void initState() {
    super.initState();
    _key = widget.preservationKey ?? 'preserver_${widget.hashCode}';
  }

  @override
  void dispose() {
    if (kDebugMode) {
      // Preserve the widget tree structure
      HotReloadUtils.preserveState(_key, {
        'widget_type': widget.child.runtimeType.toString(),
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      final restored = HotReloadUtils.restoreState<Map<String, dynamic>>(_key);
      if (restored != null) {
        developer.log('🔥 Restored preserved widget: ${restored['widget_type']}');
      }
    }

    return widget.child;
  }
}

/// Stateful widget that optimizes for hot reload
abstract class HotReloadOptimizedStatefulWidget extends StatefulWidget {
  const HotReloadOptimizedStatefulWidget({super.key});

  @override
  HotReloadOptimizedState createState();
}

/// State class optimized for hot reload
abstract class HotReloadOptimizedState<T extends HotReloadOptimizedStatefulWidget>
    extends State<T> with HotReloadPreservation<T> {
  
  @override
  void initState() {
    super.initState();
    
    if (kDebugMode) {
      // Try to restore state from previous hot reload
      final restored = restoreState();
      if (restored != null) {
        handleRestoredState(restored);
      }
    }
  }

  /// Build method with hot reload optimization
  @override
  Widget build(BuildContext context) {
    return HotReloadPreserver(
      preservationKey: preservationKey,
      child: buildOptimized(context),
    );
  }

  /// Override this instead of build() for hot reload optimization
  Widget buildOptimized(BuildContext context);
}

/// Hot reload friendly form state preservation
mixin FormStatePreservation<T extends StatefulWidget> on State<T> {
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, bool> _checkboxStates = {};
  final Map<String, String?> _dropdownValues = {};

  /// Get a text controller that preserves its value during hot reload
  TextEditingController getController(String key, [String initialValue = '']) {
    if (!_controllers.containsKey(key)) {
      final preserved = HotReloadUtils.restoreState<String>('form_$key');
      _controllers[key] = TextEditingController(text: preserved ?? initialValue);
    }
    return _controllers[key]!;
  }

  /// Get checkbox state that preserves during hot reload
  bool getCheckboxState(String key, [bool initialValue = false]) {
    if (!_checkboxStates.containsKey(key)) {
      final preserved = HotReloadUtils.restoreState<bool>('checkbox_$key');
      _checkboxStates[key] = preserved ?? initialValue;
    }
    return _checkboxStates[key]!;
  }

  /// Set checkbox state
  void setCheckboxState(String key, bool value) {
    _checkboxStates[key] = value;
    HotReloadUtils.preserveState('checkbox_$key', value);
  }

  /// Get dropdown value that preserves during hot reload
  String? getDropdownValue(String key, [String? initialValue]) {
    if (!_dropdownValues.containsKey(key)) {
      final preserved = HotReloadUtils.restoreState<String?>('dropdown_$key');
      _dropdownValues[key] = preserved ?? initialValue;
    }
    return _dropdownValues[key];
  }

  /// Set dropdown value
  void setDropdownValue(String key, String? value) {
    _dropdownValues[key] = value;
    HotReloadUtils.preserveState('dropdown_$key', value);
  }

  @override
  void dispose() {
    // Preserve form state
    for (final entry in _controllers.entries) {
      HotReloadUtils.preserveState('form_${entry.key}', entry.value.text);
      entry.value.dispose();
    }
    super.dispose();
  }
}

/// Widget that shows hot reload status
class HotReloadIndicator extends StatefulWidget {
  const HotReloadIndicator({
    this.child,
    super.key,
  });

  final Widget? child;

  @override
  State<HotReloadIndicator> createState() => _HotReloadIndicatorState();
}

class _HotReloadIndicatorState extends State<HotReloadIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _showIndicator = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    if (kDebugMode) {
      // Show indicator briefly when widget is created (might be due to hot reload)
      _showHotReloadIndicator();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showHotReloadIndicator() {
    setState(() => _showIndicator = true);
    _animationController.forward();
    
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _animationController.reverse().then((_) {
          if (mounted) {
            setState(() => _showIndicator = false);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (widget.child != null) widget.child!,
        if (_showIndicator && kDebugMode)
          Positioned(
            top: MediaQuery.of(context).padding.top + 50,
            left: 20,
            child: FadeTransition(
              opacity: _animationController,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.flash_on, color: Colors.white, size: 16),
                    SizedBox(width: 4),
                    Text(
                      'Hot Reloaded',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Const widget wrapper to optimize hot reload
class ConstWidget extends StatelessWidget {
  const ConstWidget({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) => child;
}

/// Helper to create const widgets easily
Widget constWidget(Widget child) {
  return ConstWidget(child: child);
}
