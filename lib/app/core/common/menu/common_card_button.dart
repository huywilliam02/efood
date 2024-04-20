import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/color_constants.dart';

class CommonCardButton extends StatelessWidget {
  const CommonCardButton({
    Key? key,
    required this.title,
    this.icon,
    required this.iconButton,
    this.onPressed,
  }) : super(key: key);

  final String title;
  final String iconButton;
  final Icon? icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorConstant.backgroundColor,
      child: InkWell(
        onTap: onPressed,
        child: Card(
          elevation: 0,
          color: ColorConstant.backgroundColor,
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Image.asset(
                iconButton,
                height: 40,
                width: 40,
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  title,
                  style: GoogleFonts.roboto(
                    textStyle: TextStyleConstant.grey16RobotoBold,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
