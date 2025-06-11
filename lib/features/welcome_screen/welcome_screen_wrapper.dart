import 'package:daily_bite/features/welcome_screen/welcome_screen.dart';
import 'package:daily_bite/features/welcome_screen/welcome_screen_bloc/welcome_screen_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeScreenWrapper extends StatelessWidget {
  const WelcomeScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WelcomeScreenBloc(),
      child: const WelcomeScreen(),
    );
  }
}
