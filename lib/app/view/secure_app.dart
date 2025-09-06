import 'package:flutter/material.dart';
import 'package:shemanit/features/security/security_widget_simple.dart';
import 'package:shemanit/app/view/app.dart';

/// Simplified secure app wrapper
class SecureApp extends StatelessWidget {
  const SecureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimpleSecurityWrapper(
      child: App(),
    );
  }
}
