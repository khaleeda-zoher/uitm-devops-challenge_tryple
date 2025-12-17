import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../logic/security_provider.dart';
//import '../data/alert_model.dart';

class AnomalyAlertScreen extends ConsumerWidget {
  const AnomalyAlertScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alerts = ref.watch(alertsProvider); // this is now List<Alert>

    return Scaffold(
      appBar: AppBar(title: const Text('Anomaly Alerts')),
      body: alerts.isEmpty
          ? const Center(child: Text('No alerts'))
          : ListView.builder(
              itemCount: alerts.length,
              itemBuilder: (context, index) {
                final alert = alerts[index];
                return ListTile(
                  leading: Icon(
                    alert.type == 'LOGIN_FAILURE'
                        ? Icons.warning
                        : Icons.notifications,
                    color: alert.type == 'LOGIN_FAILURE'
                        ? Colors.red
                        : Colors.blue,
                  ),
                  title: Text(alert.message),
                  subtitle:
                      Text('${alert.userId} • ${alert.createdAt.toLocal()}'),
                  trailing: alert.read
                      ? const Icon(Icons.check, color: Colors.green)
                      : TextButton(
                          child: const Text('Mark read'),
                          onPressed: () =>
                              ref.read(alertsProvider.notifier).markAsRead(alert.id),
                        ),
                );
              },
            ),
    );
  }
}