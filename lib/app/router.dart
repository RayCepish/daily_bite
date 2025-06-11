import 'package:daily_bite/features/auth/auth_screen_wrapper.dart';
import 'package:daily_bite/features/food_screen/food_screen_wrapper.dart';
import 'package:daily_bite/features/forgot_password/forgot_password_wrapper.dart';
import 'package:daily_bite/features/main_page/main_page_wrapper.dart';
import 'package:daily_bite/features/recipes_screen/recipes_screen_wrapper.dart';
import 'package:daily_bite/features/splash_screen/splash_screen_page.dart';
import 'package:daily_bite/features/user_recipes/user_recipes_wrapper.dart';
import 'package:daily_bite/features/welcome_screen/welcome_screen_wrapper.dart';
import 'package:daily_bite/models/food_products/food_item_model.dart';

import 'package:flutter/material.dart';
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
          path: 'welcome_screen',
          builder: (_, __) => const WelcomeScreenWrapper(),
        ),
        GoRoute(
          path: '/auth',
          builder: (_, __) => const AuthScreenWrapper(),
          routes: [
            GoRoute(
              path: 'forgot_password',
              builder: (_, state) {
                final email = state.extra as String;
                return ForgotPasswordWrapper(email: email);
              },
            ),
          ],
        ),
        GoRoute(
          path: '/main_page',
          builder: (context, state) {
            return const MainPageWrapper();
          },
        ),
        GoRoute(
          path: '/food_editor',
          builder: (context, state) {
            final preselected = state.extra as List<FoodItemModel>;
            return FoodScreenWrapper(preselectedItems: preselected);
          },
        ),
        GoRoute(
          path: '/create_recipe',
          builder: (context, state) {
            final extra = state.extra;
            return RecipesScreenWrapper(extra: extra!);
          },
        ),
        GoRoute(
          path: '/user_recipes',
          builder: (context, state) {
            return const UserRecipesWrapper();
          },
        ),
      ],
    ),
  ],
);
