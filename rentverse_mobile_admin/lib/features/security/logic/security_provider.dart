import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentverse_mobile_admin/features/security/data/alert_model.dart';
import '../../../core/network/dio_client.dart';
import '../data/security_api.dart';
import '../data/activity_log_model.dart';

// TEMP: hardcoded token for now
const mockAccessToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJhZG1pbi0wMDEiLCJlbWFpbCI6ImFkbWluQHRlc3QuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzY1Nzc4MTU1LCJleHAiOjE3NjYzODI5NTV9.aKhI1itggqtl05kqEVXUnuqDl9VbCwCLfMzYf__rs3E';

final securityApiProvider = Provider<SecurityApi>((ref) {
  final dio = DioClient.createDio(mockAccessToken);
  return SecurityApi(dio);
});

final logsProvider = FutureProvider<List<ActivityLog>>((ref) {
  return ref.read(securityApiProvider).fetchLogs();
});

final alertsProvider = FutureProvider<List<Alert>>((ref) {
  return ref.read(securityApiProvider).fetchAlerts();
});

final anomalyProvider = FutureProvider.family<Map<String, dynamic>, Map<String, dynamic>>((ref, payload) {
  return ref.read(securityApiProvider).detectAnomaly(payload);
});


/// Optional: Notifier to refresh alerts after marking as read
/*final alertsNotifierProvider =
    StateNotifierProvider<AlertsNotifier, List<Alert>>((ref) {
  return AlertsNotifier(ref.read);
});

class AlertsNotifier extends StateNotifier<List<Alert>> {
  final Reader read;
  AlertsNotifier(this.read) : super([]);

  Future<void> loadAlerts() async {
    final alerts = await read(securityApiProvider).fetchAlerts();
    state = alerts;
  }

  Future<void> markAsRead(int alertId) async {
    await read(securityApiProvider).markAlertAsRead(alertId);
    await loadAlerts(); // refresh list
  }
}*/
