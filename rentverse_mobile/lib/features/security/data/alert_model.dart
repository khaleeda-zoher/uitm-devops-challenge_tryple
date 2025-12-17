class Alert {
  final int id;
  final String userId;
  final String type;
  final String message;
  final String severity;
  final DateTime createdAt;
  final bool read;
  final Map<String, dynamic>? payload;

  Alert({
    required this.id,
    required this.userId,
    required this.type,
    required this.message,
    required this.severity,
    required this.createdAt,
    required this.read,
    this.payload,
  });

  factory Alert.fromJson(Map<String, dynamic> json) {
    return Alert(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? '',
      type: json['type'],
      message: json['message'],
      severity: json['severity'] ?? 'LOW',
      createdAt: DateTime.parse(json['createdAt']),
      read: json['read'] ?? false,
      payload: json['payload'],
    );
  }
}