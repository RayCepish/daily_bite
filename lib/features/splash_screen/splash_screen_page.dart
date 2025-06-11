import 'package:daily_bite/core/constants/storage_keys.dart';
import 'package:daily_bite/features/food_screen/food_bloc/food_screen_bloc.dart';
import 'package:daily_bite/features/profile_screen/profile_bloc/profile_bloc.dart';
import 'package:daily_bite/features/splash_screen/splash_screen_bloc/splash_screen_page_bloc.dart';
import 'package:daily_bite/features/splash_screen/widgets/build_splash_screen_animation.dart';
import 'package:daily_bite/services/api/auth_api_service.dart';
import 'package:daily_bite/services/setup_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashScreenPageBloc()..add(StartAnimationEvent()),
      child: BlocListener<SplashScreenPageBloc, SplashScreenPageState>(
        // listener: (context, state) async {
        //   if (state is SplashAnimationCompleted) {
        //     final storage = getIt<FlutterSecureStorage>();
        //     final isVisitAppBefore =
        //         await storage.read(key: StorageKeys.isVisitAppBefore) != null;

        //     if (!isVisitAppBefore) {
        //       if (context.mounted) context.go('/welcome_screen');
        //       return;
        //     }

        //     final accessToken = await storage.read(key: StorageKeys.authToken);
        //     if (accessToken == null) {
        //       if (context.mounted) context.go('/auth');
        //       return;
        //     }

        //     getIt<ProfileBloc>().add(LoadUserProfile());
        //     getIt<FoodScreenBloc>().add(FetchCategories());
        //     if (context.mounted) {
        //       context
        //           .read<SplashScreenPageBloc>()
        //           .add(WaitForProfileLoadEvent());
        //     }
        //   }
        // },
        listener: (context, state) async {
          if (state is SplashAnimationCompleted) {
            final storage = getIt<FlutterSecureStorage>();
            final isVisitAppBefore =
                await storage.read(key: StorageKeys.isVisitAppBefore) != null;

            if (!isVisitAppBefore) {
              if (context.mounted) context.go('/welcome_screen');
              return;
            }

            var accessToken = await storage.read(key: StorageKeys.authToken);
            final refreshToken =
                await storage.read(key: StorageKeys.refreshToken);

            // Якщо access токену нема, але є refresh — пробуємо оновити
            if (accessToken == null && refreshToken != null) {
              accessToken = await getIt<AuthApiService>().refreshToken();
            }

            // Якщо і після рефрешу нема access — редірект на авторизацію
            if (accessToken == null) {
              if (context.mounted) context.go('/auth');
              return;
            }

            // Завантаження профілю
            getIt<ProfileBloc>().add(LoadUserProfile());
            getIt<FoodScreenBloc>().add(FetchCategories());

            if (context.mounted) {
              context
                  .read<SplashScreenPageBloc>()
                  .add(WaitForProfileLoadEvent());
            }
          }
        },
        child: Scaffold(
          body: BlocListener<SplashScreenPageBloc, SplashScreenPageState>(
            listener: (context, state) {
              if (state is SplashWaitProfileLoaded && context.mounted) {
                context.go('/main_page');
              }
            },
            child: BlocBuilder<SplashScreenPageBloc, SplashScreenPageState>(
              builder: (context, state) {
                final animationValue = switch (state) {
                  SplashAnimationInProgress() => state.animationValue,
                  _ => 1.0,
                };

                return BuildSplashScreenAnimation(
                    animationValue: animationValue);
              },
            ),
          ),
        ),
      ),
    );
  }
}
