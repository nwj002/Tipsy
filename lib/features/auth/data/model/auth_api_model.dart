import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:liquor_ordering_system/features/auth/domain/entity/auth_entity.dart';

part 'auth_api_model.g.dart';

final authApiModelProvider =
    Provider<AuthApiModel>((ref) => const AuthApiModel.empty());

@JsonSerializable()
class AuthApiModel {
  @JsonKey(name: '_id')
  final String id;
  final String fullname;
  final String username;
  final String email;
  final String password;
  final int age;
  final int phone;

  AuthApiModel({
    required this.id,
    required this.fullname,
    required this.username,
    required this.email,
    required this.password,
    required this.age,
    required this.phone,
  });

  const AuthApiModel.empty()
      : id = '',
        fullname = '',
        username = '',
        email = '',
        password = '',
        age = 0,
        phone = 0;

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      id: id,
      fullname: fullname,
      username: username,
      email: email,
      password: password,
      age: age,
      phone: phone,
    );
  }
}
