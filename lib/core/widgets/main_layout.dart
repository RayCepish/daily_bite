import 'package:daily_bite/core/widgets/background_particles.dart';
import 'package:daily_bite/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final AppBarSettings? appBarSettings;

  const MainLayout({
    super.key,
    required this.child,
    this.appBarSettings,
  });

  @override
  Widget build(BuildContext context) {
    const double marginValue = 15;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            const BackgroundParticles(),
            Positioned(
              top: marginValue,
              bottom: marginValue,
              left: marginValue,
              right: marginValue,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .onSecondary
                          .withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    if (appBarSettings != null)
                      CustomAppBar(
                        appBarSettings: appBarSettings!,
                      ),
                    Expanded(child: child)
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
