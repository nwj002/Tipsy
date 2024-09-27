import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/features/splash/presentation/viewmodel/splash_view_model.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    ref.read(splashViewModelProvider.notifier).openOnboardingView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 250,
                  height: 250,
                  child: Image.asset('assets/images/ticon.png'),
                ),
                const Text(
                  'Welcome to Tipsy',
                  style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD29062)),
                ),
                const Text('Online Liquor Store',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD29062))),
                const SizedBox(height: 150),
                const CircularProgressIndicator(),
                const SizedBox(height: 20),
                const Text(
                  "version : 1.0.0",
                  style: TextStyle(color: Color(0xFFD29062)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
