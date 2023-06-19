import 'package:bank_sha/blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/methods.dart';
import '../../shared/theme.dart';
import '../widgets/buttons.dart';
import '../widgets/forms.dart';

class ProfileEditPinScreen extends StatefulWidget {
  const ProfileEditPinScreen({super.key});

  @override
  State<ProfileEditPinScreen> createState() => _ProfileEditPinScreenState();
}

class _ProfileEditPinScreenState extends State<ProfileEditPinScreen> {
  final oldPinC = TextEditingController();
  final newPinC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit PIN"),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            showCustomSnackbar(context, state.e);
          }

          if (state is AuthSuccess) {
            Navigator.pushNamed(context, '/profile-edit-success');
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
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
                    // Old PIN
                    CustomFormField(
                      title: "Old PIN",
                      obscureText: true,
                      controller: oldPinC,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    // New PIN
                    CustomFormField(
                      title: "New PIN",
                      obscureText: true,
                      controller: newPinC,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 30),
                    // Button Sign In
                    CustomFilledButton(
                      title: "Update Now",
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              AuthUpdatePin(oldPinC.text, newPinC.text),
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
    );
  }
}
