import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/core/failure/failure.dart';
import 'package:liquor_ordering_system/features/auth/domain/entity/auth_entity.dart';
import 'package:liquor_ordering_system/features/auth/domain/repository/auth_repository.dart';

final authUseCaseProvider = Provider((ref) {
  return AuthUseCase(ref.read(authRepositoryProvider));
});

class AuthUseCase {
  final IAuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  Future<Either<Failure, bool>> registerUser(AuthEntity? user) async {
    return await _authRepository.registerUser(user!);
  }

  Future<Either<Failure, bool>> loginUser(
      String? email, String? password) async {
    return await _authRepository.loginUser(email ?? "", password ?? "");
  }

  Future<Either<Failure, bool>> sendOtp(String phone) async {
    return await _authRepository.sendOtp(phone);
  }

  Future<Either<Failure, bool>> resetPass(
      {String? phone, String? newPassword, String? otp}) async {
    return await _authRepository.resetPass(
        phone: phone ?? "", newPassword: newPassword ?? "", otp: otp ?? "");
  }

  Future<Either<Failure, AuthEntity>> getCurrentUser() {
    return _authRepository.getCurrentUser();
  }
}
