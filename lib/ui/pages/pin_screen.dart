import 'dart:async';

import 'package:bank_sha/blocs/auth/auth_bloc.dart';
import 'package:bank_sha/shared/methods.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  final TextEditingController pinController = TextEditingController();
  String pin = '';
  bool isError = false;

  void addPin(String number) {
    if (pinController.text.length < 6) {
      setState(() {
        isError = false;
        pinController.text = pinController.text + number;
      });
    }

    if (pinController.text.length == 6) {
      if (pinController.text == pin) {
        Navigator.pop(context, true);
      } else {
        setState(() {
          isError = true;
        });
        showCustomSnackbar(
            context, "PIN yang anda masukkan salah. Silakan coba lagi.");
      }
    }
  }

  deletePin() {
    if (pinController.text.isNotEmpty) {
      setState(() {
        isError = false;
        pinController.text =
            pinController.text.substring(0, pinController.text.length - 1);
      });
    }
  }

  @override
  void initState() {
    super.initState();

    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccess) {
      pin = authState.user.pin!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 58),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title
              Text(
                "Sha PIN",
                style: AppTheme.whiteTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: AppTheme.semiBold,
                ),
              ),
              const SizedBox(height: 72),
              // Input PIN
              SizedBox(
                width: 200,
                child: TextFormField(
                  controller: pinController,
                  obscureText: true,
                  enabled: false,
                  cursorColor: AppTheme.greyColor,
                  obscuringCharacter: '*',
                  style: AppTheme.whiteTextStyle.copyWith(
                    fontSize: 36,
                    fontWeight: AppTheme.medium,
                    letterSpacing: 16,
                    color: isError ? AppTheme.redColor : AppTheme.whiteColor,
                  ),
                  decoration: const InputDecoration(
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.greyColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.greyColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 66),
              // Button PIN
              Wrap(
                spacing: 40,
                runSpacing: 40,
                alignment: WrapAlignment.end,
                children: [
                  CustomInputButton(
                    title: "1",
                    onTap: () => addPin('1'),
                  ),
                  CustomInputButton(
                    title: "2",
                    onTap: () => addPin('2'),
                  ),
                  CustomInputButton(
                    title: "3",
                    onTap: () => addPin('3'),
                  ),
                  CustomInputButton(
                    title: "4",
                    onTap: () => addPin('4'),
                  ),
                  CustomInputButton(
                    title: "5",
                    onTap: () => addPin('5'),
                  ),
                  CustomInputButton(
                    title: "6",
                    onTap: () => addPin('6'),
                  ),
                  CustomInputButton(
                    title: "7",
                    onTap: () => addPin('7'),
                  ),
                  CustomInputButton(
                    title: "8",
                    onTap: () => addPin('8'),
                  ),
                  CustomInputButton(
                    title: "9",
                    onTap: () => addPin('9'),
                  ),
                  CustomInputButton(
                    title: "0",
                    onTap: () => addPin('0'),
                  ),
                  GestureDetector(
                    onTap: () => deletePin(),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.numberBackgroudColor,
                      ),
                      child: const Center(
                        child:
                            Icon(Icons.arrow_back, color: AppTheme.whiteColor),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
