import 'package:daily_bite/core/constants/app_const_service.dart';
import 'package:daily_bite/core/constants/storage_keys.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
    clientId: AppConstService.androidClientID,
  );

  final FlutterSecureStorage _storage = GetIt.instance<FlutterSecureStorage>();

  Future<GoogleSignInAccount> signInWithGoogle() async {
    try {
      final user = await _googleSignIn.signIn();
      if (user == null) {
        throw Exception('Користувач скасував вхід через Google.');
      }

      final tokens = await getTokens(user);
      await _storage.write(
          key: StorageKeys.authToken, value: tokens['accessToken']);

      return user;
    } catch (e) {
      throw Exception('Не вдалося виконати вхід через Google: $e');
    }
  }

  Future<Map<String, String>> getTokens(GoogleSignInAccount user) async {
    try {
      final authentication = await user.authentication;
      final idToken = authentication.idToken;
      final accessToken = authentication.accessToken;

      if (idToken == null || accessToken == null) {
        throw Exception('Не вдалося отримати токени Google.');
      }

      return {
        'idToken': idToken,
        'accessToken': accessToken,
      };
    } catch (e) {
      throw Exception('Помилка при отриманні токенів: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _storage.delete(key: StorageKeys.authToken);
    } catch (e) {
      throw Exception('Помилка при виході з Google: $e');
    }
  }
}
