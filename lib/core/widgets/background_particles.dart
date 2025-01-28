import 'dart:math';

import 'package:flutter/material.dart';
import 'package:particles_flutter/component/particle/particle.dart';
import 'package:particles_flutter/particles_engine.dart';

class BackgroundParticles extends StatelessWidget {
  const BackgroundParticles({super.key});

  @override
  Widget build(BuildContext context) {
    double randomSign() {
      var rng = Random();
      return rng.nextBool() ? 1 : -1;
    }

    List<Particle> createParticles() {
      var rng = Random();
      List<Particle> particles = [];
      for (int i = 0; i < 70; i++) {
        particles.add(Particle(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
          size: rng.nextDouble() * 20,
          velocity: Offset(rng.nextDouble() * 10 * randomSign(),
              rng.nextDouble() * 20 * randomSign()),
        ));
      }
      return particles;
    }

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Particles(
      awayRadius: 100,
      particles: createParticles(),
      height: screenHeight,
      width: screenWidth,
      onTapAnimation: true,
      awayAnimationDuration: const Duration(microseconds: 100),
      enableHover: false,
      hoverRadius: 100,
      connectDots: false,
    );
  }
}
