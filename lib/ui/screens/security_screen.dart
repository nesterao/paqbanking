import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_quick_banking/ui/screens/exported_screens.dart';

import '../../data/controller/exported_controllers.dart';
import '../../data/model/exported_models.dart';
import '../../shared/exported_shared.dart';
import '../widgets/exported_widgets.dart';

class SecurityScreen extends StatefulWidget {
  static const String routeName = '/security_screen';

  @override
  _SecurityScreenState createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  FocusNode motherMaidenName;
  FocusNode question1;
  FocusNode answer1;
  FocusNode question2;
  FocusNode answer2;

  final AccountController _accountController = Get.find();
  List<String> _question1List;
  List<String> _question2List = <String>[];

  @override
  void initState() {
    // TODO: implement initState

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
    if (_accountController.source == 1) {
      _question1List = _accountController.formContent.questions
          .map((Question e) => e.text)
          .toList();
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
            padding: EdgeInsets.all(displayWidth(context) * 0.06),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  _accountController.source == 1
                      ? 'Please fill the form to create a new account.'
                      : 'Please update your security information.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline1.copyWith(
                        fontSize: displayWidth(context) * 0.035,
                      ),
                ),
                sizedBoxHeight(context, 0.04),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      BaseInputField(
                        autoFocus: true,
                        inputFocusNode: motherMaidenName,
                        labelText: 'Mother Maiden Name',
                        inputController: motherMaidenNameTextEditingController,
                        inputType: TextInputType.name,
                        inputLetterSpacing: displayWidth(context) * 0.004,
                        textInputAction: TextInputAction.next,
                        inputValidator: (String value) {
                          const String pattern = r'([A-Za-z]$)';
                          final RegExp regExp = RegExp(pattern);
                          if (value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          debugPrint(value);
                          return null;
                        },
                        inputOnFieldSubmitted: (String term) {
                          _fieldFocusChange(
                            context,
                            motherMaidenName,
                            question1,
                          );
                        },
                      ),
                      sizedBoxHeight(context, 0.02),
                      AppDropdownField(
                        inputFocusNode: question1,
                        labelText: 'Security Question 1',
                        inputController: question1TextEditingController,
                        inputLetterSpacing: displayWidth(context) * 0.004,
                        items: _question1List,
                        textInputAction: TextInputAction.next,
                        inputOnFieldSubmitted: (String term) {
                          question1TextEditingController.text = term.toString();
                          _fieldFocusChange(
                            context,
                            question1,
                            answer1,
                          );
                        },
                        onChanged: (String newValue) {
                          setState(() {
                            question1TextEditingController.text =
                                newValue.toString();
                            _accountController.questions.removeWhere(
                                (Question element) => element.text == newValue);
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
                        inputLetterSpacing: displayWidth(context) * 0.004,
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
                        inputLetterSpacing: displayWidth(context) * 0.004,
                        items: _question2List,
                        textInputAction: TextInputAction.next,
                        inputOnFieldSubmitted: (String term) {
                          question2TextEditingController.text = term.toString();
                          _fieldFocusChange(
                            context,
                            question2,
                            answer2,
                          );
                        },
                        onChanged: (String newValue) {
                          setState(() {
                            question2TextEditingController.text =
                                newValue.toString();
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
                        inputLetterSpacing: displayWidth(context) * 0.004,
                        textInputAction: TextInputAction.next,
                        inputOnFieldSubmitted: (String term) {
                          answer2.unfocus();
                        },
                      ),
                      sizedBoxHeight(context, 0.02),
                    ],
                  ),
                ),
                sizedBoxHeight(context, 0.04),
                Row(
                  children: <Widget>[
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
                          text: 'Next',
                          onTap: () async {
                            if (_formKey.currentState.validate()) {
                              _accountController.securityDto.motherMaidenName =
                                  motherMaidenNameTextEditingController.text;
                              _accountController.securityDto.question1 =
                                  question1TextEditingController.text;
                              _accountController.securityDto.answer1 =
                                  answer1TextEditingController.text;
                              _accountController.securityDto.question2 =
                                  question2TextEditingController.text;
                              _accountController.securityDto.answer2 =
                                  answer2TextEditingController.text;

                              Get.toNamed(PinInput.routeName);
                            }
                          }),
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
