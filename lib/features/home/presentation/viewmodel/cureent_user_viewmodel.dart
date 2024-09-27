import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/core/shared_prefs/user_shared_prefs.dart';
import 'package:liquor_ordering_system/features/auth/domain/usecases/auth_use_case.dart';
import 'package:liquor_ordering_system/features/home/presentation/navigator/profile_navigator.dart';
import 'package:liquor_ordering_system/features/home/presentation/state/current_user_state.dart';
import 'package:local_auth/local_auth.dart';

final currentUserViewModelProvider =
    StateNotifierProvider<CurrentUserViewModel, CurrentUserState>(
  (ref) => CurrentUserViewModel(
    navigator: ref.read(profileNavigatorProvider),
    authUseCase: ref.read(authUseCaseProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class CurrentUserViewModel extends StateNotifier<CurrentUserState> {
  final AuthUseCase authUseCase;
  late LocalAuthentication _localAuth;
  final UserSharedPrefs userSharedPrefs;
  final ProfileNavigator navigator;

  CurrentUserViewModel({
    required this.navigator,
    required this.authUseCase,
    required this.userSharedPrefs,
  }) : super(CurrentUserState.initial()) {
    initialize();
  }

  Future<void> initialize() async {
    _localAuth = LocalAuthentication();
    await getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    try {
      state = state.copyWith(isLoading: true);

      final data = await authUseCase.getCurrentUser();

      data.fold(
        (l) {
          state = state.copyWith(isLoading: false, error: l.error);
          print('Error fetching current user: ${l.error}'); // Debug statement
        },
        (r) {
          print('Current user: $r'); // Debug statement
          state = state.copyWith(isLoading: false, authEntity: r);
        },
      );
    } catch (e) {
      state = state.copyWith(
          isLoading: false, error: 'Failed to fetch current user.');
      print('Error fetching current user: $e'); // Debug statement
    }
  }

  void logout() {
    userSharedPrefs.deleteUserToken();
    navigator.openLoginView();
  }

  // Open Login page
  void openPlaceOrderView() {
    Future.delayed(const Duration(seconds: 3), () {
      navigator.openPlaceOrderView();
    });
  }
}
