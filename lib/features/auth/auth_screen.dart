import 'package:daily_bite/core/widgets/main_layout.dart';
import 'package:daily_bite/features/auth/auth_bloc/auth_screen_bloc.dart';
import 'package:daily_bite/features/auth/widgets/login_form.dart';
import 'package:daily_bite/features/auth/widgets/register_form.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: BlocListener<AuthScreenBloc, AuthScreenState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.go('/main_page');
          }
        },
        child: BlocBuilder<AuthScreenBloc, AuthScreenState>(
          builder: (context, state) {
            if (state is AuthScreenInitial) {
              _emailController.text = state.email;
              _passwordController.text = state.password;
              _nameController.text = state.name;
            }

            return Column(
              children: [
                const SizedBox(height: 90),
                Text(
                  'DailyBite',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 110),
                TabBar(
                  controller: _tabController,
                  labelColor: Theme.of(context).colorScheme.primary,
                  labelStyle: Theme.of(context).textTheme.headlineMedium,
                  unselectedLabelColor: Theme.of(context).colorScheme.secondary,
                  indicatorColor: Theme.of(context).colorScheme.primary,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: const [
                    Tab(text: 'Login'),
                    Tab(text: 'Register'),
                  ],
                ),
                const SizedBox(height: 70),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      LoginForm(
                        emailController: _emailController,
                        passwordController: _passwordController,
                        onTapForgotPassword: () {
                          final email = _emailController.text;
                          context.go('/auth/forgot_password', extra: email);
                        },
                        onTapLogin: () async {
                          context.read<AuthScreenBloc>().add(
                                LoginEvent(
                                  password: _passwordController.text,
                                  email: _emailController.text,
                                ),
                              );
                        },
                        onTapLoginGoogle: () {
                          context
                              .read<AuthScreenBloc>()
                              .add(GoogleLoginEvent());
                        },
                      ),
                      RegisterForm(
                        nameController: _nameController,
                        emailController: _emailController,
                        passwordController: _passwordController,
                        onTapRegisterGoogle: () {
                          context
                              .read<AuthScreenBloc>()
                              .add(GoogleLoginEvent());
                        },
                        onTapRegister: () {
                          context.read<AuthScreenBloc>().add(
                                RegisterEvent(
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                ),
                              );
                        },
                      ),
                    ],
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
