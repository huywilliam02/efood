import 'package:citgroupvn_efood_table/app/core/constants/color_constants.dart';
import 'package:flutter/material.dart';

class CommonFormFieldWidget extends StatelessWidget {
  CommonFormFieldWidget(
      {super.key,
      this.focusNode,
      this.icon,
      this.errorText = "",
      this.labelText,
      this.controllerEditting,
      required this.setValueFunc,
      this.textInputType = TextInputType.text,
      this.isObscureText = false,
      this.isEnabled = true,
      this.initValue,
      this.padding = 10,
      this.suffixIcon,
      this.enableInteractiveSelection = true,
      this.styleInput = TextStyleConstant.black16Roboto,
      this.radiusBorder = 10,
      this.onEditingComplete});
  final FocusNode? focusNode;
  final Icon? icon;
  final Widget? suffixIcon;
  String? errorText;
  final String? labelText;
  final TextEditingController? controllerEditting;
  final VoidCallback? onEditingComplete;
  final Function setValueFunc;
  final TextInputType textInputType;
  final bool isObscureText;
  final bool? isEnabled;
  final String? initValue;
  final double? padding;
  final bool? enableInteractiveSelection;
  final TextStyle? styleInput;
  final double? radiusBorder;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      // height: 66,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: TextFormField(
          style: styleInput,
          enableInteractiveSelection: enableInteractiveSelection,
          initialValue: initValue,
          enabled: isEnabled,
          obscureText: isObscureText,
          focusNode: focusNode,
          decoration: InputDecoration(
            // filled: true,
            fillColor: Color(0xFFFFFFFF),
            contentPadding:
                EdgeInsets.symmetric(horizontal: padding!, vertical: 20),
            errorText: errorText != "" ? errorText : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: ColorConstant.greyE6E8EC,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blue),
            ),
            enabledBorder: OutlineInputBorder(
              // Màu của viền khi không focus
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: ColorConstant.greyE6E8EC,
              ),
            ),
            hintText: labelText,
            hintTextDirection: TextDirection.ltr,
            hintMaxLines: 3,
            prefixIcon: icon,
            suffixIcon: suffixIcon,
          ),
          textAlign: TextAlign.justify,
          maxLines: 1,
          keyboardType: textInputType,
          controller: controllerEditting,
          onChanged: (value) {
            setValueFunc(value);
          },
        ),
      ),
    );
  }
}
