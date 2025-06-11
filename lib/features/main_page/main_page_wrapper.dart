import 'package:daily_bite/features/chat_screen/chat_screen_bloc/chat_screen_bloc.dart';
import 'package:daily_bite/features/food_screen/food_bloc/food_screen_bloc.dart';
import 'package:daily_bite/features/main_page/main_page_bloc/main_page_bloc.dart';
import 'package:daily_bite/features/profile_screen/profile_bloc/profile_bloc.dart';
import 'package:daily_bite/services/app_service.dart';
import 'package:daily_bite/services/setup_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'main_page_screen.dart';

class MainPageWrapper extends StatelessWidget {
  const MainPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: getIt<ProfileBloc>()..add(LoadUserProfile()),
        ),
        BlocProvider(create: (_) => MainPageBloc()),
        BlocProvider.value(
          value: getIt<ChatScreenBloc>(),
        ),
        BlocProvider.value(
          value: getIt<FoodScreenBloc>()..add(FetchCategories()),
        ),
      ],
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.userModel == null) {
            getIt<AppService>().showLoader();
          } else {
            getIt<AppService>().hideLoader();
          }

          return const MainPageScreen();
        },
      ),
    );
  }
}
