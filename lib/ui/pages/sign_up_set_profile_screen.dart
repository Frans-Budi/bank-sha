import 'dart:convert';
import 'dart:io';

import 'package:bank_sha/models/sign_up_form_model.dart';
import 'package:bank_sha/shared/methods.dart';
import 'package:bank_sha/ui/pages/sign_up_set_ktp_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../shared/theme.dart';
import '../widgets/buttons.dart';
import '../widgets/forms.dart';

class SignUpSetProfileScreen extends StatefulWidget {
  final SignUpFormModel data;

  const SignUpSetProfileScreen({
    super.key,
    required this.data,
  });

  @override
  State<SignUpSetProfileScreen> createState() => _SignUpSetProfileScreenState();
}

class _SignUpSetProfileScreenState extends State<SignUpSetProfileScreen> {
  final pinC = TextEditingController();
  XFile? selectedImage;

  bool validate() {
    if (pinC.text.length != 6) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Upload Image Profile
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
                  "Shayna Hanna",
                  style: AppTheme.blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: AppTheme.medium,
                  ),
                ),
                const SizedBox(height: 30),
                CustomFormField(
                  title: "Set PIN (6 digit number)",
                  obscureText: true,
                  controller: pinC,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 30),
                // Button Sign In
                CustomFilledButton(
                  title: "Continue",
                  onPressed: () {
                    if (validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpSetKtpProfileScreen(
                            data: widget.data.copyWith(
                              pin: pinC.text,
                              profilePicture: selectedImage == null
                                  ? null
                                  : "data:image/${selectedImage!.path.split('.').last};base64,${base64Encode(
                                      File(selectedImage!.path)
                                          .readAsBytesSync(),
                                    )}",
                            ),
                          ),
                        ),
                      );
                    } else {
                      showCustomSnackbar(context, 'PIN harus 6 digit');
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
