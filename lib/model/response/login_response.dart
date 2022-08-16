class AuthResponse {
  final String? userId;
  final String? id;
  final String? username;
  final String? fullName;
  final DateTime? dateOfBirth;
  final String? token;

  AuthResponse({
    this.userId,
    this.id,
    this.username,
    this.fullName,
    this.dateOfBirth,
    this.token,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        userId: json['userId'],
        fullName: json['fullName'],
        id: json['_id'],
        username: json['username'],
        dateOfBirth: json["dateOfBirth"] == null ? null : DateTime.parse(json["dateOfBirth"]),
        token: json['token'],
      );
}
