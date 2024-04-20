import 'package:flutter/material.dart';
import 'package:citgroupvn_eshop_seller/utill/dimensions.dart';
import 'package:citgroupvn_eshop_seller/utill/styles.dart';

class IconWithTextRow extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color? iconColor;
  final Color? textColor;
  final bool bold;
  const IconWithTextRow(
      {Key? key,
      required this.text,
      required this.icon,
      this.iconColor,
      this.textColor,
      this.bold = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon,
            color:
                iconColor ?? Theme.of(context).primaryColor.withOpacity(.30)),
        const SizedBox(
          width: Dimensions.paddingSizeSmall,
        ),
        Expanded(
          child: Text(text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: bold
                  ? titilliumSemiBold.copyWith(
                      fontSize: Dimensions.fontSizeDefault)
                  : titilliumRegular.copyWith(
                      fontSize: Dimensions.fontSizeDefault,
                      color: textColor ??
                          Theme.of(context).textTheme.bodyLarge?.color)),
        ),
      ],
    );
  }
}
