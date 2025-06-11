import 'package:daily_bite/app/app_bloc/app_bloc.dart';
import 'package:daily_bite/app/router.dart';
import 'package:daily_bite/core/constants/app_theme.dart';
import 'package:daily_bite/services/setup_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DailyBite extends StatelessWidget {
  const DailyBite({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AppBloc>(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'DailyBite',
        theme: AppTheme.lightTheme,
        routerConfig: router,
      ),
    );
  }
}
