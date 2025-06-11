import 'package:daily_bite/core/constants/storage_keys.dart';
import 'package:daily_bite/core/widgets/buttons/custom_button.dart';
import 'package:daily_bite/features/welcome_screen/welcome_screen_bloc/welcome_screen_bloc.dart';
import 'package:daily_bite/features/welcome_screen/widgets/onboarding_page.dart';
import 'package:daily_bite/services/setup_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeContext = Theme.of(context);
    return BlocListener<WelcomeScreenBloc, WelcomeScreenState>(
      listener: (context, state) {},
      child: Scaffold(
        backgroundColor: themeContext.colorScheme.surface,
        body: BlocBuilder<WelcomeScreenBloc, WelcomeScreenState>(
          builder: (context, state) {
            return Stack(
              children: [
                PageView(
                  controller: _controller,
                  children: const [
                    OnboardingPage(
                      image: 'assets/images/welcome.png',
                      title: 'Welcome to DailyBite!',
                      description:
                          'Start your journey to healthy eating today! We will help you simplify the choice of healthy meals and track your progress.',
                    ),
                    OnboardingPage(
                        image: 'assets/images/ai.png',
                        title: 'Smart nutrition based on AI',
                        description:
                            'Our AI will help you create personalized meals based on your needs and preferences. You can also easily calculate the calorie content of each product!,'),
                    OnboardingPage(
                      image: 'assets/images/diagram.png',
                      title: 'Visualization of your success',
                      description:
                          'Track your progress with visual graphs. Analyze data and achieve new goals more efficiently!If anything needs to be changed or added, let me know!',
                    ),
                  ],
                ),
                Positioned(
                  bottom: 120,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: SmoothPageIndicator(
                      controller: _controller,
                      onDotClicked: _onPageChanged,
                      count: 3,
                      effect: ExpandingDotsEffect(
                        activeDotColor: themeContext.colorScheme.primary,
                        dotColor: themeContext.colorScheme.secondary,
                        dotHeight: 16,
                        dotWidth: 24,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: CustomButton(
                      text: 'Get Started',
                      onPressed: () {
                        getIt<FlutterSecureStorage>().write(
                          key: StorageKeys.isVisitAppBefore,
                          value: DateTime.now().toIso8601String(),
                        );

                        context.go('/auth');
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
