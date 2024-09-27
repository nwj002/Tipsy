import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/core/common/my_snack_bar.dart';
import 'package:liquor_ordering_system/features/home/presentation/navigator/home_navigate.dart';

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, bool>(
  (ref) => HomeViewModel(ref.read(homeViewNavigatorProvider)),
);

class HomeViewModel extends StateNotifier<bool> {
  HomeViewModel(this.homeNavigator) : super(false);
  final HomeViewNavigator homeNavigator;

  void logout() async {
    mySnackBar(message: 'Logging out.', color: Colors.red);
  
  }

  openLoginView() {
    homeNavigator.openLoginView();
  }
}
