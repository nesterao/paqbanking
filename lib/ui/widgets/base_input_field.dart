import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../shared/exported_shared.dart';

class BaseInputField extends StatefulWidget {
  const BaseInputField({
    Key key,
    this.inputLabel,
    this.autoFocus,
    this.obscureText,
    this.inputFocusNode,
    this.labelText,
    this.inputController,
    this.inputHintText,
    this.inputType,
    this.inputMaxLength,
    this.inputTextAlign,
    this.inputFontSize,
    this.inputLetterSpacing,
    this.inputOnFieldSubmitted,
    this.onEditingComplete,
    this.onTap,
    this.inputValidator,
    this.textInputAction,
    this.inputFormatter,
    this.inputErrorText,
  }) : super(key: key);

  final String inputLabel;
  final String labelText;
  final TextEditingController inputController;
  final String inputHintText;
  final bool obscureText;
  final int inputMaxLength;
  final double inputLetterSpacing;
  final bool autoFocus;
  final TextInputType inputType;
  final TextAlign inputTextAlign;
  final double inputFontSize;
  final FocusNode inputFocusNode;
  final Function(String e) inputOnFieldSubmitted;
  final VoidCallback onEditingComplete;
  final VoidCallback onTap;
  final List<TextInputFormatter> inputFormatter;
  final String Function(String e) inputValidator;
  final TextInputAction textInputAction;
  final String inputErrorText;

  @override
  _BaseInputFieldState createState() => _BaseInputFieldState();
}

class _BaseInputFieldState extends State<BaseInputField> {
  InputBorder _borderDecoration() {
    return const UnderlineInputBorder(
        borderSide: BorderSide(
      color: kAccentColor,
      width: 2,
    ));
  }

  InputBorder _focusedBorderDecoration() {
    return UnderlineInputBorder(
        borderSide: BorderSide(
      color: Get.isDarkMode ? kDarkSecondaryColor : kDarkPrimaryColor,
      width: 2,
    ));
  }

  InputBorder _errorBorderDecoration() {
    return const UnderlineInputBorder(
        borderSide: BorderSide(
      color: kErrorColor,
      width: 2,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.labelText != null && widget.labelText.isNotEmpty)
          Column(
            children: <Widget>[
              Text(
                widget.labelText,
                style: Theme.of(context).textTheme.headline6.copyWith(
                      fontSize: displayWidth(context) * 0.044,
                    ),
              ),
              sizedBoxHeight(context, 0.018),
            ],
          )
        else
          const SizedBox(),
        TextFormField(
          textAlign: widget.inputTextAlign ?? TextAlign.start,
          autofocus: widget.autoFocus ?? false,
          focusNode: widget.inputFocusNode,
          obscureText: widget.obscureText ?? false,
          cursorColor: Get.isDarkMode ? kAccentColor : kLightPrimaryColor,
          maxLength: widget.inputMaxLength,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          controller: widget.inputController,
          keyboardType: widget.inputType,
          validator: widget.inputValidator,
          onEditingComplete: widget.onEditingComplete,
          onFieldSubmitted: widget.inputOnFieldSubmitted,
          inputFormatters: widget.inputFormatter,
          onTap: widget.onTap,
          style: TextStyle(
            fontSize: displayWidth(context) * 0.05,
            letterSpacing: widget.inputLetterSpacing,
            color: Get.isDarkMode ? kAccentColor : kDarkPrimaryColor,
          ),
          decoration: InputDecoration(
            labelText: widget.inputLabel,
            errorText: widget.inputErrorText,
            hintText: widget.inputHintText ?? '',
            alignLabelWithHint: true,
            hintStyle: Theme.of(context).textTheme.headline6.copyWith(
                  fontSize: displayWidth(context) * 0.044,
                  color: Colors.grey,
                  letterSpacing: displayWidth(context) * 0.01,
                ),
            // contentPadding: const EdgeInsets.all(16.0),
            filled: true,
            fillColor:
                Get.isDarkMode ? kDarkPrimaryColor : kContentColorDarkTheme,
            labelStyle: TextStyle(
              fontSize: displayWidth(context) * 0.04,
              letterSpacing: 1,
              color: Get.isDarkMode ? kDarkTertiaryColor : kLightPrimaryColor,
            ),
            enabledBorder: _borderDecoration(),
            focusedBorder: _focusedBorderDecoration(),
            border: _borderDecoration(),
            errorBorder: _errorBorderDecoration(),
          ),
        ),
        if (widget.labelText != null && widget.labelText.isNotEmpty)
          sizedBoxHeight(context, 0.001)
        else
          const SizedBox(),
      ],
    );
  }
}
