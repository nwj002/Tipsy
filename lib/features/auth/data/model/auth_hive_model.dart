import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:liquor_ordering_system/app/constants/hive_table_constant.dart';
import 'package:liquor_ordering_system/features/auth/domain/entity/auth_entity.dart';
import 'package:uuid/uuid.dart';

part 'auth_hive_model.g.dart';

final authHiveModelProvider = Provider(
  (ref) => AuthHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.userTableId)
class AuthHiveModel {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String fullname;

  @HiveField(2)
  final String username;

  @HiveField(3)
  final int age;

  @HiveField(4)
  final String email;

  @HiveField(5)
  final String password;

  @HiveField(6)
  final int phone;

  // Constructor
  AuthHiveModel({
    String? userId,
    required this.fullname,
    required this.username,
    required this.age,
    required this.email,
    required this.password,
    required this.phone,
  }) : userId = userId ?? const Uuid().v4();

  // empty constructor
  AuthHiveModel.empty()
      : this(
          userId: '',
          fullname: '',
          username: '',
          age: 0,
          email: '',
          password: '',
          phone: 0,
        );

  // Convert Hive Object to Entity
  AuthEntity toEntity() => AuthEntity(
        id: userId,
        fullname: fullname,
        username: username,
        age: age,
        email: email,
        password: password,
        phone: phone,
      );

  // Convert Entity to Hive Object
  AuthHiveModel toHiveModel(AuthEntity entity) => AuthHiveModel(
        userId: const Uuid().v4(),
        fullname: entity.fullname,
        username: entity.username,
        age: entity.age,
        email: entity.email,
        password: entity.password,
        phone: entity.phone,
      );

  // Convert Entity List to Hive List
  List<AuthHiveModel> toHiveModelList(List<AuthEntity> entities) =>
      entities.map((entity) => toHiveModel(entity)).toList();

  @override
  String toString() {
    return 'userId: $userId, fullname: $fullname, username: $username, age: $age, email: $email, password: $password, phone: $phone';
  }
}
