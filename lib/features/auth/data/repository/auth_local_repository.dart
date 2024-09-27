import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/core/failure/failure.dart';
import 'package:liquor_ordering_system/features/auth/data/data_source/local/auth_local_data_source.dart';
import 'package:liquor_ordering_system/features/auth/domain/entity/auth_entity.dart';
import 'package:liquor_ordering_system/features/auth/domain/repository/auth_repository.dart';

final authLocalRepositoryProvider = Provider<IAuthRepository>((ref) {
  return AuthLocalRepository(
    ref.read(authLocalDataSourceProvider),
  );
});

class AuthLocalRepository implements IAuthRepository {
  final AuthLocalDataSource _authLocalDataSource;

  AuthLocalRepository(this._authLocalDataSource);

  @override
  Future<Either<Failure, bool>> loginUser(String username, String password) {
    return _authLocalDataSource.loginUser(username, password);
  }

  @override
  Future<Either<Failure, bool>> registerUser(AuthEntity user) {
    return _authLocalDataSource.registerUser(user);
  }

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> updateUser(AuthEntity user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> verifyUser() {
    // TODO: implement verifyUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> resetPass(
      {required String phone,
      required String newPassword,
      required String otp}) {
    // TODO: implement resetPass
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> sendOtp(String phone) {
    // TODO: implement sendOtp
    throw UnimplementedError();
  }
}
