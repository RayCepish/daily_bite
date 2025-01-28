import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_screen_event.dart';
part 'auth_screen_state.dart';

class AuthScreenBloc extends Bloc<AuthScreenEvent, AuthScreenState> {
  AuthScreenBloc() : super(AuthScreenInitial()) {
    on<SwitchTabEvent>((event, emit) {
      final currentState = state as AuthScreenInitial;
      emit(AuthScreenInitial(
        currentTab: event.tabIndex,
        email: currentState.email,
        password: currentState.password,
        name: currentState.name,
      ));
    });

    on<UpdateFieldEvent>((event, emit) {
      final currentState = state as AuthScreenInitial;
      emit(AuthScreenInitial(
        currentTab: currentState.currentTab,
        email: event.email,
        password: event.password,
        name: event.name ?? currentState.name,
      ));
    });

    on<LoginEvent>((event, emit) async {
      emit(AuthInProgress());
      await Future.delayed(const Duration(seconds: 1)); // Симуляція запиту
      emit(AuthSuccess());
    });

    on<RegisterEvent>((event, emit) async {
      emit(AuthInProgress());
      await Future.delayed(const Duration(seconds: 1)); // Симуляція запиту
      emit(AuthSuccess());
    });
  }
}
