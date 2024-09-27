import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? id;
  final String fullname;
  final int age;
  final String username;
  final String password;
  final String email;
  final int phone;

  const AuthEntity({
    this.id,
    required this.fullname,
    required this.age,
    required this.username,
    required this.password,
    required this.email,
    required this.phone,
  });

  @override
  List<Object?> get props => [
        id,
        fullname,
        age,
        username,
        password,
        email,
        phone,
      ];
}
