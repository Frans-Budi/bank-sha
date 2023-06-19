import 'package:bank_sha/blocs/auth/auth_bloc.dart';
import 'package:bank_sha/models/sign_up_form_model.dart';
import 'package:bank_sha/shared/methods.dart';
import 'package:bank_sha/ui/pages/sign_up_set_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/theme.dart';
import '../widgets/buttons.dart';
import '../widgets/forms.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final passC = TextEditingController();

  bool validate() {
    if (nameC.text.isEmpty || emailC.text.isEmpty || passC.text.isEmpty) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            showCustomSnackbar(context, state.e);
          }

          if (state is AuthCheckEmailSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignUpSetProfileScreen(
                  data: SignUpFormModel(
                    name: nameC.text,
                    email: emailC.text,
                    password: passC.text,
                  ),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            children: [
              // Logo
              Container(
                height: 50,
                margin: const EdgeInsets.only(top: 100, bottom: 100),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/img_logo_light.png"),
                  ),
                ),
              ),
              // Title
              Text(
                "Join Us to Unlock\nYour Growth",
                style: AppTheme.blackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: AppTheme.semiBold,
                ),
              ),
              const SizedBox(height: 30),
              // Card
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: AppTheme.whiteColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // NOTE: Name Input
                    CustomFormField(
                      title: "Full Name",
                      controller: nameC,
                    ),
                    const SizedBox(height: 16),
                    // NOTE: Email Input
                    CustomFormField(
                      title: "Email Adress",
                      controller: emailC,
                    ),
                    const SizedBox(height: 16),
                    // NOTE: Password Input
                    CustomFormField(
                      title: "Password",
                      obscureText: true,
                      controller: passC,
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot Password",
                        style: AppTheme.blueTextStyle,
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Button Sign In
                    CustomFilledButton(
                      title: "Continue",
                      onPressed: () {
                        if (validate()) {
                          context
                              .read<AuthBloc>()
                              .add(AuthCheckEmail(emailC.text));
                        } else {
                          showCustomSnackbar(
                              context, 'Semua field harus diisi');
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              CustomTextButton(
                title: "Sign In",
                onPressed: () {
                  Navigator.pushNamed(context, '/sign-in');
                },
              ),
              const SizedBox(height: 30),
            ],
          );
        },
      ),
    );
  }
}
