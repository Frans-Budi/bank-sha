import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color whiteColor = Color(0xffFFFFFF);
  static const Color blackColor = Color(0xff14193F);
  static const Color greyColor = Color(0xffA4A8AE);
  static const Color lightBackgroundColor = Color(0xffF1F1F9);
  static const Color darkBackgroundColor = Color(0xff020518);
  static const Color blueColor = Color(0xff53C1F9);
  static const Color purpleColor = Color(0xff5142E6);
  static const Color greenColor = Color(0xff22B07D);
  static const Color numberBackgroudColor = Color(0xff1A1D2E);
  static const Color redColor = Color(0xffFF2566);
  // static const Color olor = Color(0xff);

  static TextStyle blackTextStyle = GoogleFonts.poppins(
    color: blackColor,
  );
  static TextStyle whiteTextStyle = GoogleFonts.poppins(
    color: whiteColor,
  );
  static TextStyle greyTextStyle = GoogleFonts.poppins(
    color: greyColor,
  );
  static TextStyle blueTextStyle = GoogleFonts.poppins(
    color: blueColor,
  );
  static TextStyle greenTextStyle = GoogleFonts.poppins(
    color: greenColor,
  );

  static FontWeight light = FontWeight.w300;
  static FontWeight regular = FontWeight.w400;
  static FontWeight medium = FontWeight.w500;
  static FontWeight semiBold = FontWeight.w600;
  static FontWeight bold = FontWeight.w700;
  static FontWeight extraBold = FontWeight.w800;
  static FontWeight black = FontWeight.w900;
}
