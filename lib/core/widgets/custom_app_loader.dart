import 'package:daily_bite/app/app_bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'dart:math' as math;

class CustomAppLoader extends StatefulWidget {
  const CustomAppLoader({super.key});

  @override
  State<CustomAppLoader> createState() => _CustomAppLoaderState();
}

class _CustomAppLoaderState extends State<CustomAppLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (!state.isLoading) return const SizedBox.shrink();

        final steps = state.totalSteps;
        final current = state.currentStep.clamp(0, steps);

        return Container(
          color: Colors.black.withOpacity(0.3),
          child: Center(
            child: RotationTransition(
              turns: _rotationController,
              child: CircularStepProgressIndicator(
                totalSteps: steps,
                currentStep: current,
                stepSize: 14,
                selectedColor: theme.primary,
                unselectedColor: theme.surface,
                padding: 0,
                width: 110,
                height: 110,
                startingAngle: 0,
                arcSize: math.pi * 2,
                gradientColor: LinearGradient(
                  colors: [theme.primary, theme.surface],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
