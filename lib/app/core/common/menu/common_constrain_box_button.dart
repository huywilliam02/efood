import 'package:citgroupvn_efood_table/app/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonConstrainBoxButton extends StatelessWidget {
  const CommonConstrainBoxButton(
      {super.key, required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(width: context.width),
        child: ElevatedButton(
          style: ButtonStyle(
            minimumSize: const MaterialStatePropertyAll(Size(20, 60)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(
                const Color.fromRGBO(0, 133, 255, 76)),
            // padding: MaterialStateProperty.all(EdgeInsets.all(14)),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyleConstant.white16Roboto,
          ),
        ),
      ),
    );
  }
}
