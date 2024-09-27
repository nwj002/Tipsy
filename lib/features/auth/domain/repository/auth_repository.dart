import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/core/failure/failure.dart';
import 'package:liquor_ordering_system/features/auth/data/repository/auth_remote_repository.dart';
import 'package:liquor_ordering_system/features/auth/domain/entity/auth_entity.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  return ref.read(authRemoteRepositoryProvider);
});

abstract class IAuthRepository {
  Future<Either<Failure, bool>> registerUser(AuthEntity user);
  Future<Either<Failure, bool>> loginUser(String email, String password);
  Future<Either<Failure, bool>> sendOtp(String phone);
  Future<Either<Failure, bool>> resetPass(
      {required String phone,
      required String newPassword,
      required String otp});

  Future<Either<Failure, AuthEntity>> getCurrentUser();
}
