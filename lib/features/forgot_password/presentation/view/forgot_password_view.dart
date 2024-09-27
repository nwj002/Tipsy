import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/features/forgot_password/presentation/viewmodel/forgot_password_viewmodel.dart';

class ForgetPasswordView extends ConsumerStatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  _ForgetPasswordViewState createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends ConsumerState<ForgetPasswordView> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  int _timer = 0;

  @override
  Widget build(BuildContext context) {
    final forgotPasswordState = ref.watch(forgotPasswordViewModelProvider);
    final forgotPasswordViewModel =
        ref.read(forgotPasswordViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              ref
                  .read(forgotPasswordViewModelProvider.notifier)
                  .openLoginView();
            },
            icon: const Icon(CupertinoIcons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Headings
              Text(
                'Forget Password',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'Enter your phone number to reset your password',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 16 * 2),

              // Phone Number Field
              TextFormField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              const SizedBox(height: 16),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: forgotPasswordState.isLoading
                      ? null
                      : () {
                          final phoneNumber =
                              _phoneNumberController.text.trim();
                          if (phoneNumber.isNotEmpty) {
                            forgotPasswordViewModel.sendOtp(phoneNumber);
                            _startTimer();
                          }
                        },
                  child: forgotPasswordState.isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Submit'),
                ),
              ),

              if (forgotPasswordState.isSent) ...[
                const SizedBox(height: 16 * 2),
                Text(
                  'Enter the OTP sent to your phone number',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _otpController,
                  decoration: const InputDecoration(
                    labelText: 'OTP',
                    prefixIcon: Icon(Icons.security),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Enter your new password',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'New Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: forgotPasswordState.isLoading
                        ? null
                        : () {
                            final otp = _otpController.text.trim();
                            final newPassword = _passwordController.text.trim();
                            final confirmPassword =
                                _confirmPasswordController.text.trim();
                            if (otp.isNotEmpty &&
                                newPassword.isNotEmpty &&
                                newPassword == confirmPassword) {
                              forgotPasswordViewModel.verifyOtp(
                                otp,
                                _phoneNumberController.text.trim(),
                                newPassword,
                              );
                            }
                          },
                    child: forgotPasswordState.isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Verify OTP and Change Password'),
                  ),
                ),
              ],

              if (forgotPasswordState.passwordChanged) ...[
                const SizedBox(height: 16 * 2),
                const Text(
                  'Your password has been changed successfully!',
                  style: TextStyle(color: Colors.green, fontSize: 16),
                ),
              ],

              if (forgotPasswordState.error != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    forgotPasswordState.error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              if (_timer > 0) _buildTimerText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimerText() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        'Please wait $_timer seconds before trying again.',
        style: TextStyle(color: Colors.grey[700]),
      ),
    );
  }

  void _startTimer() {
    setState(() => _timer = 60);
    Future.delayed(const Duration(seconds: 1), () {
      if (_timer > 0) {
        setState(() => _timer--);
        _startTimer();
      }
    });
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _otpController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
