import 'package:bank_sha/blocs/auth/auth_bloc.dart';
import 'package:bank_sha/blocs/user/user_bloc.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/pages/data_provider_screen.dart';
import 'package:bank_sha/ui/pages/data_success_screen.dart';
import 'package:bank_sha/ui/pages/home_screen.dart';
import 'package:bank_sha/ui/pages/onBoarding_screen.dart';
import 'package:bank_sha/ui/pages/pin_screen.dart';
import 'package:bank_sha/ui/pages/profile_edit_pin_screen.dart';
import 'package:bank_sha/ui/pages/profile_edit_screen.dart';
import 'package:bank_sha/ui/pages/profile_edit_success_screen.dart';
import 'package:bank_sha/ui/pages/profile_screen.dart';
import 'package:bank_sha/ui/pages/sign_in_screen.dart';
import 'package:bank_sha/ui/pages/sign_up_screen.dart';
import 'package:bank_sha/ui/pages/sign_up_success_screen.dart';
import 'package:bank_sha/ui/pages/splash_screen.dart';
import 'package:bank_sha/ui/pages/topup_screen.dart';
import 'package:bank_sha/ui/pages/topup_success.dart';
import 'package:bank_sha/ui/pages/transfer_screen.dart';
import 'package:bank_sha/ui/pages/transfer_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc()..add(AuthGetCurrentUser()),
        ),
        BlocProvider(
          create: (context) => UserBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppTheme.lightBackgroundColor,
          appBarTheme: AppBarTheme(
            backgroundColor: AppTheme.lightBackgroundColor,
            elevation: 0,
            centerTitle: true,
            iconTheme: const IconThemeData(color: AppTheme.blackColor),
            titleTextStyle: AppTheme.blackTextStyle
                .copyWith(fontSize: 20, fontWeight: AppTheme.semiBold),
          ),
        ),
        routes: {
          '/': (context) => const SplashScreen(),
          '/onBoarding': (context) => const OnBoardingScreen(),
          '/sign-in': (context) => const SignInScreen(),
          '/sign-up': (context) => const SignUpScreen(),
          '/sign-up-success': (context) => const SignUpSuccessScreen(),
          '/home': (context) => const HomeScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/pin': (context) => const PinScreen(),
          '/profile-edit': (context) => const ProfileEditScreen(),
          '/profile-edit-pin': (context) => const ProfileEditPinScreen(),
          '/profile-edit-success': (context) =>
              const ProfileEditSuccessScreen(),
          '/topup': (context) => const TopupScreen(),
          '/topup-success': (context) => const TopupSuccess(),
          '/transfer': (context) => const TransferScreen(),
          '/transfer-success': (context) => const TransferSuccessScreen(),
          '/data-provider': (context) => const DataProviderScreen(),
          '/data-success': (context) => const DataSuccessScreen(),
        },
      ),
    );
  }
}
