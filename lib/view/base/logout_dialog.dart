import 'package:efood_kitchen/util/dimensions.dart';
import 'package:efood_kitchen/util/styles.dart';
import 'package:flutter/material.dart';
import 'custom_button.dart';

class CustomLogOutDialog extends StatelessWidget {
  final bool isFailed;
  final double rotateAngle;
  final IconData icon;
  final bool delete;
  final String title;
  final String description;
  final Function()? onTapTrue;
  final String? onTapTrueText;
  final Function()? onTapFalse;
  final String? onTapFalseText;
  const CustomLogOutDialog({super.key, this.isFailed = false, this.rotateAngle = 0, required this.icon, required this.title,
    required this.description,required this.onTapFalse,required this.onTapTrue, this.onTapTrueText,
    this.onTapFalseText, this.delete = false});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(width: 300,
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
          child: Stack(clipBehavior: Clip.none, children: [

            Positioned(
              left: 0, right: 0, top:  -55,
              child: Container(
                height: delete ? 50: 80,
                width: delete ? 50 : 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: delete ? Colors.red : isFailed ?
                Colors.red : Theme.of(context).primaryColor,
                    shape: BoxShape.circle),
                child: Transform.rotate(angle: rotateAngle, child: Icon(icon, size: 40,
                    color: delete ? Theme.of(context).secondaryHeaderColor :Colors.white)),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text(title, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
                const SizedBox(height: Dimensions.paddingSizeSmall),
                Text(description, textAlign: TextAlign.center, style: robotoRegular),
                const SizedBox(height: Dimensions.paddingSizeLarge),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Row(
                    children: [

                      Expanded(child: CustomButton(buttonText: onTapFalseText,
                           isColor: true,
                           bgColor: Theme.of(context).disabledColor,
                           onPressed: onTapFalse)),
                      const SizedBox(width: 10,),

                      Expanded(child: CustomButton(buttonText: onTapTrueText,
                        onPressed: onTapTrue)),
                    ],
                  ),
                ),
              ]),
            ),

          ]),
        ),
      ),
    );
  }
}
