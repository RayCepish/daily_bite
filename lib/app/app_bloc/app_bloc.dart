import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState.initial) {
    on<ShowLoaderEvent>((event, emit) {
      emit(state.copyWith(isLoading: true));
    });

    on<HideLoaderEvent>((event, emit) {
      emit(state.copyWith(isLoading: false));
    });

    on<ShowErrorEvent>((event, emit) {
      emit(state.copyWith(hasError: true));
    });
  }
}
