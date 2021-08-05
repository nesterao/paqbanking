import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../shared/exported_shared.dart';
import '../widgets/exported_widgets.dart';

class LinkAccountScreen extends StatefulWidget {
  const LinkAccountScreen({Key key}) : super(key: key);

  static const String routeName = '/link_account_screen';

  @override
  _LinkAccountScreenState createState() => _LinkAccountScreenState();
}

class _LinkAccountScreenState extends State<LinkAccountScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final AccountController _accountController = AccountController();

  final TextEditingController _phoneNumberTextFieldController =
      TextEditingController();
  final TextEditingController _accountNumberTextFieldController =
      TextEditingController();

  FocusNode phoneNumberFocusNode;
  FocusNode accountNumberFocusNode;

  @override
  void initState() {
    // TODO: implement initState
    // _listenOTP();
    phoneNumberFocusNode = FocusNode();
    accountNumberFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    phoneNumberFocusNode = FocusNode();
    accountNumberFocusNode = FocusNode();
    super.dispose();
  }

  void _fieldFocusChange(
    BuildContext context,
    FocusNode currentFocus,
    FocusNode nextFocus,
  ) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return BaseBody(
      appBar: baseAppBar(
        context: context,
        title: 'Link Account',
        showActions: false,
      ),
      content: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(displayWidth(context) * 0.06),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Link Account Form',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline1.copyWith(
                          fontSize: displayWidth(context) * 0.05,
                        ),
                  ),
                  sizedBoxHeight(context, 0.01),
                  Text(
                    'Fill the form with your account details.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline1.copyWith(
                          fontSize: displayWidth(context) * 0.035,
                        ),
                  ),
                  sizedBoxHeight(context, 0.04),
                  BaseInputField(
                    autoFocus: true,
                    inputFocusNode: phoneNumberFocusNode,
                    inputLabel: 'Phone Number',
                    inputMaxLength: 10,
                    inputController: _phoneNumberTextFieldController,
                    inputType: TextInputType.number,
                    inputLetterSpacing: displayWidth(context) * 0.01,
                    textInputAction: TextInputAction.next,
                    inputFormatter: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                    ],
                    inputValidator: (String value) {
                      const String pattern = r'(^0[2,5]{1}[0-9]+$)';
                      final RegExp regExp = RegExp(pattern);
                      if (value.isEmpty) {
                        return 'Please enter your mobile number';
                      } else if (!regExp.hasMatch(value)) {
                        return '''
Please enter a valid 10-digit mobile number''';
                      }
                      debugPrint(value);
                      return null;
                    },
                    inputOnFieldSubmitted: (String term) {
                      _fieldFocusChange(
                        context,
                        phoneNumberFocusNode,
                        accountNumberFocusNode,
                      );
                    },
                  ),
                  sizedBoxHeight(context, 0.02),
                  BaseInputField(
                    inputFocusNode: accountNumberFocusNode,
                    inputLabel: 'Account Number',
                    inputType: TextInputType.number,
                    inputMaxLength: 13,
                    inputController: _accountNumberTextFieldController,
                    inputLetterSpacing: displayWidth(context) * 0.01,
                    textInputAction: TextInputAction.send,
                    inputFormatter: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                    ],
                    inputValidator: (String value) {
                      const String pattern = r'(^(\d{13})?$)';
                      final RegExp regExp = RegExp(pattern);
                      if (value.isEmpty) {
                        return 'Please enter your account number';
                      } else if (!regExp.hasMatch(value)) {
                        return 'Please enter a valid 13-digit account number';
                      }
                      return null;
                    },
                    inputOnFieldSubmitted: (String term) {
                      accountNumberFocusNode.unfocus();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: Row(
                      children: <Widget>[
                        // SizedBox(width: 8,),
                        Expanded(
                          child: SecondaryButton(
                            onTap: () {
                              Get.back();
                            },
                            text: 'Cancel',
                          ),
                        ),
                        sizedBoxWidth(context, 0.04),
                        Expanded(
                          child: PrimaryButton(
                            onTap: () async {
                              if (_formKey.currentState.validate()) {
                                // await _accountController.checkLinkAccount(
                                //     phoneNumber:
                                //         _phoneNumberTextFieldController.text,
                                //     accountNumber:
                                //         _accountNumberTextFieldController.text);
                              }
                            },
                            text: 'Next',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
