import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/core/failure/failure.dart';
import 'package:liquor_ordering_system/features/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:liquor_ordering_system/features/auth/domain/entity/auth_entity.dart';
import 'package:liquor_ordering_system/features/auth/domain/repository/auth_repository.dart';

final authRemoteRepositoryProvider = Provider<IAuthRepository>((ref) {
  return AuthRemoteRepository(
    ref.read(authRemoteDataSourceProvider),
  );
});

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  AuthRemoteRepository(this._authRemoteDataSource);

  @override
  Future<Either<Failure, bool>> loginUser(String email, String password) {
    return _authRemoteDataSource.loginUser(email, password);
  }

  @override
  Future<Either<Failure, bool>> registerUser(AuthEntity user) {
    return _authRemoteDataSource.registerUser(user);
  }

  @override
  Future<Either<Failure, bool>> verifyUser() {
    return _authRemoteDataSource.verifyUser();
  }

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() {
    return _authRemoteDataSource.getMe();
  }

  @override
  Future<Either<Failure, bool>> sendOtp(String phone) {
    return _authRemoteDataSource.sentOtp(phone);
  }

  @override
  Future<Either<Failure, bool>> resetPass(
      {required String phone,
      required String newPassword,
      required String otp}) {
    return _authRemoteDataSource.resetPassword(
        phone: phone, newPassword: newPassword, otp: otp);
  }
}
