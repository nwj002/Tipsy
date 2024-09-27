// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_current_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCurrentUserDto _$GetCurrentUserDtoFromJson(Map<String, dynamic> json) =>
    GetCurrentUserDto(
      id: json['_id'] as String,
      email: json['email'] as String,
      fullname: json['fullname'] as String,
      age: (json['age'] as num).toInt(),
      username: json['username'] as String,
      password: json['password'] as String,
      phone: (json['phone'] as num).toInt(),
    );

Map<String, dynamic> _$GetCurrentUserDtoToJson(GetCurrentUserDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'fullname': instance.fullname,
      'age': instance.age,
      'username': instance.username,
      'password': instance.password,
      'phone': instance.phone,
    };
