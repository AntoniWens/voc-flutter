
import 'package:flutter/material.dart';

import '../color_font_util.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({super.key, required this.onTap, required this.selected, required this.hint, required this.label});

  final VoidCallback onTap;
  final String selected;
  final String hint;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
                color: ColorFontUtil.white,
                border: Border.all(color: ColorFontUtil.black25.withOpacity(0.2), width: 1),
                borderRadius: BorderRadius.circular(8)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(selected.isEmpty ? hint : selected, style: TextStyle(
                    fontFamily: ColorFontUtil.poppins,
                    color: selected.isEmpty ? ColorFontUtil.black25.withOpacity(0.5) : ColorFontUtil.black25
                ),),
                Icon(Icons.arrow_drop_down, color: ColorFontUtil.black25.withOpacity(0.5),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
