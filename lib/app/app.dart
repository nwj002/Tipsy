import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/app/navigator_key/navigator_key.dart';
import 'package:liquor_ordering_system/app/themes/app_theme.dart';
import 'package:liquor_ordering_system/features/home/presentation/view/home_view.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      navigatorKey: AppNavigator.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Tipsy',
      theme: AppTheme.getApplicationTheme(false),
      home: const HomeView(),
    );
  }
}
