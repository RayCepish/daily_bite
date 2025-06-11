import 'package:bloc/bloc.dart';
import 'package:daily_bite/core/constants/storage_keys.dart';
import 'package:daily_bite/core/utils/custom_try_catch.dart';

import 'package:daily_bite/services/api/auth_api_service.dart';
import 'package:daily_bite/services/setup_dependencies.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

part 'auth_screen_event.dart';
part 'auth_screen_state.dart';

class AuthScreenBloc extends Bloc<AuthScreenEvent, AuthScreenState> {
  AuthScreenBloc() : super(AuthScreenInitial()) {
    on<SwitchTabEvent>((event, emit) {
      if (state is AuthScreenInitial) {
        final currentState = state as AuthScreenInitial;
        emit(AuthScreenInitial(
          currentTab: event.tabIndex,
          email: currentState.email,
          password: currentState.password,
          name: currentState.name,
        ));
      }
    });

    on<UpdateFieldEvent>(_onUpdateField);

    on<LoginEvent>(_onLogin);

    on<RegisterEvent>(_onRegister);

    on<GoogleLoginEvent>(_onLoginGoogle);
    on<LogoutEvent>(_onLogout);
  }
  Future<void> _onUpdateField(
    UpdateFieldEvent event,
    Emitter<AuthScreenState> emit,
  ) async {
    final currentState = state as AuthScreenInitial;
    emit(AuthScreenInitial(
      currentTab: currentState.currentTab,
      email: event.email,
      password: event.password,
      name: event.name ?? currentState.name,
    ));
  }

  Future<void> _onLogin(
    LoginEvent event,
    Emitter<AuthScreenState> emit,
  ) async {
    await customTryCatch(
      showLoader: true,
      () async {
        final authServiceApi = getIt<AuthApiService>();

        final response = await authServiceApi.login(
          email: event.email,
          password: event.password,
        );

        await GetIt.instance<FlutterSecureStorage>().write(
          key: StorageKeys.authToken,
          value: response.accessToken,
        );
        await GetIt.instance<FlutterSecureStorage>().write(
          key: StorageKeys.refreshToken,
          value: response.refreshToken,
        );

        emit(AuthSuccess());
      },
    );
  }

  Future<void> _onRegister(
    RegisterEvent event,
    Emitter<AuthScreenState> emit,
  ) async {
    await customTryCatch(
      showLoader: true,
      () async {
        final authServiceApi = getIt<AuthApiService>();

        final response = await authServiceApi.register(
          name: event.name,
          email: event.email,
          password: event.password,
        );
        await GetIt.instance<FlutterSecureStorage>().write(
          key: StorageKeys.authToken,
          value: response.accessToken,
        );
        await GetIt.instance<FlutterSecureStorage>().write(
          key: StorageKeys.refreshToken,
          value: response.refreshToken,
        );

        emit(AuthSuccess());
      },
    );
  }

  Future<void> _onLoginGoogle(
    GoogleLoginEvent event,
    Emitter<AuthScreenState> emit,
  ) async {
    await customTryCatch(
      showLoader: true,
      () async {
        final authServiceApi = getIt<AuthApiService>();
        await authServiceApi.loginWithGoogleAndBackend();

        // final accessToken = await getIt<FlutterSecureStorage>()
        //     .read(key: StorageKeys.authToken);

        // if (accessToken == null) {
        //   throw Exception('Access token не знайдено');
        // }

        // final user = await accountsServiceApi.getUserInfo(accessToken);
        // getIt<ProfileBloc>().add(LoadUserProfile(user));

        emit(AuthSuccess());
      },
    );
  }

  Future<void> _onLogout(
    LogoutEvent event,
    Emitter<AuthScreenState> emit,
  ) async {
    await customTryCatch(
      showLoader: true,
      emitError: () async => emit(AuthFailure()),
      () async {
        final api = getIt<AuthApiService>();
        await api.logout();

        emit(AuthScreenInitial());
      },
    );
  }
}
