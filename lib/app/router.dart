import 'package:daily_bite/features/auth/auth_bloc/auth_screen_bloc.dart';
import 'package:daily_bite/features/auth/auth_screen.dart';
import 'package:daily_bite/features/forgot_password/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:daily_bite/features/forgot_password/forgot_password_screen.dart';
import 'package:daily_bite/features/splash_screen/splash_screen_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreenPage();
      },
      routes: [
        GoRoute(
          path: '/auth',
          builder: (BuildContext context, GoRouterState state) {
            return BlocProvider(
              create: (_) => AuthScreenBloc(),
              child: const AuthScreen(),
            );
          },
          routes: [
            GoRoute(
              path: 'forgot_password',
              builder: (BuildContext context, GoRouterState state) {
                final email = state.extra as String;
                return BlocProvider(
                  create: (_) =>
                      ForgotPasswordBloc()..add(SetEmailEvent(email)),
                  child: ForgotPasswordScreen(email: email),
                );
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
