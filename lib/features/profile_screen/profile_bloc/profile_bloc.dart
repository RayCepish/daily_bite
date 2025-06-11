import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_bite/core/constants/storage_keys.dart';
import 'package:daily_bite/core/utils/custom_try_catch.dart';
import 'package:daily_bite/models/nutrition_model/nutrition_model.dart';
import 'package:daily_bite/models/user_model/user_model.dart';
import 'package:daily_bite/services/api/accounts_api_service.dart';
import 'package:daily_bite/services/api/google_auth_service.dart';
import 'package:daily_bite/services/api/recipes_api_service.dart';
import 'package:daily_bite/services/setup_dependencies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AccountsApiService _accountsService;
  ProfileBloc(this._accountsService) : super(ProfileState.initial) {
    on<LoadUserProfile>(_onLoadProfile);
    on<UpdateUserProfile>(_onUpdateUserProfile);
    on<LogoutRequested>(_onLogOut);
  }

  Future<void> _onLoadProfile(
    LoadUserProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(
      state.copyWith(isLoading: false),
    );
    await customTryCatch(
      showLoader: true,
      () async {
        final accessToken = await getIt<FlutterSecureStorage>()
            .read(key: StorageKeys.authToken);

        final totals = await getIt<RecipesApiService>().fetchNutritionTotals();
        emit(state.copyWith(totalNutritionValue: totals));
        final user = await _accountsService.getUserInfo(accessToken!);

        emit(
          state.copyWith(
            userModel: user,
            isLoading: false,
            isLoaded: true,
          ),
        );
      },
    );
  }

  Future<void> _onUpdateUserProfile(
    UpdateUserProfile event,
    Emitter<ProfileState> emit,
  ) async {
    await customTryCatch(
      showLoader: true,
      () async {
        final updatedUser = await _accountsService.updateProfile(
          photo: event.photo,
        );

        emit(state.copyWith(userModel: updatedUser));
      },
    );
  }

  Future<void> _onLogOut(
    LogoutRequested event,
    Emitter<ProfileState> emit,
  ) async {
    final showLoader = state.isLoggedOut ? false : true;
    await customTryCatch(showLoader: showLoader, () async {
      final storage = getIt<FlutterSecureStorage>();

      await storage.delete(key: StorageKeys.authToken);
      await storage.delete(key: StorageKeys.refreshToken);
      await CachedNetworkImage.evictFromCache('');
// getIt<ChatScreenBloc>().add(ClearChatEvent());

      await getIt<GoogleAuthService>().signOut();

      emit(ProfileState.initial);
      emit(ProfileState.initial.copyWith(isLoggedOut: showLoader));
    });
  }
}
