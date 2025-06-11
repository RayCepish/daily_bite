import 'package:daily_bite/app/app_bloc/app_bloc.dart';
import 'package:daily_bite/features/chat_screen/chat_screen_bloc/chat_screen_bloc.dart';
import 'package:daily_bite/features/food_screen/food_bloc/food_screen_bloc.dart';
import 'package:daily_bite/features/profile_screen/profile_bloc/profile_bloc.dart';
import 'package:daily_bite/features/recipes_screen/bloc/recipes_screen_bloc.dart';
import 'package:daily_bite/features/user_recipes/bloc/user_recipes_bloc.dart';
import 'package:daily_bite/services/api/accounts_api_service.dart';
import 'package:daily_bite/services/api/auth_api_service.dart';
import 'package:daily_bite/services/api/chat_api_service.dart';
import 'package:daily_bite/services/api/food_api_service.dart';
import 'package:daily_bite/services/api/google_auth_service.dart';
import 'package:daily_bite/services/api/recipes_api_service.dart';
import 'package:daily_bite/services/app_interceptor.dart';
import 'package:daily_bite/services/app_service.dart';
import 'package:dio/dio.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Ensure that the SharedPreferences instance is initialized before registering it
  final sharedPreferences = await SharedPreferences.getInstance();

  if (!getIt.isRegistered<SharedPreferences>()) {
    getIt.registerSingleton<SharedPreferences>(sharedPreferences);
  }
  if (!getIt.isRegistered<FlutterSecureStorage>()) {
    getIt.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
  }
//API services
  if (!getIt.isRegistered<Dio>()) {
    final dio = Dio();

    dio.interceptors.add(AppInterceptor());

    getIt.registerSingleton<Dio>(dio);
  }
  if (!getIt.isRegistered<GoogleAuthService>()) {
    getIt.registerLazySingleton(() => GoogleAuthService());
  }
  if (!getIt.isRegistered<AuthApiService>()) {
    getIt.registerLazySingleton(() => AuthApiService());
  }
  if (!getIt.isRegistered<AccountsApiService>()) {
    getIt.registerLazySingleton(() => AccountsApiService());
  }
  if (!getIt.isRegistered<ChatApiService>()) {
    getIt.registerLazySingleton(() => ChatApiService());
  }
  if (!getIt.isRegistered<FoodApiService>()) {
    getIt.registerLazySingleton(() => FoodApiService());
  }
  if (!getIt.isRegistered<RecipesApiService>()) {
    getIt.registerLazySingleton(() => RecipesApiService());
  }

// Blocs
  if (!getIt.isRegistered<AppBloc>()) {
    getIt.registerSingleton<AppBloc>(AppBloc());
  }
  if (!getIt.isRegistered<ProfileBloc>()) {
    getIt.registerSingleton<ProfileBloc>(
      ProfileBloc(
        getIt<AccountsApiService>(),
      ),
    );
  }
  if (!getIt.isRegistered<FoodScreenBloc>()) {
    getIt.registerSingleton<FoodScreenBloc>(
      FoodScreenBloc(
        getIt<FoodApiService>(),
      ),
    );
  }
  if (!getIt.isRegistered<RecipesScreenBloc>()) {
    getIt.registerSingleton<RecipesScreenBloc>(
      RecipesScreenBloc(
        getIt<RecipesApiService>(),
      ),
    );
  }
  if (!getIt.isRegistered<UserRecipesBloc>()) {
    getIt.registerSingleton<UserRecipesBloc>(
      UserRecipesBloc(
        getIt<RecipesApiService>(),
      ),
    );
  }
  if (!getIt.isRegistered<ChatScreenBloc>()) {
    getIt.registerSingleton<ChatScreenBloc>(
      ChatScreenBloc(),
    );
  }
  //Main app service
  if (!getIt.isRegistered<AppService>()) {
    getIt.registerLazySingleton<AppService>(() => AppService());
  }
}
