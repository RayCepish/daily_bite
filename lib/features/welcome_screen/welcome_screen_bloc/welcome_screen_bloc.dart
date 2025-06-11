import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'welcome_screen_event.dart';
part 'welcome_screen_state.dart';

class WelcomeScreenBloc extends Bloc<WelcomeScreenEvent, WelcomeScreenState> {
  WelcomeScreenBloc() : super(WelcomeScreenInitial()) {
    on<WelcomeScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
