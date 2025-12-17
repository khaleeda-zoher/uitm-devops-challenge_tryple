class ActivityLog {
  final int id; // ✅ correct
  final String userId;
  final String action;
  final String status;
  final String ipAddress;
  final String userAgent;
  final DateTime timestamp;

  ActivityLog({
    required this.id,
    required this.userId,
    required this.action,
    required this.status,
    required this.ipAddress,
    required this.userAgent,
    required this.timestamp,
  });

  factory ActivityLog.fromJson(Map<String, dynamic> json) {
    return ActivityLog(
      id: json['id'] as int,
      userId: json['user_id'] as String,
      action: json['action'] as String,
      status: json['status'] as String,
      ipAddress: json['ip_address'] as String,
      userAgent: json['user_agent'] as String,
      timestamp: DateTime.parse(json['created_at']),
    );
  }
}