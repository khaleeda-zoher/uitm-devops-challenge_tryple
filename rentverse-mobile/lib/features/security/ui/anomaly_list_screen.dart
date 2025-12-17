import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../logic/security_provider.dart';
import 'anomaly_card_details.dart';

class AnomalyListScreen extends ConsumerWidget {
  const AnomalyListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alerts = ref.watch(alertsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rentverse Admin Dashboard',
          style: TextStyle(
            color: Colors.white,       // White text
            fontWeight: FontWeight.bold, // Bold text
          ),
        ),
        centerTitle: true, // Center the title
        backgroundColor: const Color.fromARGB(255, 45, 113, 87),
        elevation: 4,
      ),
      body: alerts.isEmpty
          ? const Center(child: Text('No anomaly alerts yet.'))
          : ListView.builder(
              itemCount: alerts.length,
              itemBuilder: (context, index) {
                final alert = alerts[index];
                Color severityColor;
                switch (alert.severity) {
                  case 'HIGH':
                    severityColor = Colors.red;
                    break;
                  case 'MEDIUM':
                    severityColor = Colors.orange;
                    break;
                  default:
                    severityColor = Colors.blue;
                }

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  elevation: 2,
                  child: ListTile(
                    leading: Icon(Icons.warning, color: severityColor),
                    title: Text(alert.message),
                    subtitle: Text('${alert.userId} • ${alert.createdAt.toLocal()}'),
                    trailing: alert.read
                        ? const Icon(Icons.check, color: Colors.green)
                        : null,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AnomalyCardScreen(alert: alert),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}