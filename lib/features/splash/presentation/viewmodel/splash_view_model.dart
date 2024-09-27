import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/features/splash/presentation/navigator/splash_navigator.dart';

final splashViewModelProvider =
    StateNotifierProvider<SplashViewModel, void>((ref) {
  final navigator = ref.read(splashViewNavigatorProvider);
  return SplashViewModel(navigator);
});

class SplashViewModel extends StateNotifier<void> {
  SplashViewModel(this.navigator) : super(null);

  final SplashViewNavigator navigator;

  // Later on we will add open home page method here as well
  void openHomeView() {
    // Your code goes here
  }

  void openOnboardingView() {
    Future.delayed(const Duration(seconds: 3), () {
      navigator.openOnBoarding();
    });
  }
}
