import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../data/controller/exported_controllers.dart';
import '../../data/model/exported_models.dart';
import '../../shared/exported_shared.dart';
import '../widgets/exported_widgets.dart';
import 'exported_screens.dart';

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
  FocusNode switchFocusNode;

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
    switchFocusNode = FocusNode();

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
    switchFocusNode = FocusNode();
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 18), // Refer step 1
      firstDate: DateTime(1890),
      lastDate: DateTime(DateTime.now().year - 17),
      initialEntryMode: DatePickerEntryMode.input,
      initialDatePickerMode: DatePickerMode.year,
      helpText: 'Select your date of birth',
      errorFormatText: 'Please enter valid date',
      errorInvalidText: 'Please enter date in valid range',
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light().copyWith(
              background: Get.isDarkMode
                  ? kContentColorLightTheme
                  : kContentColorDarkTheme,
              primary: Get.isDarkMode ? kAccentColor : kLightPrimaryColor,
            ),
          ),
          child: child,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateOfBirthTextEditingController.text =
            '${selectedDate.toLocal()}'.split(' ')[0];
      });
    }
  }

  List<String> _idTypes;
  List<String> _titles;
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    if (_accountController.source == 1) {
      _idTypes = _accountController.formContent.idTypes
          .map((IdType e) => e.name)
          .toList();
      _titles = _accountController.formContent.titles;
    }

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
                if (_accountController.source == 1)
                  Text(
                    '(${_accountController.accountDto.phoneNumber})',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline1.copyWith(
                          fontSize: displayWidth(context) * 0.05,
                        ),
                  )
                else
                  const SizedBox(),
                sizedBoxHeight(context, 0.04),
                if (_accountController.source == 1)
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        AppDropdownField(
                          autoFocus: true,
                          inputFocusNode: accountType,
                          labelText: 'Account Type',
                          inputController: accountTypeTextEditingController,
                          items: _accountController.accountType,
                          textInputAction: TextInputAction.next,
                          inputOnFieldSubmitted: (String term) {
                            accountTypeTextEditingController.text =
                                term.toString();
                            _fieldFocusChange(
                              context,
                              accountType,
                              title,
                            );
                          },
                          onChanged: (String newValue) {
                            setState(() {
                              accountTypeTextEditingController.text =
                                  newValue.toString();
                              _fieldFocusChange(
                                context,
                                accountType,
                                title,
                              );
                            });
                          },
                        ),
                        AppDropdownField(
                          inputFocusNode: title,
                          labelText: 'Title',
                          inputController: titleTextEditingController,
                          items: _titles,
                          textInputAction: TextInputAction.next,
                          inputOnFieldSubmitted: (String term) {
                            titleTextEditingController.text = term.toString();
                            _fieldFocusChange(
                              context,
                              title,
                              firstName,
                            );
                          },
                          onChanged: (String newValue) {
                            setState(() {
                              titleTextEditingController.text =
                                  newValue.toString();
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
                          inputType: TextInputType.name,
                          inputLetterSpacing: displayWidth(context) * 0.004,
                          textInputAction: TextInputAction.next,
                          inputValidator: (String value) {
                            const String pattern = r'([A-Za-z]$)';
                            final RegExp regExp = RegExp(pattern);
                            if (value.isEmpty) {
                              return 'Please enter your first name';
                            } else if (!regExp.hasMatch(value)) {
                              return '''
First name has to be at least 4 characters long''';
                            }
                            debugPrint(value);
                            return null;
                          },
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
                          inputType: TextInputType.name,
                          inputLetterSpacing: displayWidth(context) * 0.004,
                          textInputAction: TextInputAction.next,
                          inputValidator: (String value) {
                            const String pattern = r'([A-Za-z]$)';
                            final RegExp regExp = RegExp(pattern);
                            if (value.isEmpty) {
                              return 'Please enter your first name';
                            } else if (!regExp.hasMatch(value)) {
                              return '''
Surname has to be at least 4 characters long''';
                            }
                            debugPrint(value);
                            return null;
                          },
                          inputOnFieldSubmitted: (String term) {
                            _fieldFocusChange(
                              context,
                              surname,
                              dateOfBirth,
                            );
                          },
                        ),
                        sizedBoxHeight(context, 0.02),
                        BaseInputField(
                          inputFocusNode: dateOfBirth,
                          labelText: 'Date of Birth',
                          inputController: dateOfBirthTextEditingController,
                          inputHintText: 'YYYY-MM-DD',
                          inputType: TextInputType.datetime,
                          inputLetterSpacing: displayWidth(context) * 0.004,
                          textInputAction: TextInputAction.next,
                          onTap: () => _selectDate(context),
                          inputOnFieldSubmitted: (String term) {
                            dateOfBirthTextEditingController.text =
                                term.toString();
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
                            idTypeTextEditingController.text = term.toString();
                            _fieldFocusChange(
                              context,
                              idType,
                              idNumber,
                            );
                          },
                          onChanged: (String newValue) {
                            setState(() {
                              idTypeTextEditingController.text =
                                  newValue.toString();
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
                          inputMaxLength: 13,
                          inputValidator: (String value) {
                            const String pattern = r'(^[0-9]{13}$)';
                            final RegExp regExp = RegExp(pattern);
                            if (value.isEmpty) {
                              return 'Please enter your selected ID number';
                            } else if (!regExp.hasMatch(value)) {
                              return '''
Please enter a valid 13-digit ID number''';
                            }
                            debugPrint(value);
                            return null;
                          },
                          inputOnFieldSubmitted: (String term) {
                            _fieldFocusChange(
                              context,
                              idNumber,
                              email,
                            );
                          },
                        ),
                        sizedBoxHeight(context, 0.02),
                        BaseInputField(
                          inputFocusNode: email,
                          labelText: 'Email Address',
                          inputController: emailTextEditingController,
                          inputType: TextInputType.emailAddress,
                          inputLetterSpacing: displayWidth(context) * 0.004,
                          textInputAction: TextInputAction.next,
                          inputValidator: (String value) {
                            const String pattern =
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                            final RegExp regExp = RegExp(pattern);
                            if (value.isEmpty) {
                              return 'Please enter your email address';
                            } else if (!regExp.hasMatch(value)) {
                              return '''
Please check and enter a valid email address''';
                            }
                            debugPrint(value);
                            return null;
                          },
                          inputOnFieldSubmitted: (String term) {
                            _fieldFocusChange(
                              context,
                              email,
                              switchFocusNode,
                            );
                          },
                        ),
                        sizedBoxHeight(context, 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              flex: 4,
                              child: Text(
                                'Are you being assisted by an Agent?',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    .copyWith(
                                      fontSize: displayWidth(context) * 0.05,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            Flexible(child: buildSwitch()),
                          ],
                        ),
                        Visibility(
                          visible: switchValue,
                          child: Column(
                            children: <Widget>[
                              sizedBoxHeight(context, 0.02),
                              BaseInputField(
                                inputFocusNode: assistedByAgentCode,
                                inputHintText: 'Agent Code',
                                inputMaxLength: 6,
                                inputController:
                                    assistedByAgentCodeTextEditingController,
                                inputType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                inputOnFieldSubmitted: (String term) {
                                  assistedByAgentCode.unfocus();
                                },
                              ),
                            ],
                          ),
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
                      inputHintText: '02****5678 / 05****5678',
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
                          _accountController.source = 0;
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
                              _accountController.securityDto.accountType =
                                  accountTypeTextEditingController.text;
                              _accountController.securityDto.title =
                                  titleTextEditingController.text;
                              _accountController.securityDto.surname =
                                  surnameTextEditingController.text;
                              _accountController.securityDto.firstName =
                                  firstNameTextEditingController.text;
                              _accountController.securityDto.dateOfBirth =
                                  selectedDate;
                              _accountController.securityDto.idType =
                                  idTypeTextEditingController.text;
                              _accountController.securityDto.idNumber =
                                  idNumberTextEditingController.text;
                              _accountController.securityDto.email =
                                  emailTextEditingController.text;
                              _accountController
                                      .securityDto.assistedByAgentCode =
                                  assistedByAgentCodeTextEditingController.text;

                              Get.toNamed(SecurityScreen.routeName);
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

  Widget buildSwitch() => Transform.scale(
        scale: 1.4,
        child: Switch.adaptive(
          focusNode: switchFocusNode,
          activeColor: kAccentColor,
          activeTrackColor: kLightPrimaryColor,
          value: switchValue,
          onChanged: (bool switchValue) => setState(() {
            this.switchValue = switchValue;
            _fieldFocusChange(
              context,
              switchFocusNode,
              assistedByAgentCode,
            );
          }),
        ),
      );
}
