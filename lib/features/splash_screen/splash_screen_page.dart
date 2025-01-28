import 'package:daily_bite/features/splash_screen/splash_screen_bloc/splash_screen_page_bloc.dart';
import 'package:daily_bite/features/splash_screen/widgets/build_splash_screen_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashScreenPageBloc()..add(StartAnimationEvent()),
      child: BlocListener<SplashScreenPageBloc, SplashScreenPageState>(
        listener: (context, state) {
          if (state is SplashAnimationCompleted) {
            if (context.mounted) {
              context.go('/auth');
            }
          }
        },
        child: Scaffold(
          body: BlocBuilder<SplashScreenPageBloc, SplashScreenPageState>(
            builder: (context, state) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: state is SplashAnimationInProgress
                    ? BuildSplashScreenAnimation(
                        animationValue: state.animationValue,
                      )
                    : const SizedBox.shrink(),
              );
            },
          ),
        ),
      ),
    );
  }
}
