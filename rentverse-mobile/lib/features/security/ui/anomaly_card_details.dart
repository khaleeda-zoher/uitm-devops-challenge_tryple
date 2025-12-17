import 'package:flutter/material.dart';
import 'package:rentverse_mobile_admin/features/security/data/alert_model.dart';

class AnomalyCardScreen extends StatelessWidget {
  final Alert alert;

  const AnomalyCardScreen({super.key, required this.alert});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Anomaly Details')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              alert.message,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 12),

            Text('Severity: ${alert.severity}'),
            Text('Time: ${alert.createdAt}'),

            const Divider(height: 32),

            const Text(
              'Payload',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            if (alert.payload != null)
              ...alert.payload!.entries.map(
                (e) => Text('${e.key}: ${e.value}'),
              )
            else
              const Text('No payload data'),
          ],
        ),
      ),
    );
  }
}
