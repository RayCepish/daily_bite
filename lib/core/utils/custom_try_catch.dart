import 'package:daily_bite/services/app_service.dart';
import 'package:daily_bite/services/setup_dependencies.dart';
import 'package:flutter/material.dart';

Future<bool> customTryCatch(
  Future<void> Function() action, {
  Function(Object error)? onError,
  bool rethrowError = false,
  bool showLoader = false,
  Future<void> Function()? emitError,
}) async {
  try {
    if (showLoader) getIt<AppService>().showLoader();

    await action();

    return true;
  } catch (e) {
    debugPrint('❌ Exception: $e  ');
    if (rethrowError) rethrow;
    getIt<AppService>().showError();
    emitError?.call();
    return false;
  } finally {
    getIt<AppService>().hideLoader();
  }
}
