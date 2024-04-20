import 'package:citgroupvn_efood_table/app/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static TextStyle textTitleLogin = GoogleFonts.roboto(
    textStyle: TextStyleConstant.grey16RobotoBold,
    fontSize: 20,
    color: const Color.fromRGBO(35, 38, 47, 100),
    fontWeight: FontWeight.bold,
  );
  static TextStyle textTitleForm = GoogleFonts.roboto(
    textStyle: TextStyleConstant.grey16RobotoBold,
    fontSize: 13,
    color: const Color.fromRGBO(53, 57, 69, 100),
    fontWeight: FontWeight.w800,
  );
  static TextStyle textTitleAppBar = GoogleFonts.roboto(
    textStyle: TextStyleConstant.grey16RobotoBold,
    fontSize: 18,
    color: Colors.white,
    fontWeight: FontWeight.w800,
  );
  static TextStyle textTitleStatistical = GoogleFonts.roboto(
    textStyle: TextStyleConstant.grey16RobotoBold,
    fontSize: 14,
    color: const Color.fromRGBO(53, 57, 69, 100),
    fontWeight: FontWeight.w800,
  );
  static TextStyle textName = GoogleFonts.roboto(
    textStyle: TextStyleConstant.white16Roboto,
    fontSize: 12,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
  );
  static TextStyle textButton = GoogleFonts.roboto(
    textStyle: TextStyleConstant.white16Roboto,
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
  );

  static TextStyle textTitleFormobligatory = GoogleFonts.roboto(
    textStyle: TextStyleConstant.red22RobotoBold,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
  );
  static TextStyle textRowTitle = GoogleFonts.roboto(
    textStyle: TextStyleConstant.black16Roboto,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );
  static TextStyle textRowLabel = GoogleFonts.roboto(
    textStyle: TextStyleConstant.grey16RobotoBold,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );
}
