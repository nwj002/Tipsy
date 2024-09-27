class ForgotPasswordState {
  final String? error;
  final bool isLoading;
  final bool isSent;
  final bool otpVerified;
  final bool passwordChanged;
 
  ForgotPasswordState({
    required this.error,
    required this.isLoading,
    required this.isSent,
    required this.otpVerified,
    required this.passwordChanged,
  });
 
  factory ForgotPasswordState.initial() {
    return ForgotPasswordState(
      error: null,
      isLoading: false,
      isSent: false,
      otpVerified: false,
      passwordChanged: false,
    );
  }
 
  ForgotPasswordState copyWith({
    String? error,
    bool? isLoading,
    bool? isSent,
    bool? otpVerified,
    bool? passwordChanged,
  }) {
    return ForgotPasswordState(
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      isSent: isSent ?? this.isSent,
      otpVerified: otpVerified ?? this.otpVerified,
      passwordChanged: passwordChanged ?? this.passwordChanged,
    );
  }
}