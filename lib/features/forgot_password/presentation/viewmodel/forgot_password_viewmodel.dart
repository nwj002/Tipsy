import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/core/common/my_snack_bar.dart';
import 'package:liquor_ordering_system/features/auth/domain/usecases/auth_use_case.dart';
import 'package:liquor_ordering_system/features/forgot_password/presentation/navigator/forgot_password_navigator.dart';
import 'package:liquor_ordering_system/features/forgot_password/presentation/state/forgot_password_state.dart';

final forgotPasswordViewModelProvider =
    StateNotifierProvider<ForgotPasswordViewModel, ForgotPasswordState>((ref) {
  return ForgotPasswordViewModel(
    authUseCase: ref.watch(authUseCaseProvider),
    navigator: ref.read(forgetPasswordViewNavigatorProvider),
  );
});

class ForgotPasswordViewModel extends StateNotifier<ForgotPasswordState> {
  ForgotPasswordViewModel({
    required this.authUseCase,
    required this.navigator,
  }) : super(ForgotPasswordState.initial());

  final AuthUseCase authUseCase;
  final ForgotPasswordViewNavigator navigator;

  openLoginView() {
    navigator.openLoginView();
  }

  sendOtp(String phone) async {
    state = state.copyWith(isLoading: true);

    var data = await authUseCase.sendOtp(phone);
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
        mySnackBar(message: l.error);
      },
      (r) {
        state = state.copyWith(isLoading: false, isSent: true);
        mySnackBar(message: 'OTP Sent Successfully', color: Colors.green);
      },
    );
  }

  verifyOtp(String otp, String phone, String newPassword) async {
    state = state.copyWith(isLoading: true);

    var data = await authUseCase.resetPass(
      phone: phone,
      newPassword: newPassword,
      otp: otp,
    );
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (r) {
        state = state.copyWith(isLoading: false, isSent: false);

        mySnackBar(
            message: 'Password Changed Successfully', color: Colors.green);
      },
    );
  }
}
