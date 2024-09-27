import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/core/failure/failure.dart';
import 'package:liquor_ordering_system/features/home/data/repository/cart_remote_repository.dart';
import 'package:liquor_ordering_system/features/home/domain/entity/cart_entity.dart';

final cartRepositoryProvider =
    Provider<ICartRepository>((ref) => ref.read(cartRemoteRepositoryProvider));

abstract class ICartRepository {
  Future<Either<Failure, List<CartEntity>>> getCarts();

  Future<Either<Failure, bool>> addCart(String productID, int quantity);

  Future<Either<Failure, bool>> clearCart();

  Future<Either<Failure, bool>> changeStatus();
}
