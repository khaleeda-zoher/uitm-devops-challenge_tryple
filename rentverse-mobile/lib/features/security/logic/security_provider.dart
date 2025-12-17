import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart' show StateNotifier, StateNotifierProvider;
import 'package:rentverse_mobile_admin/features/security/data/alert_model.dart';
import '../../../core/network/dio_client.dart';
import '../data/security_api.dart';
import '../data/activity_log_model.dart';


const mockAccessToken =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJhZG1pbi0wMDEiLCJlbWFpbCI6ImFkbWluQHRlc3QuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzY1Nzc4MTU1LCJleHAiOjE3NjYzODI5NTV9.aKhI1itggqtl05kqEVXUnuqDl9VbCwCLfMzYf__rs3E';

final securityApiProvider = Provider<SecurityApi>((ref) {
  final dio = DioClient.createDio(mockAccessToken);
  return SecurityApi(dio);
});

/// Logs provider (already done)
final logsProvider = FutureProvider<List<ActivityLog>>((ref) async {
  final logs = await ref.read(securityApiProvider).fetchLogs();

  // auto anomaly detection
  ref.read(alertsProvider.notifier).evaluateLogs(logs);

  return logs;
});

/// Alerts StateNotifier
class AlertsNotifier extends StateNotifier<List<Alert>> {
  final Ref ref;
  AlertsNotifier(this.ref) : super([]);

  Future<void> loadAlerts() async {
    try {
      final alerts = await ref.read(securityApiProvider).fetchAlerts();
      state = alerts;
    } catch (e) {
      print('Failed to load alerts: $e');
    }
  }

  /// Smart evaluation: avoid duplicate alerts
/// Smart evaluation: generate alerts for all relevant logs
Future<void> evaluateLogs(List<ActivityLog> logs) async {
  final Map<String, int> failedLoginCount = {};
  final Map<String, List<ActivityLog>> successfulLogins = {};

  final List<Alert> newAlerts = [];

  for (final log in logs) {
    // 🔹 Failed login count
    if (log.status == 'FAILED' && log.action == 'LOGIN') {
      failedLoginCount[log.userId] =
          (failedLoginCount[log.userId] ?? 0) + 1;
    }

    // 🔹 Collect successful logins for unusual IP / multiple logins
    if (log.status == 'SUCCESS' && log.action == 'LOGIN') {
      successfulLogins[log.userId] ??= [];
      successfulLogins[log.userId]!.add(log);
    }
  }

  // High severity: 3+ failed logins
  failedLoginCount.forEach((userId, count) {
    if (count >= 3) {
      final exists = state.any((a) =>
          a.userId == userId && a.type == 'LOGIN_FAILURE');
      if (!exists) {
        final lastFailedLog = logs.lastWhere(
            (l) => l.userId == userId && l.status == 'FAILED');
        newAlerts.add(Alert(
          id: DateTime.now().millisecondsSinceEpoch,
          userId: userId,
          type: 'LOGIN_FAILURE',
          message: 'User $userId failed login $count times from ${lastFailedLog.ipAddress}',
          severity: 'HIGH',
          createdAt: DateTime.now(),
          read: false,
          payload: {
            'last_failed_ip': lastFailedLog.ipAddress,
            'timestamp': lastFailedLog.timestamp.toIso8601String(),
          },
        ));
      }
    }
  });

  // Medium severity: unusual IP
  const unusualIPs = ['192.168.1.50', '10.0.0.1'];
  successfulLogins.forEach((userId, logs) {
    final unusualLog = logs.firstWhere(
        (l) => unusualIPs.contains(l.ipAddress),
        orElse: () => ActivityLog(
          id: -1,
          userId: userId,
          action: 'LOGIN',
          status: 'SUCCESS',
          ipAddress: '',
          userAgent: '',
          timestamp: DateTime.now(),
      ),
    );
    if (unusualLog.id != -1) {
      // ✅ this is a real unusual login
      newAlerts.add(Alert(
        id: DateTime.now().millisecondsSinceEpoch,
        userId: userId,
        type: 'UNUSUAL_LOGIN',
        message: 'User $userId logged in from unusual IP ${unusualLog.ipAddress}',
        severity: 'MEDIUM',
        createdAt: DateTime.now(),
        read: false,
        payload: {
          'ip': unusualLog.ipAddress,
          'timestamp': unusualLog.timestamp.toIso8601String(),
        },
      ));
    }
  });

  // Low severity: multiple logins in short time (>=5)
  successfulLogins.forEach((userId, logs) {
    if (logs.length >= 5) {
      final exists = state.any((a) =>
          a.userId == userId && a.type == 'MULTIPLE_LOGINS');
      if (!exists) {
        newAlerts.add(Alert(
          id: DateTime.now().millisecondsSinceEpoch,
          userId: userId,
          type: 'MULTIPLE_LOGINS',
          message: 'User $userId logged in ${logs.length} times in short period',
          severity: 'LOW',
          createdAt: DateTime.now(),
          read: false,
        ));
      }
    }
  });

  // Add new alerts to state
  if (newAlerts.isNotEmpty) {
    state = [...newAlerts, ...state];
  }
}





  void addAlert(Alert alert) {
    state = [alert, ...state];
  }

  Future<void> markAsRead(int alertId) async {
    try {
      await ref.read(securityApiProvider).markAlertAsRead(alertId);
      state = state.map((a) {
        if (a.id == alertId) {
          return Alert(
            id: a.id,
            userId: a.userId,
            type: a.type,
            message: a.message,
            severity: a.severity,
            createdAt: a.createdAt,
            payload: a.payload,
            read: true,
          );
        }
        return a;
      }).toList();
    } catch (e) {
      print('Failed to mark alert as read: $e');
    }
  }
}


/// Alerts provider
final alertsProvider =
    StateNotifierProvider<AlertsNotifier, List<Alert>>(
        (ref) => AlertsNotifier(ref));

/// Anomaly detection provider (optional, dummy for now)
final anomalyProvider =
    FutureProvider.family<Map<String, dynamic>, Map<String, dynamic>>(
        (ref, payload) {
  return ref.read(securityApiProvider).detectAnomaly(payload);
});
