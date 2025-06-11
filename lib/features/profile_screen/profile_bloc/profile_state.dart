part of 'profile_bloc.dart';

class ProfileState {
  final UserModel? userModel;
  final NutritionModel? totalNutritionValue;
  final bool isLoading;
  final bool isLoaded;
  final bool isLoggedOut;

  const ProfileState({
    required this.userModel,
    this.totalNutritionValue,
    this.isLoading = false,
    this.isLoaded = false,
    this.isLoggedOut = false,
  });

  ProfileState copyWith({
    UserModel? userModel,
    NutritionModel? totalNutritionValue,
    bool? isLoading,
    bool? isLoaded,
    bool? isLoggedOut,
  }) {
    return ProfileState(
      userModel: userModel ?? this.userModel,
      totalNutritionValue: totalNutritionValue ?? this.totalNutritionValue,
      isLoading: isLoading ?? this.isLoading,
      isLoaded: isLoaded ?? this.isLoaded,
      isLoggedOut: isLoggedOut ?? this.isLoggedOut,
    );
  }

  static const initial = ProfileState(
    userModel: null,
    totalNutritionValue: null,
    isLoggedOut: false,
  );
}
