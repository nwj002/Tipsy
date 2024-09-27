// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthApiModel _$AuthApiModelFromJson(Map<String, dynamic> json) => AuthApiModel(
      id: json['_id'] as String,
      fullname: json['fullname'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      age: (json['age'] as num).toInt(),
      phone: (json['phone'] as num).toInt(),
    );

Map<String, dynamic> _$AuthApiModelToJson(AuthApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'fullname': instance.fullname,
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'age': instance.age,
      'phone': instance.phone,
    };
