import 'package:daily_bite/features/auth/auth_bloc/auth_screen_bloc.dart';
import 'package:daily_bite/features/auth/auth_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreenWrapper extends StatelessWidget {
  const AuthScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthScreenBloc(),
      child: const AuthScreen(),
    );
  }
}
