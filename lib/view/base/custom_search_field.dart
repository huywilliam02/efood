import 'package:efood_kitchen/helper/responsive_helper.dart';
import 'package:efood_kitchen/util/dimensions.dart';
import 'package:efood_kitchen/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CustomSearchField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final IconData prefix;
  final IconData suffix;
  final Function() iconPressed;
  final Function(String text)? onChanged;
  final bool isFilter;
  const CustomSearchField({super.key, 
    required this.controller,
    required this.hint,
    required this.prefix,
    required this.iconPressed,
    this.onChanged,
    this.isFilter = false,
    required this.suffix,
  });

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: TextField(
          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9+]'))],
          controller: widget.controller,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: robotoRegular.copyWith(fontSize: ResponsiveHelper.isSmallTab() ?  Dimensions.fontSizeDefault : Dimensions.fontSizeSmall,
                color: Theme.of(context).disabledColor),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1),
            ),
            filled: true, fillColor: Theme.of(context).cardColor,
            isDense: true,

            prefixIcon: IconButton(
              icon: Icon(widget.prefix, color: Theme.of(context).hintColor), onPressed: widget.iconPressed,
            ),
            suffixIcon: IconButton(
              icon: Icon(widget.suffix, color: Theme.of(context).hintColor),
              onPressed: widget.iconPressed,
            ),
          ),
          onChanged: widget.onChanged,

        ),
      ),

    ],);
  }
}
