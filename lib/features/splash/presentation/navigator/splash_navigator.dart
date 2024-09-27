import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/features/auth/presentation/navigator/login_navigator.dart';
import 'package:liquor_ordering_system/features/onboarding/presentation/navigator/oboarding_navigator.dart';

final splashViewNavigatorProvider =
    Provider<SplashViewNavigator>((ref) => SplashViewNavigator());

// This class will be used to navigate to LoginView
class SplashViewNavigator with LoginViewRoute , OnboardingViewRoute{}

mixin SplashViewRoute {}
