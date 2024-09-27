// provide cart navigator code here

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/app/navigator/navigator.dart';
import 'package:liquor_ordering_system/features/auth/presentation/navigator/login_navigator.dart';
import 'package:liquor_ordering_system/features/home/presentation/view/bottom_view/cart_view.dart';
import 'package:liquor_ordering_system/features/home/presentation/view/home_view.dart';

final cartViewNavigatorProvider = Provider<CartViewNavigator>((ref) {
  return CartViewNavigator();
});

class CartViewNavigator with LoginViewRoute {}

mixin CartViewRoute {
  openCartView() {
    NavigateRoute.popAndPushRoute(const CartView());
  }
}
