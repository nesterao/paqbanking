import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../data/controller/controller.dart';
import '../../shared/shared.dart';
import '../widgets/widgets.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key key}) : super(key: key);

  static const String routeName = '/create_account_screen';

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AccountController _accountController = AccountController();

  final TextEditingController _phoneNumberTextFieldController =
      TextEditingController();

  FocusNode phoneNumberFocusNode;

  @override
  void initState() {
    // TODO: implement initState
    // _listenOTP();
    phoneNumberFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    phoneNumberFocusNode = FocusNode();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBody(
      appBar: baseAppBar(
        context: context,
        title: 'New Quick Account',
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
                    'Welcome to Quick Banking',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline1.copyWith(
                          fontSize: displayWidth(context) * 0.05,
                        ),
                  ),
                  sizedBoxHeight(context, 0.01),
                  Text(
                    'Simply provide a valid phone number to begin.',
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
                      phoneNumberFocusNode.unfocus();
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
                                await _accountController.verifyPhoneNumber(
                                  phoneNumber:
                                      _phoneNumberTextFieldController.text,
                                );
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
