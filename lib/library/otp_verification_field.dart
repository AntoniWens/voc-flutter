import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../color_font_util.dart';

class OtpVerificationField extends StatefulWidget {
  const OtpVerificationField({super.key, required this.onVerification});
  final Function(String) onVerification;

  @override
  State<OtpVerificationField> createState() => _OtpVerificationFieldState();
}

class _OtpVerificationFieldState extends State<OtpVerificationField> {

  final _controllers = List.generate(6, (index) => TextEditingController());
  final _focusNodes = List.generate(6, (index) => FocusNode());

  var _check = 0;

  bool validation() {
    var check = true;
    for (var element in _controllers) {
      if (element.text.isEmpty) {
        return check = false;
      }
    }
    return check;
  }

  String verificationCode() {
    var code = StringBuffer();
    for (var element in _controllers) {
      code.write(element.text);
    }
    return code.toString();
  }


  @override
  void initState() {
    ServicesBinding.instance.keyboard.addHandler((v) {
      var index = 0;
      if (v.logicalKey == LogicalKeyboardKey.backspace || v.physicalKey == PhysicalKeyboardKey.backspace) {
        if (_check == 0) {
          if (_focusNodes[0].hasFocus) {
            index = 0;
          } else if (_focusNodes[1].hasFocus) {
            index = 1;
          } else if (_focusNodes[2].hasFocus) {
            index = 2;
          } else if (_focusNodes[3].hasFocus) {
            index = 3;
          } else if (_focusNodes[4].hasFocus) {
            index = 4;
          } else if (_focusNodes[5].hasFocus) {
            index = 5;
          }

          if (_controllers[index].text.isEmpty && index != 0) {
            FocusScope.of(context).previousFocus();
          }
        }
        _check++;
        if (_check == 2) {
          _check = 0;
        }
      }

      return false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 50,
      child: ListView.builder(
          itemCount: 6,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 4, right: 4),
              child: SizedBox(
                width: 50,
                child: TextFormField(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  keyboardType: TextInputType.number,
                  cursorColor: ColorFontUtil.red02,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: ColorFontUtil.poppins,
                      fontSize: 18,
                      color: ColorFontUtil.red02,
                      fontWeight: FontWeight.w700
                  ),
                  maxLength: 1,
                  decoration: InputDecoration(
                    counterText: '',
                      fillColor: ColorFontUtil.grayE8,
                      filled: true,
                      contentPadding: EdgeInsets.zero,
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                  onChanged: (v) {
                    if (v.isNotEmpty) {
                      FocusScope.of(context).nextFocus();
                    }
                    if (validation()) {
                      widget.onVerification(verificationCode());
                      print(verificationCode());
                    }
                  },
                ),
              ),
            );
          }),
    );
  }
}
