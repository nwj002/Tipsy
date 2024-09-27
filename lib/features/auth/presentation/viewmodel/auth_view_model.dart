import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/features/auth/domain/entity/auth_entity.dart';
import 'package:liquor_ordering_system/features/auth/domain/usecases/auth_use_case.dart';
import 'package:liquor_ordering_system/features/auth/presentation/navigator/login_navigator.dart';
import 'package:liquor_ordering_system/features/auth/presentation/state/auth_state.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
  (ref) => AuthViewModel(
    ref.read(loginViewNavigatorProvider),
    ref.read(authUseCaseProvider),
  ),
);

class AuthViewModel extends StateNotifier<AuthState> {
  AuthViewModel(this.navigator, this.authUseCase) : super(AuthState.initial());
  final AuthUseCase authUseCase;
  final LoginViewNavigator navigator;

  Future<void> registerUser(AuthEntity user) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.registerUser(user);
    data.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        // mySnackBar(message: failure.error, color: Colors.red);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        // mySnackBar(message: "Successfully registered");
      },
    );
  }

  Future<void> loginUser(
    String username,
    String password,
  ) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.loginUser(username, password);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        // mySnackBar(message: "Invalid credential", color: Colors.red);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        // mySnackBar(message: "Login successfully");
        openHomeView();
      },
    );
  }

  void openRegisterView() {
    navigator.openRegisterView();
  }

  void openLoginView() {
    navigator.openLoginView();
  }

  void openHomeView() {
    navigator.openHomeView();
  }

  void openForgotPasswordView() {
    navigator.openForgotPasswordView();
  }
}
