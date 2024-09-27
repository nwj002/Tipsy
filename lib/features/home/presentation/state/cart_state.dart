import 'package:liquor_ordering_system/features/home/domain/entity/cart_entity.dart';

class CartState {
  final List<CartEntity> products;
  final bool isLoading;
  final bool hasReachedMax;
  final String? error;

  CartState({
    required this.products,
    required this.isLoading,
    required this.hasReachedMax,
    required this.error,
  });

  factory CartState.initial() {
    return CartState(
      products: [],
      isLoading: false,
      hasReachedMax: false,
      error: null,
    );
  }

  CartState copyWith({
    List<CartEntity>? products,
    bool? isLoading,
    bool? hasReachedMax,
    String? error,
  }) {
    return CartState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      error: error ?? this.error,
    );
  }
}
