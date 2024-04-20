

import 'package:efood_kitchen/util/dimensions.dart';
import 'package:efood_kitchen/util/styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final String? buttonText;
  final bool? transparent;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final double? radius;
  final IconData? icon;
  final bool isColor;
  final Color bgColor;
  final Color? textColor;
  const CustomButton({super.key, this.onPressed, @required this.buttonText, this.transparent = false, this.margin, this.width, this.height,
    this.fontSize, this.radius = 5, this.icon,  this.isColor = false,  this.bgColor = Colors.black26,  this.textColor});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: onPressed != null && !isColor? Theme.of(context).primaryColor : transparent!
          ? Colors.transparent :isColor? bgColor : Theme.of(context).secondaryHeaderColor,
      minimumSize: Size(width != null ? width! : Dimensions.webMaxWidth, height != null ? height! : 40),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius!),
      ),
    );

    return Center(child: SizedBox(width: width ?? Dimensions.webMaxWidth, child: Padding(
      padding: margin == null ? const EdgeInsets.all(0) : margin!,
      child: TextButton(
        onPressed: onPressed,
        style: flatButtonStyle,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          icon != null ? Padding(
            padding: const EdgeInsets.only(right: Dimensions.paddingSizeExtraSmall),
            child: Icon(icon, color: transparent! ? Theme.of(context).primaryColor : Theme.of(context).cardColor),
          ) : const SizedBox(),
          Text(buttonText ??'', textAlign: TextAlign.center, style: robotoRegular.copyWith(
            color: transparent! ? Theme.of(context).primaryColor : Colors.white,
            fontSize: fontSize ?? Dimensions.fontSizeLarge,
          )),
        ]),
      ),
    )));
  }
}