import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/app/app.dart';
import 'package:liquor_ordering_system/core/networking/local/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService().init();

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
