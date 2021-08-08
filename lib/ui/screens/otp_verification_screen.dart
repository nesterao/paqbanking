import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../data/controller/exported_controllers.dart';
import '../../shared/exported_shared.dart';
import '../widgets/exported_widgets.dart';

class OTPVerification extends StatefulWidget {
  static const String routeName = '/otp_verification';

  @override
  _OTPVerificationState createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _otpVerificationController =
      TextEditingController();

  final AccountController _accountController = Get.find();

  final String _code = '';
  String signature = '{{ app signature }}';

  FocusNode _otpVerificationFocusNode;

  @override
  void initState() {
    // TODO: implement initState
    // listenForCode();
    _otpVerificationFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // SmsAutoFill().unregisterListener();
    _otpVerificationFocusNode = FocusNode();
    super.dispose();
  }

  // void listenForCode() async {
  //   await SmsAutoFill().listenForCode;
  // }

  @override
  Widget build(BuildContext context) {
    Future<dynamic> submit() async {
      if (_formKey.currentState.validate()) {
        _accountController.accountDto.otp = _otpVerificationController.text;
        _accountController.validateOTP();
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
                        '(${_accountController.accountDto.accountDetails.phoneNumber})',
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
                      Visibility(
                        visible: false,
                        child: PinFieldAutoFill(
                          codeLength: 5,
                          controller: _otpVerificationController,
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
                          onCodeChanged: (String code) {
                            if (code.length == 5) {
                              debugPrintSynchronously(_code.toString());
                              FocusScope.of(context).requestFocus(FocusNode());
                              submit();
                            }
                          },
                        ),
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
                        onPressed: () {
                          _accountController.verifyPhoneNumber();
                        },
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
