import 'package:flutter/material.dart';

class ColorConstant {
  static const blueGradient = [
    // Color(0xff996699),
    // Color(0xffCCFF33),
    Colors.white,
    Colors.white
  ];
  static const progress_background_color = Color(0xff1B2153);
  // static const common_bg_dark = Color.fromARGB(255, 23, 32, 74);
  static const backgroundColor = Colors.white;
  static const buttonTabView = Color.fromRGBO(0, 133, 255, 100);

  static const black = Color(0xff000326);
  static const white = Color(0xfff0f2f1);
  static const gray9e9e9e = Color(0xff9e9e9e);
  static const text = Color(0xff9e9e9e);
  static const secondary1 = Color.fromARGB(255, 166, 163, 163);
  static const grey70747E = Color(0xff70747E);
  static const pinkFFF1F3 = Color(0xffFFF1F3);
  static const blue0085FF = Color.fromRGBO(0, 133, 255, 91);
  static const yellowFFF2AF = Color(0xffFFF2AF);
  static const grey = Color.fromARGB(12, 86, 86, 91);
  static const grey777E90 = Color.fromRGBO(119, 126, 144, 100);
  static const greyE6E8EC = Color.fromRGBO(230, 232, 236, 100);
  static const greyF4F5F6 = Color.fromRGBO(244, 245, 246, 100);
  static const gray777E90 = Color.fromRGBO(119, 126, 144, 100);
  static const red = Color(0xffF70D1A);
  static const cyanResume = Color(0xffCCFFFF);
  static const green = Color(0xff5adc78);
}

class TextStyleConstant {
  static const _fontWeightBold = FontWeight.w500;
  static const _fontWeightNormal = FontWeight.normal;

  static const grey12Roboto = TextStyle(
      fontSize: 12,
      color: Color.fromRGBO(119, 126, 144, 100),
      fontWeight: FontWeight.normal,
      fontFamily: "Roboto");
  static const grey14Roboto = TextStyle(
      fontSize: 14,
      color: Color.fromRGBO(119, 126, 144, 100),
      fontWeight: FontWeight.bold,
      fontFamily: "Roboto");

  static const black16Roboto =
      TextStyle(fontSize: 16, color: Colors.black, fontFamily: "Roboto");

  static const black20RobotoBold = TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontFamily: "Roboto-Bold",
      fontWeight: FontWeight.bold);

  static const black40RobotoBold =
      TextStyle(fontSize: 40, color: Colors.black, fontFamily: "Roboto-Bold");
  static const black60RobotoBold =
      TextStyle(fontSize: 60, color: Colors.black, fontFamily: "Roboto-Bold");
  static const black16RobotoThin =
      TextStyle(fontSize: 16, color: Colors.black, fontFamily: "Roboto-Thin");
  static const white16Roboto =
      TextStyle(fontSize: 16, color: Colors.white, fontFamily: "Roboto");
  static const white18Roboto =
      TextStyle(fontSize: 18, color: Colors.white, fontFamily: "Roboto");
  static const white16RobotoThin =
      TextStyle(fontSize: 16, color: Colors.white, fontFamily: "Roboto-Thin");
  static const white22RobotoBold =
      TextStyle(fontSize: 22, color: Colors.white, fontFamily: "Roboto-Bold");
  static const white50RobotoBold =
      TextStyle(fontSize: 50, color: Colors.white, fontFamily: "Roboto-Bold");
  static const purple16RobotoBold =
      TextStyle(fontSize: 16, color: Colors.purple, fontFamily: "Roboto-Bold");
  static const purple22RobotoBold =
      TextStyle(fontSize: 22, color: Colors.purple, fontFamily: "Roboto-Bold");
  static const grey16RobotoBold =
      TextStyle(fontSize: 16, color: Colors.grey, fontFamily: "Roboto-Bold");
  static const red22RobotoBold = TextStyle(
      fontSize: 22, color: Colors.redAccent, fontFamily: "Roboto-Bold");
//purple

  static const blackBold16 = TextStyle(
    fontSize: 16,
    color: ColorConstant.black,
    fontWeight: _fontWeightBold,
  );

  static const blackRegular16 = TextStyle(
    fontSize: 16,
    color: ColorConstant.black,
    fontWeight: _fontWeightNormal,
  );

  static const whiteBold16 = TextStyle(
    fontSize: 16,
    color: ColorConstant.white,
    fontWeight: _fontWeightBold,
  );
  static const whiteBold22 = TextStyle(
    fontSize: 22,
    color: ColorConstant.white,
    fontWeight: _fontWeightBold,
  );
  static const whiteBold25 = TextStyle(
    fontSize: 25,
    color: ColorConstant.white,
    fontWeight: _fontWeightBold,
  );

  static const whiteRegular16 = TextStyle(
    fontSize: 16,
    color: ColorConstant.white,
    fontWeight: _fontWeightNormal,
  );
  static const greyRegular16 = TextStyle(
    fontSize: 16,
    color: ColorConstant.grey,
    fontWeight: _fontWeightNormal,
  );
  static const textBold16 = TextStyle(
    fontSize: 16,
    color: ColorConstant.text,
    fontWeight: _fontWeightBold,
  );

  static const textRegular16 = TextStyle(
    fontSize: 16,
    color: ColorConstant.text,
    fontWeight: _fontWeightNormal,
  );
}
