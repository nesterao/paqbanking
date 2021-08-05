import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pa_quick_banking/data/controller/account_controller.dart';

import '../../shared/exported_shared.dart';
import '../widgets/exported_widgets.dart';

class SecurityScreen extends StatefulWidget {
  static const String routeName = '/security_screen';

  @override
  _SecurityScreenState createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController accountTypeTextEditingController =
      TextEditingController();
  final TextEditingController firstNameTextEditingController =
      TextEditingController();
  final TextEditingController surnameTextEditingController =
      TextEditingController();
  final TextEditingController dateOfBirthTextEditingController =
      TextEditingController();
  final TextEditingController idTypeTextEditingController =
      TextEditingController();
  final TextEditingController idNumberTextEditingController =
      TextEditingController();
  final TextEditingController titleTextEditingController =
      TextEditingController();
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController assistedByAgentCodeTextEditingController =
      TextEditingController();
  final TextEditingController motherMaidenNameTextEditingController =
      TextEditingController();
  final TextEditingController question1TextEditingController =
      TextEditingController();
  final TextEditingController answer1TextEditingController =
      TextEditingController();
  final TextEditingController question2TextEditingController =
      TextEditingController();
  final TextEditingController answer2TextEditingController =
      TextEditingController();

  FocusNode accountType;
  FocusNode firstName;
  FocusNode surname;
  FocusNode dateOfBirth;
  FocusNode idType;
  FocusNode idNumber;
  FocusNode title;
  FocusNode email;
  FocusNode assistedByAgentCode;
  FocusNode motherMaidenName;
  FocusNode question1;
  FocusNode answer1;
  FocusNode question2;
  FocusNode answer2;

  final AccountController _accountController = AccountController();

  @override
  void initState() {
    // TODO: implement initState
    accountType = FocusNode();
    firstName = FocusNode();
    surname = FocusNode();
    dateOfBirth = FocusNode();
    idType = FocusNode();
    idNumber = FocusNode();
    title = FocusNode();
    email = FocusNode();
    assistedByAgentCode = FocusNode();
    motherMaidenName = FocusNode();
    question1 = FocusNode();
    answer1 = FocusNode();
    question2 = FocusNode();
    answer2 = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    accountType = FocusNode();
    firstName = FocusNode();
    surname = FocusNode();
    dateOfBirth = FocusNode();
    idType = FocusNode();
    idNumber = FocusNode();
    title = FocusNode();
    email = FocusNode();
    assistedByAgentCode = FocusNode();
    motherMaidenName = FocusNode();
    question1 = FocusNode();
    answer1 = FocusNode();
    question2 = FocusNode();
    answer2 = FocusNode();
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

  void getter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final int _source = _accountController.source;

    debugPrintSynchronously(_accountController.source.toString());
    Future<dynamic> submit() async {
      if (_formKey.currentState.validate()) {
        setState(() {});
      }
    }

    return BaseBody(
      appBar: baseAppBar(
        context: context,
        title: 'Security Questions',
        showActions: false,
      ),
      content: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(displayWidth(context) * 0.04),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  BaseInputField(
                    autoFocus: true,
                    inputFocusNode: accountType,
                    labelText: 'Account Type',
                    inputMaxLength: 10,
                    inputController: accountTypeTextEditingController,
                    inputType: TextInputType.text,
                    inputLetterSpacing: displayWidth(context) * 0.01,
                    textInputAction: TextInputAction.next,
                    // inputFormatter: <TextInputFormatter>[
                    //   FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                    // ],
                    inputOnFieldSubmitted: (String term) {
                      _fieldFocusChange(
                        context,
                        accountType,
                        firstName,
                      );
                    },
                  ),
                  BaseInputField(
                    inputFocusNode: firstName,
                    labelText: 'First Name',
                    inputController: firstNameTextEditingController,
                    inputType: TextInputType.text,
                    inputLetterSpacing: displayWidth(context) * 0.01,
                    textInputAction: TextInputAction.next,
                    // inputFormatter: <TextInputFormatter>[
                    //   FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                    // ],
                    inputOnFieldSubmitted: (String term) {
                      _fieldFocusChange(
                        context,
                        firstName,
                        surname,
                      );
                    },
                  ),
                  sizedBoxHeight(context, 0.02),
                  BaseInputField(
                    inputFocusNode: surname,
                    labelText: 'Surname',
                    inputController: surnameTextEditingController,
                    inputType: TextInputType.text,
                    inputLetterSpacing: displayWidth(context) * 0.01,
                    textInputAction: TextInputAction.next,
                    // inputFormatter: <TextInputFormatter>[
                    //   FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                    // ],
                    inputOnFieldSubmitted: (String term) {
                      _fieldFocusChange(
                        context,
                        surname,
                        firstName,
                      );
                    },
                  ),
                  sizedBoxHeight(context, 0.02),
                  // BaseInputField(
                  //   autoFocus: true,
                  //   inputFocusNode: accountType,
                  //   inputLabel: 'Account Type',
                  //   inputMaxLength: 10,
                  //   inputController: accountTypeTextEditingController,
                  //   inputType: TextInputType.text,
                  //   inputLetterSpacing: displayWidth(context) * 0.01,
                  //   textInputAction: TextInputAction.next,
                  //   // inputFormatter: <TextInputFormatter>[
                  //   //   FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                  //   // ],
                  //   inputOnFieldSubmitted: (String term) {
                  //     _fieldFocusChange(
                  //       context,
                  //       accountType,
                  //       firstName,
                  //     );
                  //   },
                  // ),
                  // sizedBoxHeight(context, 0.02),
                  // BaseInputField(
                  //   autoFocus: true,
                  //   inputFocusNode: accountType,
                  //   inputLabel: 'Account Type',
                  //   inputMaxLength: 10,
                  //   inputController: accountTypeTextEditingController,
                  //   inputType: TextInputType.text,
                  //   inputLetterSpacing: displayWidth(context) * 0.01,
                  //   textInputAction: TextInputAction.next,
                  //   // inputFormatter: <TextInputFormatter>[
                  //   //   FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                  //   // ],
                  //   inputOnFieldSubmitted: (String term) {
                  //     _fieldFocusChange(
                  //       context,
                  //       accountType,
                  //       firstName,
                  //     );
                  //   },
                  // ),
                  // sizedBoxHeight(context, 0.02),
                  // BaseInputField(
                  //   autoFocus: true,
                  //   inputFocusNode: accountType,
                  //   inputLabel: 'Account Type',
                  //   inputMaxLength: 10,
                  //   inputController: accountTypeTextEditingController,
                  //   inputType: TextInputType.text,
                  //   inputLetterSpacing: displayWidth(context) * 0.01,
                  //   textInputAction: TextInputAction.next,
                  //   // inputFormatter: <TextInputFormatter>[
                  //   //   FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                  //   // ],
                  //   inputOnFieldSubmitted: (String term) {
                  //     _fieldFocusChange(
                  //       context,
                  //       accountType,
                  //       firstName,
                  //     );
                  //   },
                  // ),
                  // sizedBoxHeight(context, 0.02),
                  // BaseInputField(
                  //   autoFocus: true,
                  //   inputFocusNode: accountType,
                  //   inputLabel: 'Account Type',
                  //   inputMaxLength: 10,
                  //   inputController: accountTypeTextEditingController,
                  //   inputType: TextInputType.text,
                  //   inputLetterSpacing: displayWidth(context) * 0.01,
                  //   textInputAction: TextInputAction.next,
                  //   // inputFormatter: <TextInputFormatter>[
                  //   //   FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                  //   // ],
                  //   inputOnFieldSubmitted: (String term) {
                  //     _fieldFocusChange(
                  //       context,
                  //       accountType,
                  //       firstName,
                  //     );
                  //   },
                  // ),
                  // sizedBoxHeight(context, 0.02),
                  // BaseInputField(
                  //   autoFocus: true,
                  //   inputFocusNode: accountType,
                  //   inputLabel: 'Account Type',
                  //   inputMaxLength: 10,
                  //   inputController: accountTypeTextEditingController,
                  //   inputType: TextInputType.text,
                  //   inputLetterSpacing: displayWidth(context) * 0.01,
                  //   textInputAction: TextInputAction.next,
                  //   // inputFormatter: <TextInputFormatter>[
                  //   //   FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                  //   // ],
                  //   inputOnFieldSubmitted: (String term) {
                  //     _fieldFocusChange(
                  //       context,
                  //       accountType,
                  //       firstName,
                  //     );
                  //   },
                  // ),
                  // sizedBoxHeight(context, 0.02),
                  // BaseInputField(
                  //   autoFocus: true,
                  //   inputFocusNode: accountType,
                  //   inputLabel: 'Account Type',
                  //   inputMaxLength: 10,
                  //   inputController: accountTypeTextEditingController,
                  //   inputType: TextInputType.text,
                  //   inputLetterSpacing: displayWidth(context) * 0.01,
                  //   textInputAction: TextInputAction.next,
                  //   // inputFormatter: <TextInputFormatter>[
                  //   //   FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                  //   // ],
                  //   inputOnFieldSubmitted: (String term) {
                  //     _fieldFocusChange(
                  //       context,
                  //       accountType,
                  //       firstName,
                  //     );
                  //   },
                  // ),
                  // sizedBoxHeight(context, 0.02),
                  // BaseInputField(
                  //   autoFocus: true,
                  //   inputFocusNode: accountType,
                  //   inputLabel: 'Account Type',
                  //   inputMaxLength: 10,
                  //   inputController: accountTypeTextEditingController,
                  //   inputType: TextInputType.text,
                  //   inputLetterSpacing: displayWidth(context) * 0.01,
                  //   textInputAction: TextInputAction.next,
                  //   // inputFormatter: <TextInputFormatter>[
                  //   //   FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                  //   // ],
                  //   inputOnFieldSubmitted: (String term) {
                  //     _fieldFocusChange(
                  //       context,
                  //       accountType,
                  //       firstName,
                  //     );
                  //   },
                  // ),
                  // sizedBoxHeight(context, 0.02),
                  // BaseInputField(
                  //   autoFocus: true,
                  //   inputFocusNode: accountType,
                  //   inputLabel: 'Account Type',
                  //   inputMaxLength: 10,
                  //   inputController: accountTypeTextEditingController,
                  //   inputType: TextInputType.text,
                  //   inputLetterSpacing: displayWidth(context) * 0.01,
                  //   textInputAction: TextInputAction.next,
                  //   // inputFormatter: <TextInputFormatter>[
                  //   //   FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                  //   // ],
                  //   inputOnFieldSubmitted: (String term) {
                  //     _fieldFocusChange(
                  //       context,
                  //       accountType,
                  //       firstName,
                  //     );
                  //   },
                  // ),
                  // sizedBoxHeight(context, 0.02),
                  // BaseInputField(
                  //   autoFocus: true,
                  //   inputFocusNode: accountType,
                  //   inputLabel: 'Account Type',
                  //   inputMaxLength: 10,
                  //   inputController: accountTypeTextEditingController,
                  //   inputType: TextInputType.text,
                  //   inputLetterSpacing: displayWidth(context) * 0.01,
                  //   textInputAction: TextInputAction.next,
                  //   // inputFormatter: <TextInputFormatter>[
                  //   //   FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                  //   // ],
                  //   inputOnFieldSubmitted: (String term) {
                  //     _fieldFocusChange(
                  //       context,
                  //       accountType,
                  //       firstName,
                  //     );
                  //   },
                  // ),
                  // sizedBoxHeight(context, 0.02),
                  // BaseInputField(
                  //   autoFocus: true,
                  //   inputFocusNode: accountType,
                  //   inputLabel: 'Account Type',
                  //   inputMaxLength: 10,
                  //   inputController: accountTypeTextEditingController,
                  //   inputType: TextInputType.text,
                  //   inputLetterSpacing: displayWidth(context) * 0.01,
                  //   textInputAction: TextInputAction.next,
                  //   // inputFormatter: <TextInputFormatter>[
                  //   //   FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                  //   // ],
                  //   inputOnFieldSubmitted: (String term) {
                  //     _fieldFocusChange(
                  //       context,
                  //       accountType,
                  //       firstName,
                  //     );
                  //   },
                  // ),
                  // sizedBoxHeight(context, 0.02),
                  // BaseInputField(
                  //   autoFocus: true,
                  //   inputFocusNode: accountType,
                  //   inputLabel: 'Account Type',
                  //   inputMaxLength: 10,
                  //   inputController: accountTypeTextEditingController,
                  //   inputType: TextInputType.text,
                  //   inputLetterSpacing: displayWidth(context) * 0.01,
                  //   textInputAction: TextInputAction.next,
                  //   // inputFormatter: <TextInputFormatter>[
                  //   //   FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                  //   // ],
                  //   inputOnFieldSubmitted: (String term) {
                  //     _fieldFocusChange(
                  //       context,
                  //       accountType,
                  //       firstName,
                  //     );
                  //   },
                  // ),
                  sizedBoxHeight(context, 0.02),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: PrimaryButton(
                          onTap: () {
                            // Get.toNamed(LoginScreen.routeName);
                            // Navigator.of(context).pushNamed();
                          },
                          text: 'Next',
                        ),
                      ),
                      sizedBoxWidth(context, 0.04),
                      // SizedBox(width: 8,),
                      Expanded(
                        child: SecondaryButton(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          text: 'Cancel',
                        ),
                      ),
                    ],
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
