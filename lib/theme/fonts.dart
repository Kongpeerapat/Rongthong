import 'package:firebase_getx/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  static TextStyle big = GoogleFonts.notoSansThai(
      color: AppColor.black, fontSize: 48, fontWeight: FontWeight.normal);
  static TextStyle midderd = GoogleFonts.notoSansThai(
      color: AppColor.black, fontSize: 16, fontWeight: FontWeight.normal);
  static TextStyle headder = GoogleFonts.notoSansThai(
      color: AppColor.black, fontSize: 20, fontWeight: FontWeight.w900);

  static TextStyle fontpage = GoogleFonts.notoSerifThai(
      color: AppColor.black, fontSize: 16, fontWeight: FontWeight.w900);

  static TextStyle fonmanu = GoogleFonts.notoSerif(
      color: AppColor.black, fontSize: 24, fontWeight: FontWeight.w900);

  static TextStyle fontbotton = GoogleFonts.notoSerifThai(
      color: AppColor.white, fontSize: 20, fontWeight: FontWeight.w800);

  static TextStyle fonthinttext = GoogleFonts.notoSerifThai(
      color: AppColor.greyfont, fontSize: 15, fontWeight: FontWeight.w500);

  static TextStyle dataTextfiled = GoogleFonts.notoSerifThai(
      color: AppColor.black, fontSize: 15, fontWeight: FontWeight.w900);

  static TextStyle nameTextfiled = GoogleFonts.notoSerifThai(
      color: AppColor.black, fontSize: 12, fontWeight: FontWeight.w900);

  static TextStyle succes = GoogleFonts.notoSerifThai(
      color: AppColor.black, fontSize: 36, fontWeight: FontWeight.w900);

  static TextStyle headlinemanu = GoogleFonts.notoSerifThai(
      color: AppColor.black, fontSize: 20, fontWeight: FontWeight.w900);
}
