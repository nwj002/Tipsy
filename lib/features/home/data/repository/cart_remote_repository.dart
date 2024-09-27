import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/core/failure/failure.dart';
import 'package:liquor_ordering_system/features/home/data/data_source/remote/cart_remote_data_source.dart';
import 'package:liquor_ordering_system/features/home/domain/entity/cart_entity.dart';
import 'package:liquor_ordering_system/features/home/domain/repository/i_cart_repository.dart';

final cartRemoteRepositoryProvider = Provider<ICartRepository>((ref) {
  final cartRemoteDataSource = ref.watch(cartRemoteDataSourceProvider);
  return CartRemoteRepository(cartRemoteDataSource: cartRemoteDataSource);
});

class CartRemoteRepository implements ICartRepository {
  final CartRemoteDataSource cartRemoteDataSource;

  CartRemoteRepository({required this.cartRemoteDataSource});

  @override
  Future<Either<Failure, List<CartEntity>>> getCarts() {
    return cartRemoteDataSource.getCarts();
  }

  @override
  Future<Either<Failure, bool>> addCart(String productID, int quantity) {
    return cartRemoteDataSource.addToCart(
      productID: productID,
      quantity: quantity,
    );
  }

  @override
  Future<Either<Failure, bool>> clearCart() async {
    return cartRemoteDataSource.clearCart();
  }

  @override
  Future<Either<Failure, bool>> changeStatus() {
    return cartRemoteDataSource.changeStatus();
  }
}
