import 'package:daily_bite/core/constants/storage_keys.dart';
import 'package:daily_bite/features/profile_screen/profile_bloc/profile_bloc.dart';
import 'package:daily_bite/services/api/auth_api_service.dart';
import 'package:daily_bite/services/setup_dependencies.dart';
import 'package:dio/dio.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import 'package:flutter/material.dart';

class AppInterceptor extends Interceptor {
  final _storage = GetIt.instance<FlutterSecureStorage>();
  bool _isLoggedOut = false;
  final _dio = Dio();
  bool _isRefreshing = false;
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final requiresAuth = options.extra['requiresAuth'] ?? true;

      if (requiresAuth) {
        final token = await _storage.read(key: StorageKeys.authToken);
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
          debugPrint('[Interceptor] ⬆️ Token → Bearer $token');
        }
      }

      debugPrint('[DIO] ⬆️ REQUEST → ${options.method} ${options.uri}');
      debugPrint('[DIO] ⬆️ DATA → ${options.data}');
    } catch (e) {
      debugPrint('[DIO] onRequest error: $e');
    }

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint('[DIO] ⛔ ${err.response?.statusCode} ${err.message}');
    debugPrint('[DIO] ⛔️ RESPONSE DATA → ${err.response?.data}');
    debugPrint('[DIO] ⛔️ REQUEST PATH → ${err.requestOptions.path}');

    if (err.response?.statusCode == 401 && !_isRefreshing) {
      _isRefreshing = true;

      final newAccessToken = await getIt<AuthApiService>().refreshToken();

      if (newAccessToken != null) {
        final retryRequest = err.requestOptions;
        retryRequest.headers['Authorization'] = 'Bearer $newAccessToken';

        try {
          final retryResponse = await _dio.fetch(retryRequest);
          _isRefreshing = false;
          return handler.resolve(retryResponse);
        } catch (e) {
          debugPrint('[DIO] ❌ Retry failed: $e');
        }
      }

      _isRefreshing = false;

      if (!_isLoggedOut) {
        _isLoggedOut = true;
        await _storage.delete(key: StorageKeys.authToken);
        await _storage.delete(key: StorageKeys.refreshToken);
        getIt<ProfileBloc>().add(LogoutRequested());
        Future.delayed(const Duration(seconds: 3), () => _isLoggedOut = false);
      }
    }

    // Якщо не вдалося оновити
    if (!_isLoggedOut) {
      _isLoggedOut = true;
      await _storage.delete(key: StorageKeys.authToken);
      await _storage.delete(key: StorageKeys.refreshToken);
      getIt<ProfileBloc>().add(LogoutRequested());
      Future.delayed(const Duration(seconds: 3), () => _isLoggedOut = false);
    }

    return handler.next(err);
  }
}
