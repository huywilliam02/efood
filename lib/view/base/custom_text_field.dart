import 'package:efood_kitchen/util/dimensions.dart';
import 'package:efood_kitchen/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool isPassword;
  final Function? onChanged;
  final Function? onSubmit;
  final bool isEnabled;
  final int maxLines;
  final TextCapitalization capitalization;
  final String? prefixIcon;
  final String? suffix;

  const CustomTextField(
      {super.key, this.hintText = 'Write something...',
        required this.controller,
        this.focusNode,
        this.nextFocus,
        this.isEnabled = true,
        this.inputType = TextInputType.text,
        this.inputAction = TextInputAction.next,
        this.maxLines = 1,
        this.onSubmit,
        this.onChanged,
        this.prefixIcon,
        this.capitalization = TextCapitalization.none,
        this.isPassword = false, this.suffix,
      });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: widget.maxLines,
      controller: widget.controller,
      focusNode: widget.focusNode,
      style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge),
      textInputAction: widget.inputAction,
      keyboardType: widget.inputType,
      cursorColor: Theme.of(context).primaryColor,
      textCapitalization: widget.capitalization,
      enabled: widget.isEnabled,
      autofocus: false,
      autofillHints: widget.inputType == TextInputType.name ? [AutofillHints.name]
          : widget.inputType == TextInputType.emailAddress ? [AutofillHints.email]
          : widget.inputType == TextInputType.phone ? [AutofillHints.telephoneNumber]
          : widget.inputType == TextInputType.streetAddress ? [AutofillHints.fullStreetAddress]
          : widget.inputType == TextInputType.url ? [AutofillHints.url]
          : widget.inputType == TextInputType.visiblePassword ? [AutofillHints.password] : null,
      obscureText: widget.isPassword ? _obscureText : false,
      inputFormatters: widget.inputType == TextInputType.phone ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9+]'))] : null,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          borderSide: const BorderSide(style: BorderStyle.none, width: 0),
        ),
        isDense: true,
        hintText: widget.hintText,
        fillColor: Theme.of(context).highlightColor,
        hintStyle: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor),
        filled: true,
        prefixIcon:  widget.prefixIcon != null ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
          child: SizedBox(height: 20, width: 20, child: Image.asset(widget.prefixIcon!,
            scale: 25,color: Theme.of(context).hintColor,)),
        ) : null,
        suffixIcon:widget.suffix !=null ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
          child: SizedBox(height: 20, width: 20, child: Image.asset(widget.suffix!, scale: 50,)),
        ): widget.isPassword ? IconButton(
          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: Theme.of(context).hintColor.withOpacity(0.3)),
          onPressed: _toggle,
        ) : null,
      ),
      onSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus)
          : widget.onSubmit != null ? widget.onSubmit!(text) : null,
      onChanged: widget.onChanged != null ? widget.onChanged!() : null,
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}