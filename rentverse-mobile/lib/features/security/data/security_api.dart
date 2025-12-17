import 'package:dio/dio.dart';
import 'package:rentverse_mobile/features/security/data/alert_model.dart';
import 'activity_log_model.dart';

class SecurityApi {
  final Dio _dio;

  SecurityApi(this._dio);

  Future<List<ActivityLog>> fetchLogs() async {
    final response = await _dio.get('/security/logs');

    final List data = response.data['data'];

    return data.map((e) => ActivityLog.fromJson(e)).toList();
  }

  Future<List<Alert>> fetchAlerts() async {
  final response = await _dio.get('/alerts');
  final List data = response.data['data'];
  return data.map((e) => Alert.fromJson(e)).toList();
}

Future<Alert> createAlert(Map<String, dynamic> payload) async {
  final response = await _dio.post('/alerts', data: payload);
  return Alert.fromJson(response.data['data']);
}

Future<Alert> markAlertAsRead(int id) async {
  final response = await _dio.patch('/alerts/$id/read');
  return Alert.fromJson(response.data['data']);
}

Future<Map<String, dynamic>> detectAnomaly(Map<String, dynamic> payload) async {
  final response = await _dio.post('/security/anomaly', data: payload);
  return response.data;
}
Future<Map<String, dynamic>> sendAnomaly(Map<String, dynamic> payload) async {
  final response = await _dio.post('/security/anomaly', data: payload);
  return response.data;
}


  

}