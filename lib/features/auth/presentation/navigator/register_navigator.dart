import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/app/navigator/navigator.dart';
import 'package:liquor_ordering_system/features/auth/presentation/navigator/login_navigator.dart';
import 'package:liquor_ordering_system/features/auth/presentation/view/register_view.dart';

final registerViewNavigatorProvider =
    Provider((ref) => RegisterViewNavigator());

class RegisterViewNavigator with LoginViewRoute {}

mixin RegisterViewRoute {
  openRegisterView() {
    NavigateRoute.pushRoute(const RegisterView());
  }
}
