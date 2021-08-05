import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../shared/exported_shared.dart';

class BasePinInput extends StatefulWidget {
  const BasePinInput({
    Key key,
    this.length,
    this.autoFocus,
    this.obscureText,
    this.pinPutFocusNode,
    this.pinPutController,
    this.submit,
    this.validator,
  }) : super(key: key);

  final int length;
  final bool autoFocus;
  final bool obscureText;
  final FocusNode pinPutFocusNode;
  final TextEditingController pinPutController;
  final String Function(String e) submit;
  final String Function(String e) validator;

  @override
  _BasePinInputState createState() => _BasePinInputState();
}

class _BasePinInputState extends State<BasePinInput> {
  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      // dialogConfig: DialogConfig(
      //   dialogTitle: Constants.appName,
      //   affirmativeText: Constants.successTitle,
      //   negativeText: Constants.errorTitle,
      // ),
      appContext: context,
      length: widget.length,
      autoFocus: widget.autoFocus,
      focusNode: widget.pinPutFocusNode,
      controller: widget.pinPutController,
      obscureText: widget.obscureText,
      animationType: AnimationType.scale,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      keyboardType: TextInputType.number,
      enableActiveFill: true,
      textInputAction: TextInputAction.send,
      onCompleted: widget.submit,
      onChanged: (_) {},
      errorTextSpace: displayWidth(context) * 0.06,
      pinTheme: PinTheme.defaults(
        activeColor: kAccentColor,
        inactiveColor: Get.isDarkMode ? kLightPrimaryColor : kLightPrimaryColor,
        selectedColor: Get.isDarkMode ? kDarkTertiaryColor : kLightPrimaryColor,
        errorBorderColor: kErrorColor,
        fieldWidth: displayWidth(context) * 0.12,
        fieldHeight: displayWidth(context) * 0.15,
        borderWidth: 3,
        activeFillColor:
            Get.isDarkMode ? kContentColorLightTheme : kContentColorDarkTheme,
        inactiveFillColor:
            Get.isDarkMode ? kContentColorLightTheme : kContentColorDarkTheme,
        selectedFillColor:
            Get.isDarkMode ? kContentColorLightTheme : kContentColorDarkTheme,
      ),
      validator: widget.validator,
      textStyle: TextStyle(
        fontSize: displayWidth(context) * 0.044,
        color: Get.isDarkMode ? kLightTertiaryColor : kLightPrimaryColor,
      ),
    );
  }
}
