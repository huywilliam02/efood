import 'package:flutter/material.dart';
import 'package:citgroupvn_eshop_seller/utill/dimensions.dart';
import 'package:citgroupvn_eshop_seller/utill/styles.dart';

class CustomContainer extends StatelessWidget {
  final String title;
  final Function()? onTap;
  const CustomContainer({Key? key, required this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 0,
            Dimensions.paddingSizeDefault, Dimensions.paddingSizeExtraLarge),
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeSmall),
          height: 45,
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
              border:
                  Border.all(width: .35, color: Theme.of(context).hintColor)),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                title,
                style: robotoRegular,
              )),
              const Icon(
                Icons.arrow_drop_down,
              )
            ],
          ),
        ),
      ),
    );
  }
}
