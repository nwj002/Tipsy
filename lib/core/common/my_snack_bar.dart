import 'package:flutter/material.dart';
import 'package:liquor_ordering_system/app/navigator_key/navigator_key.dart';

mySnackBar({
  required String message,
  Color? color,
}) {
  ScaffoldMessenger.of(
    AppNavigator.navigatorKey.currentState!.context,
  ).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: color ?? Colors.green,
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
