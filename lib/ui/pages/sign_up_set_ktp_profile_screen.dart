import 'dart:convert';
import 'dart:io';

import 'package:bank_sha/blocs/auth/auth_bloc.dart';
import 'package:bank_sha/models/sign_up_form_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/methods.dart';
import '../../shared/theme.dart';
import '../widgets/buttons.dart';

class SignUpSetKtpProfileScreen extends StatefulWidget {
  final SignUpFormModel data;

  const SignUpSetKtpProfileScreen({
    super.key,
    required this.data,
  });

  @override
  State<SignUpSetKtpProfileScreen> createState() =>
      _SignUpSetKtpProfileScreenState();
}

class _SignUpSetKtpProfileScreenState extends State<SignUpSetKtpProfileScreen> {
  XFile? selectedImage;

  bool validate() {
    if (selectedImage == null) {
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
                "Verify Your\nAccount",
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Upload Image KTP
                    GestureDetector(
                      onTap: () async {
                        final image = await selectImage();
                        setState(() {
                          selectedImage = image;
                        });
                      },
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.lightBackgroundColor,
                          image: selectedImage == null
                              ? null
                              : DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(File(selectedImage!.path)),
                                ),
                        ),
                        child: selectedImage != null
                            ? null
                            : Center(
                                child: Image.asset(
                                  "assets/ic_upload.png",
                                  width: 32,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Name
                    Text(
                      "Passport/ID Card",
                      style: AppTheme.blackTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: AppTheme.medium,
                      ),
                    ),
                    const SizedBox(height: 50),
                    // Button Sign In
                    CustomFilledButton(
                      title: "Continue",
                      onPressed: () {
                        if (validate()) {
                          context.read<AuthBloc>().add(
                                AuthRegister(
                                  widget.data.copyWith(
                                    ktp: selectedImage == null
                                        ? null
                                        : "data:image/${selectedImage!.path.split('.').last};base64,${base64Encode(
                                            File(selectedImage!.path)
                                                .readAsBytesSync(),
                                          )}",
                                  ),
                                ),
                              );
                        } else {
                          showCustomSnackbar(
                              context, "Gambar tidak boleh kosong");
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              CustomTextButton(
                title: "Skip for Now",
                onPressed: () {
                  context.read<AuthBloc>().add(AuthRegister(widget.data));

                  // Navigator.pushNamed(context, '/sign-up-success');
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
