import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppFonts {
  static TextStyle title = GoogleFonts.epilogue(
    color: AppColor.primarytextColor,
    fontWeight: FontWeight.w700,
    fontSize: 18,
    height: 22.5 / 18,
    letterSpacing: -0.27,
  );
  static TextStyle bottomNavigationText = GoogleFonts.epilogue(
    color: AppColor.secondarytextColor,
    fontWeight: FontWeight.w500,
    fontSize: 12,
    height: 18 / 12,
    letterSpacing: 0.18,
  );
  static TextStyle primaryText = GoogleFonts.epilogue(
    color: AppColor.primarytextColor,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 24 / 16,
  );
  static TextStyle secondaryText = GoogleFonts.epilogue(
    color: AppColor.secondarytextColor,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 21 / 14,
  );
  static TextStyle bigHeading = GoogleFonts.epilogue(
    color: AppColor.primarytextColor,
    fontWeight: FontWeight.w700,
    fontSize: 22,
    height: 27.5 / 22,
    letterSpacing: -0.33,
  );
  static TextStyle smallHeading = GoogleFonts.epilogue(
    color: AppColor.primarytextColor,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 24 / 16,
  );
  static TextStyle primarytextBig1 = GoogleFonts.epilogue(
    color: AppColor.primarytextColor,
    fontWeight: FontWeight.w700,
    fontSize: 32,
    height: 40 / 32,
    letterSpacing: -0.8,
  );
  static TextStyle primarytextBig2 = GoogleFonts.epilogue(
    color: AppColor.primarytextColor,
    fontWeight: FontWeight.w700,
    fontSize: 24,
    height: 30 / 24,
    letterSpacing: -0.6,
  );
  static TextStyle secondarytextBig3 = GoogleFonts.epilogue(
    color: AppColor.secondarytextColor,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 24 / 16,
  );
  static TextStyle primarytextBig3 = GoogleFonts.epilogue(
    color: AppColor.primarytextColor,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 24 / 16,
  );
  static TextStyle statusPercentage = GoogleFonts.epilogue(
    color: AppColor.greenStatusColor,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 24 / 16,
  );
  static TextStyle buttonText = GoogleFonts.epilogue(
    color: AppColor.primarytextColor,
    fontWeight: FontWeight.w700,
    fontSize: 14,
    height: 21 / 14,
    letterSpacing: 0.21,
  );
  static TextStyle graphLabel = GoogleFonts.epilogue(
    color: AppColor.secondarytextColor,
    fontWeight: FontWeight.w700,
    fontSize: 13,
    height: 19.5 / 13,
    letterSpacing: 0.19,
  );
  static TextStyle linkText = GoogleFonts.epilogue(
    color: AppColor.linkColor,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 21 / 14,
  );
}
