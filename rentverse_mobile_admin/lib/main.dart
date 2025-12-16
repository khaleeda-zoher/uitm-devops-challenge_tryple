import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentverse_mobile_admin/features/security/ui/admin_main_dashboard.dart';
import 'package:rentverse_mobile_admin/features/security/ui/anomaly_alert_screen.dart';
import 'features/security/ui/activity_log_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: AlertScreen(),
      home: AdminDashboardScreen(),
    );
  }
}
