import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pa_quick_banking/data/controller/account_controller.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../data/model/model.dart';
import '../../shared/shared.dart';
import '../widgets/widgets.dart';

class OTPVerification extends StatefulWidget {
  static const String routeName = '/otp_verification';

  @override
  _OTPVerificationState createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _otpVerificationController =
      TextEditingController();
  final AccountController _accountController = AccountController();

  final String _code = '';
  String signature = '{{ app signature }}';

  FocusNode _otpVerificationFocusNode;

  @override
  void initState() {
    // TODO: implement initState
    _otpVerificationFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    SmsAutoFill().unregisterListener();
    _otpVerificationFocusNode = FocusNode();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AccountData _accountData =
        ModalRoute.of(context).settings.arguments as AccountData;
    debugPrintSynchronously(_accountData.toJson());

    Future<dynamic> submit() async {
      if (_formKey.currentState.validate()) {
        _accountData.accountDetails.otp = _otpVerificationController.text;
        _accountController.validateOTP(
          accountData: _accountData,
        );
        setState(() {
          _otpVerificationController.text = '';
        });
      }
    }

    return BaseBody(
      appBar: baseAppBar(
        context: context,
        title: 'OTP Verification',
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
                        'Verification Code Sent To',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline1.copyWith(
                              fontSize: displayWidth(context) * 0.06,
                            ),
                      ),
                      sizedBoxHeight(context, 0.02),
                      Text(
                        '(${_accountData.accountDetails.phoneNumber})',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              letterSpacing: 4,
                              fontSize: displayWidth(context) * 0.06,
                            ),
                      ),
                      sizedBoxHeight(context, 0.04),
                      Text(
                        'A verification SMS has been '
                        'sent to your mobile number.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline1.copyWith(
                              fontSize: displayWidth(context) * 0.04,
                            ),
                      ),
                      sizedBoxHeight(context, 0.04),
                      PinFieldAutoFill(
                        codeLength: 5,
                        decoration: UnderlineDecoration(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          colorBuilder: FixedColorBuilder(
                            Colors.black.withOpacity(0.3),
                          ),
                        ),
                        currentCode: _code,
                        onCodeSubmitted: (String code) {},
                        onCodeChanged: (String code) {
                          if (code.length == 5) {
                            FocusScope.of(context).requestFocus(FocusNode());
                          }
                        },
                      ),
                      BasePinInput(
                        autoFocus: true,
                        length: 5,
                        obscureText: false,
                        pinPutFocusNode: _otpVerificationFocusNode,
                        pinPutController: _otpVerificationController,
                        submit: (_) {
                          submit();
                          return null;
                        },
                        validator: (String value) {
                          const String pattern = r'(^(\d{5})?$)';
                          final RegExp regExp = RegExp(pattern);
                          if (value.isEmpty) {
                            return 'Please enter your OTP Code.';
                          } else if (!regExp.hasMatch(value)) {
                            return 'Please enter a valid 5-digit OTP Code.';
                          }
                          return null;
                        },
                      ),
                      sizedBoxHeight(context, 0.04),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Resend code'.toUpperCase(),
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
