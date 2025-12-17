import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../logic/security_provider.dart';


class ActivityLogScreen extends ConsumerWidget {
  const ActivityLogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsAsync = ref.watch(logsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Logs'),
      ),
      body: logsAsync.when(
        data: (logs) => ListView.builder(
          itemCount: logs.length,
          itemBuilder: (context, index) {
            final log = logs[index];
            return ListTile(
              leading: Icon(
                log.status == 'FAILED'
                    ? Icons.warning
                    : Icons.check_circle,
                color: log.status == 'FAILED'
                    ? Colors.red
                    : Colors.green,
              ),
              title: Text(log.action),
              subtitle: Text(
                '${log.userId} • ${log.timestamp}',
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Text('Error loading logs: $e'),
        ),
      ),
    );
  }
}