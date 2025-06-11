part of 'app_bloc.dart';

@immutable
class AppState {
  final bool isLoading;
  final int currentStep;
  final int totalSteps;
  final bool hasError;

  const AppState({
    this.isLoading = false,
    this.currentStep = 0,
    this.totalSteps = 60,
    this.hasError = false,
  });

  AppState copyWith({
    bool? isLoading,
    int? currentStep,
    int? totalSteps,
    bool? hasError,
  }) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      currentStep: currentStep ?? this.currentStep,
      totalSteps: totalSteps ?? this.totalSteps,
      hasError: hasError ?? this.hasError,
    );
  }

  static const initial = AppState();
}
