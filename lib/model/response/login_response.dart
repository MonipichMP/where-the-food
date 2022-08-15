class AuthResponse {
  final String? userId;
  final String? fullName;
  final DateTime? dateOfBirth;
  final String? token;

  AuthResponse({
    this.userId,
    this.fullName,
    this.dateOfBirth,
    this.token,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        userId: json['userId'],
        fullName: json['fullName'],
        dateOfBirth: json["dateOfBirth"] == null ? null : DateTime.parse(json["dateOfBirth"]),
        token: json['token'],
      );
}
