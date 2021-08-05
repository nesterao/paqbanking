import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pa_quick_banking/data/controller/account_controller.dart';
import 'package:pa_quick_banking/data/model/form_content.dart';
import 'package:pa_quick_banking/ui/screens/exported_screens.dart';

import '../../shared/exported_shared.dart';
import '../widgets/exported_widgets.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key key}) : super(key: key);

  static const String routeName = '/create_account_screen';

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController phoneNumberTextFieldController =
      TextEditingController();
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

  final AccountController _accountController = Get.find();
  DateTime selectedDate = DateTime.now();

  FocusNode phoneNumberFocusNode;
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

  @override
  void initState() {
    // TODO: implement initState
    // getData();
    phoneNumberFocusNode = FocusNode();
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
    phoneNumberFocusNode = FocusNode();
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
    phoneNumberTextFieldController.dispose();
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

  // Future<void> getData() async {
  //   // if (_accountController.source == 1) {
  //   await _accountController.fetchFormContent();
  //   _items = _accountController.formContent.idTypes
  //       .map((IdType e) => e.name)
  //       .toList();
  //   // }
  // }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 18), // Refer step 1
      firstDate: DateTime(1890),
      lastDate: DateTime(DateTime.now().year - 17),
      initialEntryMode: DatePickerEntryMode.input,
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateOfBirthTextEditingController.text =
            '${selectedDate.toLocal()}'.split(' ')[0];
      });
    }
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   phoneNumberFocusNode = FocusNode();
  //   _phoneNumberTextFieldController.dispose();
  //   super.dispose();
  // }
  List<String> _idTypes;
  List<String> _titles;
  List<String> _question1List;
  List<String> _question2List = [];

  @override
  Widget build(BuildContext context) {
    if (_accountController.source == 1) {
      _idTypes = _accountController.formContent.idTypes
          .map((IdType e) => e.name)
          .toList();
      _titles = _accountController.formContent.titles;
      _question1List = _accountController.formContent.questions
          .map((Question e) => e.text)
          .toList();
      // _question2List = _accountController.formContent.questions
      //     .map((Question e) => e.text)
      //     .toList();
    }

    // getData();

    return BaseBody(
      appBar: baseAppBar(
        context: context,
        title: _accountController.source == 1
            ? 'New Quick Account Form'
            : 'Open Quick Account',
        showActions: false,
      ),
      content: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(displayWidth(context) * 0.06),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  _accountController.source == 1
                      ? 'Please fill the form to create a new account.'
                      : 'Please provide a valid phone number to begin.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline1.copyWith(
                        fontSize: displayWidth(context) * 0.035,
                      ),
                ),
                sizedBoxHeight(context, 0.04),
                if (_accountController.source == 1)
                  Form(
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
                          inputOnFieldSubmitted: (String term) {
                            _fieldFocusChange(
                              context,
                              accountType,
                              firstName,
                            );
                          },
                        ),
                        AppDropdownField(
                          inputFocusNode: title,
                          labelText: 'Title',
                          inputController: idTypeTextEditingController,
                          items: _titles,
                          textInputAction: TextInputAction.next,
                          inputOnFieldSubmitted: (String term) {
                            _fieldFocusChange(
                              context,
                              title,
                              firstName,
                            );
                          },
                          onChanged: (String newValue) {
                            setState(() {
                              _fieldFocusChange(
                                context,
                                title,
                                firstName,
                              );
                            });
                          },
                        ),
                        BaseInputField(
                          inputFocusNode: firstName,
                          labelText: 'First Name',
                          inputController: firstNameTextEditingController,
                          inputType: TextInputType.text,
                          inputLetterSpacing: displayWidth(context) * 0.01,
                          textInputAction: TextInputAction.next,
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
                          inputOnFieldSubmitted: (String term) {
                            _fieldFocusChange(
                              context,
                              surname,
                              firstName,
                            );
                          },
                        ),
                        sizedBoxHeight(context, 0.02),
                        BaseInputField(
                          inputFocusNode: dateOfBirth,
                          labelText: 'Date of Birth',
                          inputController: dateOfBirthTextEditingController,
                          inputType: TextInputType.datetime,
                          inputLetterSpacing: displayWidth(context) * 0.01,
                          textInputAction: TextInputAction.next,
                          onTap: () => _selectDate(context),
                          inputOnFieldSubmitted: (String term) {
                            _fieldFocusChange(
                              context,
                              dateOfBirth,
                              idType,
                            );
                          },
                        ),
                        sizedBoxHeight(context, 0.02),
                        AppDropdownField(
                          inputFocusNode: idType,
                          labelText: 'Validation ID Type',
                          inputController: idTypeTextEditingController,
                          inputLetterSpacing: displayWidth(context) * 0.01,
                          items: _idTypes,
                          textInputAction: TextInputAction.next,
                          inputOnFieldSubmitted: (String term) {
                            _fieldFocusChange(
                              context,
                              idType,
                              idNumber,
                            );
                          },
                          onChanged: (String newValue) {
                            setState(() {
                              _fieldFocusChange(
                                context,
                                idType,
                                idNumber,
                              );
                            });
                          },
                        ),
                        BaseInputField(
                          inputFocusNode: idNumber,
                          labelText: 'ID Number',
                          inputController: idNumberTextEditingController,
                          inputType: TextInputType.number,
                          inputLetterSpacing: displayWidth(context) * 0.01,
                          textInputAction: TextInputAction.next,
                          inputOnFieldSubmitted: (String term) {
                            _fieldFocusChange(
                              context,
                              idType,
                              idNumber,
                            );
                          },
                        ),
                        sizedBoxHeight(context, 0.02),
                        AppDropdownField(
                          inputFocusNode: question1,
                          labelText: 'Security Question 1',
                          inputController: question1TextEditingController,
                          inputLetterSpacing: displayWidth(context) * 0.01,
                          items: _question1List,
                          textInputAction: TextInputAction.next,
                          inputOnFieldSubmitted: (String term) {
                            _fieldFocusChange(
                              context,
                              question1,
                              answer1,
                            );
                          },
                          onChanged: (String newValue) {
                            setState(() {
                              // _questions.remove(newValue);
                              _accountController.questions.removeWhere(
                                  (Question element) =>
                                      element.text == newValue);
                              _question2List = <String>[..._question1List];
                              _question2List.remove(newValue);
                              _fieldFocusChange(
                                context,
                                question1,
                                answer1,
                              );
                            });
                          },
                        ),
                        BaseInputField(
                          inputFocusNode: answer1,
                          labelText: 'Answer 1',
                          inputController: answer1TextEditingController,
                          inputType: TextInputType.text,
                          inputLetterSpacing: displayWidth(context) * 0.01,
                          textInputAction: TextInputAction.next,
                          inputOnFieldSubmitted: (String term) {
                            _fieldFocusChange(
                              context,
                              answer1,
                              question2,
                            );
                          },
                        ),
                        sizedBoxHeight(context, 0.02),
                        AppDropdownField(
                          inputFocusNode: question2,
                          labelText: 'Security Question 2',
                          inputController: question2TextEditingController,
                          inputLetterSpacing: displayWidth(context) * 0.01,
                          items: _question2List,
                          textInputAction: TextInputAction.next,
                          inputOnFieldSubmitted: (String term) {
                            _fieldFocusChange(
                              context,
                              question2,
                              answer2,
                            );
                          },
                          onChanged: (String newValue) {
                            setState(() {
                              _fieldFocusChange(
                                context,
                                question2,
                                answer2,
                              );
                            });
                          },
                        ),
                        BaseInputField(
                          inputFocusNode: answer2,
                          labelText: 'Answer 2',
                          inputController: answer2TextEditingController,
                          inputType: TextInputType.text,
                          inputLetterSpacing: displayWidth(context) * 0.01,
                          textInputAction: TextInputAction.next,
                          inputOnFieldSubmitted: (String term) {
                            _fieldFocusChange(
                              context,
                              answer2,
                              question2,
                            );
                          },
                        ),
                        sizedBoxHeight(context, 0.02),
                      ],
                    ),
                  )
                else
                  Form(
                    key: _formKey,
                    child: BaseInputField(
                      autoFocus: true,
                      inputFocusNode: phoneNumberFocusNode,
                      inputHintText: '0212345678 / 0512345678',
                      inputLabel: 'Phone Number',
                      inputMaxLength: 10,
                      inputController: phoneNumberTextFieldController,
                      inputType: TextInputType.number,
                      inputLetterSpacing: displayWidth(context) * 0.01,
                      textInputAction: TextInputAction.next,
                      inputFormatter: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
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
                  ),
                sizedBoxHeight(context, 0.04),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: SecondaryButton(
                        onTap: () {
                          Get.offAllNamed(WelcomeScreen.routeName);
                        },
                        text: 'Cancel',
                      ),
                    ),
                    sizedBoxWidth(context, 0.04),
                    Expanded(
                      child: PrimaryButton(
                        onTap: () async {
                          if (_formKey.currentState.validate()) {
                            if (_accountController.source == 1) {
                            } else {
                              await _accountController.verifyPhoneNumber(
                                  phoneNumberTextFieldController.text);
                            }
                          }
                        },
                        text: 'Next',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
