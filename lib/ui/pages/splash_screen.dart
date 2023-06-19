import 'package:bank_sha/blocs/auth/auth_bloc.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        }

        if (state is AuthFailed) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/onBoarding', (route) => false);
        }
      },
      child: Scaffold(
        backgroundColor: AppTheme.darkBackgroundColor,
        body: Center(
          child: Container(
            width: 155,
            height: 50,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img_logo_dark.png"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
