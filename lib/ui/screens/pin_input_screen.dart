import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_quick_banking/data/model/account_model.dart';

import '../../data/controller/controller.dart';
import '../../shared/shared.dart';
import '../widgets/widgets.dart';

class PinInput extends StatefulWidget {
  static const String routeName = '/pin_input';

  @override
  _PinInputState createState() => _PinInputState();
}

class _PinInputState extends State<PinInput> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _pinPutController = TextEditingController();
  final AccountController _accountController = AccountController();

  FocusNode _pinPutFocusNode;

  @override
  void initState() {
    // TODO: implement initState
    _pinPutFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pinPutFocusNode = FocusNode();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AccountData _accountData =
        ModalRoute.of(context).settings.arguments as AccountData;

    Future<dynamic> submit() async {
      if (_formKey.currentState.validate()) {
        _accountData.accountDetails.pin = _pinPutController.text;
        _accountController.validatePIN(accountData: _accountData);
        setState(() {
          _pinPutController.text = '';
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
                        'Welcome ${_accountData.accountDetails.name ?? 'User'}  \n',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline1.copyWith(
                              fontSize: displayWidth(context) * 0.05,
                            ),
                      ),
                      Text(
                        'Enter your account PIN',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline1.copyWith(
                              fontSize: displayWidth(context) * 0.05,
                            ),
                      ),
                      sizedBoxHeight(context, 0.01),
                      Text(
                        '(${FormatUtils.formatPhoneNumber(
                          _accountData.accountDetails.phoneNumber,
                        )})',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              letterSpacing: 4,
                              fontSize: displayWidth(context) * 0.05,
                            ),
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
                      sizedBoxHeight(context, 0.05),
                      BasePinInput(
                        autoFocus: true,
                        length: 4,
                        obscureText: true,
                        pinPutFocusNode: _pinPutFocusNode,
                        pinPutController: _pinPutController,
                        submit: (_) {
                          submit();
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
                      sizedBoxHeight(context, 0.03),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot your PIN?'.toUpperCase(),
                          style: Theme.of(context).textTheme.headline1.copyWith(
                                decoration: TextDecoration.underline,
                                fontSize: displayWidth(context) * 0.04,
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
