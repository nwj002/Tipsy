import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/core/failure/failure.dart';
import 'package:liquor_ordering_system/features/home/domain/entity/cart_entity.dart';
import 'package:liquor_ordering_system/features/home/domain/repository/i_cart_repository.dart';

final cartUsecaseProvider = Provider<CartUsecase>((ref) {
  final cartRepository = ref.watch(cartRepositoryProvider);
  return CartUsecase(cartRepository: cartRepository);
});

class CartUsecase {
  final ICartRepository cartRepository;

  CartUsecase({required this.cartRepository});

  Future<Either<Failure, List<CartEntity>>> getCarts() async {
    return cartRepository.getCarts();
  }

  Future<Either<Failure, bool>> addCart(
      String? productID, int? quantity) async {
    return cartRepository.addCart(
      productID ?? '',
      quantity ?? 0,
    );
  }

  Future<Either<Failure, bool>> clearCart() async {
    return cartRepository.clearCart();
  }

  Future<Either<Failure, bool>> changeStatus() async {
    return cartRepository.changeStatus();
  }
}
