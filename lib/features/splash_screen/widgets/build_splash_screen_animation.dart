import 'package:daily_bite/core/widgets/background_particles.dart';
import 'package:flutter/material.dart';

class BuildSplashScreenAnimation extends StatelessWidget {
  final double animationValue;
  const BuildSplashScreenAnimation({super.key, required this.animationValue});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double maxSize = screenSize.width * 3 * animationValue;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(color: Theme.of(context).colorScheme.primary),
        Center(
          child: OverflowBox(
            maxWidth: maxSize,
            maxHeight: maxSize,
            child: ClipOval(
              child: Container(
                width: maxSize,
                height: maxSize,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const BackgroundParticles(),
        ShaderMask(
          shaderCallback: (rect) {
            return RadialGradient(
              colors: [
                Theme.of(context).colorScheme.surface,
                Colors.transparent
              ],
              stops: [animationValue, animationValue + 0.1],
            ).createShader(rect);
          },
          child: Center(
            child: Opacity(
              opacity: animationValue,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'DailyBite',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Eat Deliciously, Live Healthily',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
