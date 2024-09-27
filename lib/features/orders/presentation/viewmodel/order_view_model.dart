import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/core/common/my_snack_bar.dart';
import 'package:liquor_ordering_system/features/orders/domain/entity/order_entity.dart';
import 'package:liquor_ordering_system/features/orders/domain/usecases/order_usecase.dart';
import 'package:liquor_ordering_system/features/orders/presentation/state/order_state.dart';

final orderViewModelProvider =
    StateNotifierProvider<OrderViewModel, OrderState>(
  (ref) => OrderViewModel(
    orderUsecase: ref.read(orderUsecaseProvider),
  ),
);

class OrderViewModel extends StateNotifier<OrderState> {
  OrderViewModel({required this.orderUsecase}) : super(OrderState.initial()) {
    fetchOrders();
  }

  final OrderUsecase orderUsecase;

  Future fetchOrders() async {
    state = state.copyWith(isLoading: true);
    final result = await orderUsecase.getOrder();
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        mySnackBar(message: failure.error, color: Colors.red);
      },
      (data) => state = state.copyWith(
        isLoading: false,
        orders: data,
        error: null,
      ),
    );
  }

  void addOrder(OrderEntity order) {
    final updatedOrders = List<OrderEntity>.from(state.orders)..add(order);
    state = state.copyWith(orders: updatedOrders);
    mySnackBar(message: 'Order placed successfully', color: Colors.green);
  }
}
