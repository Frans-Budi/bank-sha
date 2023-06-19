import 'package:bank_sha/blocs/auth/auth_bloc.dart';
import 'package:bank_sha/models/sign_in_form_model.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/widgets/buttons.dart';
import 'package:bank_sha/ui/widgets/forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/methods.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailC = TextEditingController();
  final passC = TextEditingController();

  bool validate() {
    if (emailC.text.isEmpty || passC.text.isEmpty) {
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

          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
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
                "Sign In &\nGrow Your Finance",
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
                        title: "Sign In",
                        onPressed: () {
                          if (validate()) {
                            context.read<AuthBloc>().add(AuthLogin(
                                  SignInFormModel(
                                    email: emailC.text,
                                    password: passC.text,
                                  ),
                                ));
                          } else {
                            showCustomSnackbar(
                                context, "Semua field harus diisi");
                          }
                          // Navigator.pushNamedAndRemoveUntil(
                          //     context, '/home', (route) => false);
                        },
                      ),
                    ],
                  )),
              const SizedBox(height: 50),
              CustomTextButton(
                title: "Create New Account",
                onPressed: () {
                  Navigator.pushNamed(context, '/sign-up');
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
