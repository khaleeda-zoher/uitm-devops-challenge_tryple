import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/alert_model.dart';

class AlertService {
  static const String baseUrl = 'http://localhost:3000/security/anomaly';

  // Fetch alerts from backend
  static Future<List<Alert>> getAlerts() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJhZG1pbi0wMDEiLCJlbWFpbCI6ImFkbWluQHRlc3QuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNzY1Nzc4MTU1LCJleHAiOjE3NjYzODI5NTV9.aKhI1itggqtl05kqEVXUnuqDl9VbCwCLfMzYf__rs3E', // replace with dynamic token
        },
      );

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data.map((json) => Alert.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load alerts: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching alerts: $e');
    }
  }
}
