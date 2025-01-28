import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppLoadingState()) {
    on<AppStartedEvent>(_onAppStarted);
  }

  void _onAppStarted(AppStartedEvent event, Emitter<AppState> emit) async {}
}
