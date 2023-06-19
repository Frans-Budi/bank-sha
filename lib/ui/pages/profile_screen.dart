import 'package:bank_sha/blocs/auth/auth_bloc.dart';
import 'package:bank_sha/shared/methods.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/widgets/buttons.dart';
import 'package:bank_sha/ui/widgets/profile_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            showCustomSnackbar(context, state.e);
          }

          if (state is AuthInitial) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/sign-in', (route) => false);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is AuthSuccess) {
            return ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                const SizedBox(height: 30),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 22),
                  decoration: BoxDecoration(
                    color: AppTheme.whiteColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      // Image Profile
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: state.user.profilePicture == null
                                ? const AssetImage("assets/img_profile.png")
                                : NetworkImage(state.user.profilePicture!)
                                    as ImageProvider,
                          ),
                        ),
                        child: state.user.verified == 1
                            ? Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppTheme.whiteColor,
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.check_circle,
                                      color: AppTheme.greenColor,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              )
                            : null,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "${state.user.name}",
                        style: AppTheme.blackTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: AppTheme.medium,
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Edit Profile
                      ProfileMenuItem(
                        iconUrl: "assets/ic_edit_profile.png",
                        title: "Edit Profile",
                        onTap: () async {
                          if (await Navigator.pushNamed(context, '/pin') ==
                              true) {
                            Navigator.pushNamed(context, '/profile-edit');
                          }
                        },
                      ),
                      // My Pin
                      ProfileMenuItem(
                        iconUrl: "assets/ic_pin.png",
                        title: "My Pin",
                        onTap: () async {
                          if (await Navigator.pushNamed(context, '/pin') ==
                              true) {
                            Navigator.pushNamed(context, '/profile-edit-pin');
                          }
                        },
                      ),
                      // Wallet Setting
                      ProfileMenuItem(
                        iconUrl: "assets/ic_wallet.png",
                        title: "Wallet Settings",
                        onTap: () {},
                      ),
                      // My Rewards
                      ProfileMenuItem(
                        iconUrl: "assets/ic_reward.png",
                        title: "My Rewards",
                        onTap: () {},
                      ),
                      // Help Center
                      ProfileMenuItem(
                        iconUrl: "assets/ic_help.png",
                        title: "Help Center",
                        onTap: () {},
                      ),
                      // Log Out
                      ProfileMenuItem(
                        iconUrl: "assets/ic_logout.png",
                        title: "Log Out",
                        onTap: () {
                          context.read<AuthBloc>().add(AuthLogout());
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 80),
                // Report Problem
                CustomTextButton(
                  title: "Report Problem",
                  onPressed: () {},
                ),
                const SizedBox(height: 50),
              ],
            );
          }

          return Container();
        },
      ),
    );
  }
}
