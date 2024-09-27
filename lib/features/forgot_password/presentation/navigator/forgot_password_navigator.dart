
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/app/navigator/navigator.dart';
import 'package:liquor_ordering_system/features/auth/presentation/navigator/login_navigator.dart';
import 'package:liquor_ordering_system/features/forgot_password/presentation/view/forgot_password_view.dart';
 
final forgetPasswordViewNavigatorProvider =
    Provider((ref) => ForgotPasswordViewNavigator());
 
class ForgotPasswordViewNavigator with LoginViewRoute {}
 
mixin ForgotPasswordViewRoute {
  openForgotPasswordView() {
    NavigateRoute.popAndPushRoute(const ForgetPasswordView());
  }
}
 