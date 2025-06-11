import 'dart:io';

import 'package:daily_bite/core/widgets/buttons/custom_button.dart';
import 'package:daily_bite/core/widgets/donut_chart.dart';
import 'package:daily_bite/features/profile_screen/profile_bloc/profile_bloc.dart';
import 'package:daily_bite/core/widgets/color_legend/color_legend.dart';
import 'package:daily_bite/features/profile_screen/widgets/profile_avatar.dart';
import 'package:daily_bite/models/nutrition_model/nutrition_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listenWhen: (previous, current) {
        return previous.userModel != null && current.userModel == null ||
            !previous.isLoggedOut && current.isLoggedOut;
      },
      listener: (context, state) {
        context.go('/auth');
      },
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.userModel == null) {
            return const SizedBox.shrink();
          }

          final user = state.userModel!;
          final nutrition = state.totalNutritionValue ??
              const NutritionModel(calories: 0, protein: 0, fat: 0, carbs: 0);
          final theme = Theme.of(context);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                ProfileAvatar(
                  imageUrl: user.imageUrl,
                  onEdit: () async {
                    final imagePicker = ImagePicker();
                    final pickedFile = await imagePicker.pickImage(
                        source: ImageSource.gallery);

                    if (pickedFile != null) {
                      final file = File(pickedFile.path);
                      if (context.mounted) {
                        context.read<ProfileBloc>().add(
                              UpdateUserProfile(photo: file),
                            );
                      }
                    }
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  user.email,
                  style: theme.textTheme.titleLarge
                      ?.copyWith(color: theme.colorScheme.secondary),
                ),
                const SizedBox(height: 48),
                Row(
                  children: [
                    ColorLegend(
                      nutrition: nutrition,
                    ),
                    Expanded(
                      child: NutrientDonutChart(
                        nutritionModel: nutrition,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 48),
                Center(
                  child: Text(
                    '*This is your general information in percentages\n for the dishes you have saved in your recipes,',
                    style: theme.textTheme.titleMedium
                        ?.copyWith(color: theme.colorScheme.onSecondary),
                  ),
                ),
                const Spacer(),
                CustomButton(
                  text: 'See my recipe',
                  onPressed: () {
                    context.push('/user_recipes');
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}
