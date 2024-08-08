import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../color_font_util.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.hintText, required this.label, this.controller, this.prefixIcon, this.readOnly,  this.obscure, this.suffixIcon, required this.textInputType, this.errorText, this.onChanged, this.inputFormatter});

  final String hintText;
  final String label;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? readOnly;
  final bool? obscure;
  final TextInputType textInputType;
  final String? errorText;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatter;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(
          fontFamily: ColorFontUtil.poppins,
          fontSize: 14,
          color: ColorFontUtil.black25,
          fontWeight: FontWeight.w500
        ),),
        const SizedBox(height: 4,),
        TextFormField(
          controller: controller,
            obscureText: obscure ?? false,
            cursorColor: ColorFontUtil.black25,
            readOnly: readOnly ?? false,
            keyboardType: textInputType,
            onChanged: onChanged,
            inputFormatters: inputFormatter,
            decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontFamily: ColorFontUtil.poppins,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: ColorFontUtil.black25.withOpacity(0.5),
                ),
                filled: true,
                fillColor: ColorFontUtil.white,
                contentPadding: const EdgeInsets.all(16),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorFontUtil.black25.withOpacity(0.2), width: 1),
                    borderRadius: BorderRadius.circular(8)
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorFontUtil.black25.withOpacity(0.2), width: 1),
                    borderRadius: BorderRadius.circular(8)
                ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              isDense: true,
              errorText: errorText,

            )
        )
      ],
    );
  }
}
