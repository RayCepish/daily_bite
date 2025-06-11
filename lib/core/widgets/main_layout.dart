import 'package:daily_bite/app/app_bloc/app_bloc.dart';
import 'package:daily_bite/core/widgets/background_particles.dart';
import 'package:daily_bite/core/widgets/custom_app_bar.dart';
import 'package:daily_bite/core/widgets/custom_app_loader.dart';
import 'package:daily_bite/services/setup_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final AppBarSettings? appBarSettings;
  final bool? canPop;
  final bool showFAB, isShowingSelected, showCreateFABButton;
  final void Function()? onCreate, onClear, onToggleSelected;
  const MainLayout({
    required this.child,
    this.appBarSettings,
    this.canPop,
    this.showCreateFABButton = true,
    this.isShowingSelected = false,
    this.showFAB = false,
    this.onCreate,
    this.onClear,
    this.onToggleSelected,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    const double marginValue = 15;
    final theme = Theme.of(context);
    return PopScope(
      canPop: canPop ?? true,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                const BackgroundParticles(),
                Positioned.fill(
                  top: marginValue,
                  bottom: marginValue,
                  left: marginValue,
                  right: marginValue,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .surface
                          .withOpacity(0.7),
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
                          CustomAppBar(appBarSettings: appBarSettings!),
                        Expanded(child: child)
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 100,
                  right: 40,
                  child: SpeedDial(
                    elevation: 8,
                    visible: showFAB,
                    icon: Icons.add,
                    activeIcon: Icons.close,
                    backgroundColor: theme.colorScheme.primaryContainer,
                    foregroundColor: theme.colorScheme.surface,
                    overlayOpacity: 0.2,
                    spacing: 5,
                    spaceBetweenChildren: 2,
                    children: [
                      SpeedDialChild(
                        backgroundColor: theme.colorScheme.primaryContainer,
                        foregroundColor: theme.colorScheme.surface,
                        labelBackgroundColor:
                            theme.colorScheme.primaryContainer,
                        labelStyle: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.surface,
                        ),
                        child: const Icon(Icons.clear_all),
                        label: 'Clear',
                        onTap: onClear,
                      ),
                      if (showCreateFABButton)
                        SpeedDialChild(
                          backgroundColor: theme.colorScheme.primaryContainer,
                          foregroundColor: theme.colorScheme.surface,
                          labelBackgroundColor:
                              theme.colorScheme.primaryContainer,
                          labelStyle: theme.textTheme.labelLarge?.copyWith(
                            color: theme.colorScheme.surface,
                          ),
                          child: const Icon(Icons.create),
                          label: 'Create Recipe',
                          onTap: onCreate,
                        ),
                      SpeedDialChild(
                        backgroundColor: theme.colorScheme.primaryContainer,
                        foregroundColor: theme.colorScheme.surface,
                        labelBackgroundColor:
                            theme.colorScheme.primaryContainer,
                        labelStyle: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.surface,
                        ),
                        child: Icon(
                          isShowingSelected
                              ? Icons.visibility_outlined
                              : Icons.visibility_rounded,
                        ),
                        label: isShowingSelected ? 'Show All' : 'Show Selected',
                        onTap: onToggleSelected,
                      ),
                    ],
                  ),
                ),
                BlocProvider.value(
                  value: getIt<AppBloc>(),
                  child: const CustomAppLoader(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
