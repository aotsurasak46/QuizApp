class Users {
  final String email;
  final String status;
  final double progress;
  final bool online; // New field for online status

  Users({
    required this.email,
    required this.status,
    required this.progress,
    required this.online, // Include the online status field
  });

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      email: map['email'] ?? '',
      status: map['status'] ?? 'not started',
      progress: map['progress'] ?? 0,
      online: map['online'] ?? false, // Initialize online status
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'status': status,
      'progress': progress,
      'online': online, // Include online status in the map
    };
  }
}
