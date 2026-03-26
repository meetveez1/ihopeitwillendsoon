import 'app_enums.dart';

class User {
  final String firstName;
  final String lastName;
  final String email;
  final UserRole role;

  const User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
  });

  String get fullName => '$firstName $lastName';

  User copyWith({
    String? firstName,
    String? lastName,
    String? email,
    UserRole? role,
  }) {
    return User(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'role': role.name,
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      role: UserRole.values.firstWhere((e) => e.name == json['role']),
    );
  }
}
