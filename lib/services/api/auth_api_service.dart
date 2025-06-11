import 'package:daily_bite/core/constants/app_const_service.dart';
import 'package:daily_bite/core/constants/storage_keys.dart';
import 'package:daily_bite/models/token_model.dart';
import 'package:daily_bite/services/api/google_auth_service.dart';
import 'package:daily_bite/services/setup_dependencies.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

class AuthApiService {
  final dio = getIt<Dio>();
  final String baseUrl = AppConstService.baseUrl;

  Future<TokenModel> login({
    required String email,
    required String password,
  }) async {
    final response = await dio.post(
      '$baseUrl/api/accounts/login/',
      data: {
        'email': email,
        'password': password,
      },
      options: Options(
        extra: {'requiresAuth': false},
      ),
    );

    return TokenModel.fromJson(response.data);
  }

  Future<TokenModel> register({
    String? name,
    required String email,
    required String password,
  }) async {
    final response = await dio.post(
      '$baseUrl/api/accounts/register/',
      data: {
        'name': name,
        'email': email,
        'password': password,
      },
      options: Options(
        extra: {'requiresAuth': false},
      ),
    );

    return TokenModel.fromJson(response.data);
  }

  Future<TokenModel> loginWithGoogleAndBackend() async {
    final user = await GoogleAuthService().signInWithGoogle();
    final tokens = await GoogleAuthService().getTokens(user);
    final idToken = tokens['idToken'];

    final response = await dio.post(
      '$baseUrl/api/accounts/google/',
      data: {"id_token": idToken},
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
        extra: {'requiresAuth': false},
      ),
    );
    return TokenModel.fromJson(response.data);
    // try {
    // final user = await GoogleAuthService().signInWithGoogle();
    // final tokens = await GoogleAuthService().getTokens(user);
    // final idToken = tokens['idToken'];

    // final response = await dio.post(
    //   '$baseUrl/accounts/google/',
    //   data: {"id_token": idToken},
    //   options: Options(headers: {
    //     "Content-Type": "application/json",
    //   }),
    // );

    // } catch (e) {
    //   print('Помилка входу через Google + бекенд: $e');
    // }
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    // final token = await GetIt.instance<FlutterSecureStorage>()
    //     .read(key: StorageKeys.authToken);

    final response = await dio.post(
      '$baseUrl/accounts/change-password/',
      data: {
        'old_password': oldPassword,
        'new_password': newPassword,
      },
      options: Options(extra: {'requiresAuth': false}),
    );

    if (response.statusCode == 200) {
      print('Пароль змінено');
    } else {
      print('Помилка зміни пароля');
    }
  }

  Future<String?> refreshToken() async {
    final storage = getIt<FlutterSecureStorage>();
    final refresh = await storage.read(key: StorageKeys.refreshToken);

    if (refresh == null) return null;
    try {
      final response = await dio.post(
        '$baseUrl/api/token/refresh/',
        data: {
          "refresh": refresh,
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      final newAccess = response.data['access'];
      final newRefresh = response.data['refresh'];
      await GetIt.instance<FlutterSecureStorage>().write(
        key: StorageKeys.authToken,
        value: newAccess,
      );
      await GetIt.instance<FlutterSecureStorage>().write(
        key: StorageKeys.refreshToken,
        value: newRefresh,
      );
      return newAccess;
    } catch (e) {
      debugPrint('❌ Failed to refresh token: $e');
      return null;
    }
  }

  Future<void> logout() async {
    final storage = GetIt.instance<FlutterSecureStorage>();

    final refreshToken = await storage.read(key: StorageKeys.refreshToken);

    if (refreshToken == null) {
      throw Exception('Refresh токен не знайдено');
    }

    await dio.post(
      '$baseUrl/accounts/logout/',
      data: {"refresh": refreshToken},
      options: Options(
        headers: {"Content-Type": "application/json"},
      ),
    );

    // Видаляємо токени
    await storage.delete(key: StorageKeys.authToken);
    await storage.delete(key: StorageKeys.refreshToken);
  }
}
