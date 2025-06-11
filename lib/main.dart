import 'package:daily_bite/app/app.dart';

import 'package:daily_bite/services/setup_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await setupDependencies();

  final sharedPreferences = getIt<SharedPreferences>();

  if (sharedPreferences.getBool('first_run') ?? true) {
    await getIt<FlutterSecureStorage>().deleteAll();
    sharedPreferences.setBool('first_run', false);
  }

  runApp(const DailyBite());
}
