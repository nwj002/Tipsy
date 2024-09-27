import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/features/onboarding/presentation/navigator/oboarding_navigator.dart';

final onboardingViewModelProvider =
    StateNotifierProvider<OnboardingViewModel, void>((ref) {
  final navigator = ref.read(onboardingViewNavigatorProvider);
  return OnboardingViewModel(navigator);
});

class OnboardingViewModel extends StateNotifier<void> {
  OnboardingViewModel(this.navigator) : super(null);

  final OnboardingViewNavigator navigator;

  // Open Login page
  void openLoginView() {
    navigator.openLoginView();
  }
}
