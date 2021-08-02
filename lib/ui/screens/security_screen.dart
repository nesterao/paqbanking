import 'package:flutter/material.dart';

import '../../data/controller/controller.dart';
import '../../data/model/model.dart';
import '../../shared/shared.dart';
import '../widgets/widgets.dart';

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
  FocusNode kycLevel;
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
    // _listenOTP();
    accountType = FocusNode();
    kycLevel = FocusNode();
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
    kycLevel = FocusNode();
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

  @override
  Widget build(BuildContext context) {
    final AccountData _accountData =
        ModalRoute.of(context).settings.arguments as AccountData;

    Future<dynamic> submit() async {
      if (_formKey.currentState.validate()) {
        _accountController.validatePIN(accountData: _accountData);
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
                    // inputFocusNode: phoneNumberFocusNode,
                    inputLabel: 'Phone Number',
                    inputMaxLength: 10,
                    // inputController: _phoneNumberTextFieldController,
                    inputType: TextInputType.number,
                    inputLetterSpacing: displayWidth(context) * 0.01,
                    textInputAction: TextInputAction.next,
                    // inputFormatter: <TextInputFormatter>[
                    //   FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                    // ],
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
                    // inputOnFieldSubmitted: (String term) {
                    //   _fieldFocusChange(
                    //     context,
                    //     // phoneNumberFocusNode,
                    //     // accountNumberFocusNode,
                    //   );
                    // },
                  ),
                  sizedBoxHeight(context, 0.02),
                  // BaseInputField(
                  //   autoFocus: true,
                  //   labelText: 'The name of your favorite city in the world?',
                  //   inputHintText: 'Favorite City',
                  //   inputController: _favoriteCity,
                  // ),
                  // BaseInputField(
                  //   labelText: 'The name of your favorite pet?',
                  //   inputHintText: 'Favorite Pet',
                  //   inputController: _favoritePet,
                  // ),
                  // BaseInputField(
                  //   // ignore: avoid_escaping_inner_quotes
                  //   labelText: 'Your mother\'s maiden name?',
                  //   inputHintText: 'Mothers maiden name',
                  //   inputController: _mothersMaidenName,
                  // ),
                  // BaseInputField(
                  //   labelText: 'The ID type you used for account creation?',
                  //   inputHintText: 'National ID',
                  //   inputController: _idType,
                  // ),
                  // BaseInputField(
                  //   labelText: 'Your next of kin phone number?',
                  //   inputHintText: '0212 345 678',
                  //   inputController: _nextOfKinPhoneNumber,
                  // ),
                  // Row(
                  //   children: <Widget>[
                  //     Expanded(
                  //       child: PrimaryButton(
                  //         onTap: () {
                  //           Get.toNamed(LoginScreen.routeName);
                  //           // Navigator.of(context).pushNamed();
                  //         },
                  //         text: 'Next',
                  //       ),
                  //     ),
                  //     sizedBoxWidth(context, 0.04),
                  //     // SizedBox(width: 8,),
                  //     Expanded(
                  //       child: SecondaryButton(
                  //         onTap: () {
                  //           Navigator.of(context).pop();
                  //         },
                  //         text: 'Cancel',
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
