import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/exported_shared.dart';

class AppDropdownField extends StatefulWidget {
  const AppDropdownField({
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
    this.onChanged,
    this.onEditingComplete,
    this.onTap,
    this.inputValidator,
    this.textInputAction,
    this.inputErrorText,
    this.items,
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
  final Function(String e) onChanged;
  final VoidCallback onEditingComplete;
  final VoidCallback onTap;
  final String Function(String e) inputValidator;
  final TextInputAction textInputAction;
  final String inputErrorText;
  final List<String> items;

  @override
  _AppDropdownFieldState createState() => _AppDropdownFieldState();
}

class _AppDropdownFieldState extends State<AppDropdownField> {
  InputBorder _borderDecoration() {
    return const UnderlineInputBorder(
        borderSide: BorderSide(
      color: kAccentColor,
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
        DropdownButtonFormField<String>(
          autofocus: widget.autoFocus ?? false,
          focusNode: widget.inputFocusNode,
          validator: widget.inputValidator,
          onTap: widget.onTap,
          onChanged: widget.onChanged,
          icon: Icon(
            Icons.arrow_drop_down,
            color: Get.isDarkMode ? kAccentColor : kLightPrimaryColor,
            size: displayWidth(context) * 0.06,
          ),
          elevation: 0,
          style: TextStyle(
            color: Get.isDarkMode ? kDarkSecondaryColor : kLightPrimaryColor,
          ),
          decoration: InputDecoration(
            labelText: widget.inputLabel,
            errorText: widget.inputErrorText,
            hintText: widget.inputHintText ?? '',
            hintStyle: Theme.of(context).textTheme.headline6.copyWith(
                  fontSize: displayWidth(context) * 0.044,
                  color: Colors.grey,
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
            focusedBorder: _borderDecoration(),
            border: _borderDecoration(),
            errorBorder: _errorBorderDecoration(),
          ),
          items: widget.items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        if (widget.labelText != null && widget.labelText.isNotEmpty)
          sizedBoxHeight(context, 0.02)
        else
          const SizedBox(),
      ],
    );
  }
}
