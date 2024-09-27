import 'package:json_annotation/json_annotation.dart';
import 'package:liquor_ordering_system/features/auth/domain/entity/auth_entity.dart';

part 'get_current_user_dto.g.dart';

@JsonSerializable()
class GetCurrentUserDto {
  @JsonKey(name: "_id")
  final String id;
  final String email;
  final String fullname;
  final int age;
  final String username;
  final String password;
  final int phone;

  GetCurrentUserDto({
    required this.id,
    required this.email,
    required this.fullname,
    required this.age,
    required this.username,
    required this.password,
    required this.phone,
  });

  AuthEntity toEntity() {
    return AuthEntity(
      id: id,
      email: email,
      fullname: fullname,
      age: age,
      username: username,
      password: password,
      phone: phone,
    );
  }

  factory GetCurrentUserDto.fromJson(Map<String, dynamic> json) =>
      _$GetCurrentUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetCurrentUserDtoToJson(this);
}
