import 'package:daily_bite/features/user_recipes/bloc/user_recipes_bloc.dart';
import 'package:daily_bite/features/user_recipes/user_recipes_screen.dart';
import 'package:daily_bite/services/setup_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserRecipesWrapper extends StatelessWidget {
  const UserRecipesWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<UserRecipesBloc>()..add(const LoadUserRecipes()),
      child: const UserRecipesScreen(),
    );
  }
}
