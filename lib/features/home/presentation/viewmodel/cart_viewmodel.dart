import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/core/shared_prefs/user_shared_prefs.dart';
import 'package:liquor_ordering_system/features/home/domain/usecases/cart_usecase.dart';
import 'package:liquor_ordering_system/features/home/presentation/state/cart_state.dart';
import 'package:liquor_ordering_system/features/orders/domain/entity/order_entity.dart';
import 'package:liquor_ordering_system/features/orders/domain/usecases/order_usecase.dart';

final cartViewModelProvider =
    StateNotifierProvider<CartViewModel, CartState>((ref) => CartViewModel(
          cartUsecase: ref.watch(cartUsecaseProvider),
          userSharedPrefs: ref.watch(userSharedPrefsProvider),
          orderUsecase: ref.read(orderUsecaseProvider),

          // navigator: ref.watch(cartViewNavigatorProvider),
        ));

class CartViewModel extends StateNotifier<CartState> {
  CartViewModel({
    required this.cartUsecase,
    required this.userSharedPrefs,
    required this.orderUsecase,
    // required this.navigator,
  }) : super(CartState.initial());

  final CartUsecase cartUsecase;
  final OrderUsecase orderUsecase;

  final UserSharedPrefs userSharedPrefs;
  // final CartViewNavigator navigator;

  //get cart
  Future<void> getCarts() async {
    state = state.copyWith(isLoading: true);
    final result = await cartUsecase.getCarts();
    var data = await cartUsecase.getCarts();
    data.fold((failure) {
      state = state.copyWith(isLoading: false, error: failure.error);
      // showMySnackBar(message: failure.error, color: Colors.red);
    }, (success) {
      state = state.copyWith(isLoading: false, error: null, products: success);
      // showMySnackBar(message: 'Cart fetched successfully', color: Colors.green);
    });
  }

  //add cart
  Future<void> addCart(String productID, int quantity) async {
    state = state.copyWith(isLoading: true);
    final result = await cartUsecase.addCart(productID, quantity);
    result.fold((failure) {
      state = state.copyWith(isLoading: false, error: failure.error);
      // showMySnackBar(message: failure.error, color: Colors.red);
    }, (success) {
      state = state.copyWith(
        isLoading: false,
        error: null,
      );
      // showMySnackBar(message: 'Product added to cart', color: Colors.green);
    });
    getCarts();
  }

  // Change status of cart to 'checked out'
  Future<void> changeStatus() async {
    state = state.copyWith(isLoading: true);
    print('Changing status of cart...');
    final result = await cartUsecase.changeStatus();

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        print('Change Status Error: ${failure.error}');
      },
      (success) {
        state = state.copyWith(
          products: [],
          isLoading: false,
        );
        print('Cart status changed successfully.');
      },
    );
  }

  Future<void> checkoutCart(
      String paymentMethod, double total, String address) async {
    state = state.copyWith(isLoading: true);
    print('Checking out cart...');
    final order = OrderEntity(
      carts: state.products,
      total: total,
      address: address,
      paymentType: paymentMethod,
    );
    final result = await orderUsecase.createOrder(order);

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        print('Checkout Cart Error: ${failure.error}');
      },
      (success) async {
        state = state.copyWith(
          products: [],
          isLoading: false,
        );
        await changeStatus();
        print('Cart checked out successfully.');
      },
    );
  }

  Future<void> clearCart() async {
    state = state.copyWith(isLoading: true);
    print('Clearing cart...');
    final result = await cartUsecase.clearCart();

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        print('Clear Cart Error: ${failure.error}');
      },
      (success) {
        state = state.copyWith(
          products: [],
          isLoading: false,
        );
        print('Cart cleared successfully.');
      },
    );
  }
}
