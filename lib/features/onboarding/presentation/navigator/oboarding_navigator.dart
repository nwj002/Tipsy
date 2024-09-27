import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/app/navigator/navigator.dart';
import 'package:liquor_ordering_system/features/auth/presentation/navigator/login_navigator.dart';
import 'package:liquor_ordering_system/features/onboarding/presentation/view/onboarding_view.dart';

final onboardingViewNavigatorProvider =
    Provider<OnboardingViewNavigator>((ref) => OnboardingViewNavigator());

// This class will be used to navigate to LoginView
class OnboardingViewNavigator with LoginViewRoute {}

mixin OnboardingViewRoute {
  openOnBoarding() {
    
    NavigateRoute.popAndPushRoute(const OnboardingView());
  }
}
