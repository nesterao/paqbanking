import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_quick_banking/data/controller/account_controller.dart';

import '../../shared/exported_shared.dart';
import '../widgets/exported_widgets.dart';

class PinInput extends StatefulWidget {
  static const String routeName = '/pin_input';

  @override
  _PinInputState createState() => _PinInputState();
}

class _PinInputState extends State<PinInput> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _pinPut1Controller = TextEditingController();
  final TextEditingController _pinPut2Controller = TextEditingController();
  final AccountController _accountController = Get.find();

  FocusNode _pinPut1FocusNode;
  FocusNode _pinPut2FocusNode;

  @override
  void initState() {
    // TODO: implement initState
    _pinPut1FocusNode = FocusNode();
    _pinPut2FocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pinPut1FocusNode = FocusNode();
    _pinPut2FocusNode = FocusNode();
    _pinPut1Controller.dispose();
    _pinPut2Controller.dispose();
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
    Future<dynamic> submit() async {
      if (_formKey.currentState.validate()) {
        if (_accountController.source == 1 &&
            _pinPut1Controller.text == _pinPut2Controller.text) {
          _accountController.securityDto.pin = _pinPut2Controller.text;
          _accountController.createNewAccount();
        }
        //TODO: Make Call to login function
        setState(() {
          _pinPut1Controller.text = '';
          _pinPut2Controller.text = '';
        });
      }
    }

    return BaseBody(
      appBar: baseAppBar(
        context: context,
        title: 'Account PIN',
        showBackButton: true,
        showActions: false,
      ),
      content: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(
                  displayWidth(context) * 0.08,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        _accountController.source == 1
                            ? 'Hello ${_accountController.securityDto.firstName},'
                            : 'Hello Link Account Name',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline1.copyWith(
                              fontSize: displayWidth(context) * 0.05,
                            ),
                      ),
                      sizedBoxHeight(context, 0.02),
                      Text(
                        _accountController.source == 1
                            ? 'Enter your new 4 digit PIN'
                            : 'Please enter your 4 digit PIN',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline1.copyWith(
                              fontSize: displayWidth(context) * 0.05,
                            ),
                      ),
                      sizedBoxHeight(context, 0.02),
                      if (_accountController.source == 1)
                        Column(
                          children: <Widget>[
                            BasePinInput(
                              autoFocus: true,
                              length: 4,
                              obscureText: true,
                              pinPutFocusNode: _pinPut1FocusNode,
                              pinPutController: _pinPut1Controller,
                              submit: (_) {
                                _fieldFocusChange(
                                  context,
                                  _pinPut1FocusNode,
                                  _pinPut2FocusNode,
                                );
                                return null;
                              },
                              validator: (String value) {
                                const String pattern = r'(^(\d{4})?$)';
                                final RegExp regExp = RegExp(pattern);
                                if (value.isEmpty) {
                                  return 'Please enter your PIN.';
                                } else if (!regExp.hasMatch(value)) {
                                  return 'Please enter a valid 4-digit PIN.';
                                }
                                return null;
                              },
                            ),
                            sizedBoxHeight(context, 0.04),
                            Text(
                              'Please confirm your new PIN',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(
                                    fontSize: displayWidth(context) * 0.05,
                                  ),
                            ),
                            sizedBoxHeight(context, 0.02),
                          ],
                        )
                      else
                        Text(
                          '(${_accountController.accountDto.phoneNumber})',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                letterSpacing: 4,
                                fontSize: displayWidth(context) * 0.05,
                              ),
                        ),
                      BasePinInput(
                        autoFocus: true,
                        length: 4,
                        obscureText: true,
                        pinPutFocusNode: _pinPut2FocusNode,
                        pinPutController: _pinPut2Controller,
                        submit: (_) {
                          if (_pinPut1Controller.text !=
                              _pinPut2Controller.text) {
                            DialogHelper.showErrorSnackBar(
                                'Your PIN do not match');
                            _pinPut1Controller.text = '';
                            _pinPut2Controller.text = '';
                          } else {
                            submit();
                          }
                          return null;
                        },
                        validator: (String value) {
                          const String pattern = r'(^(\d{4})?$)';
                          final RegExp regExp = RegExp(pattern);
                          if (value.isEmpty) {
                            return 'Please enter your PIN.';
                          } else if (!regExp.hasMatch(value)) {
                            return 'Please enter a valid 4-digit PIN.';
                          }
                          return null;
                        },
                      ),
                      sizedBoxHeight(context, 0.04),
                      Text(
                        'Make sure no one is looking at your PIN',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline1.copyWith(
                              fontSize: displayWidth(context) * 0.04,
                              color: Get.isDarkMode
                                  ? kAccentColor
                                  : Colors.blueGrey,
                            ),
                      ),
                      sizedBoxHeight(context, 0.04),
                      Visibility(
                        visible:
                            _accountController.userAccount.isQuickAccount ??
                                false,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot your PIN?'.toUpperCase(),
                            style:
                                Theme.of(context).textTheme.headline1.copyWith(
                                      decoration: TextDecoration.underline,
                                      fontSize: displayWidth(context) * 0.04,
                                    ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: displayWidth(context) * 0.04,
                      ),
                      PrimaryButton(
                        text: 'Submit',
                        onTap: submit,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
