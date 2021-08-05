// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
//
// // import 'package:sms_autofill/sms_autofill.dart';
//
// import '../../data/controller/exported_controllers.dart';
// import '../../data/model/exported_models.dart';
// import '../../shared/exported_shared.dart';
// import '../widgets/exported_widgets.dart';
//
// class StepperBody extends StatefulWidget {
//   const StepperBody({Key key}) : super(key: key);
//
//   @override
//   _StepperBodyState createState() => _StepperBodyState();
// }
//
// class _StepperBodyState extends State<StepperBody> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   List<GlobalKey<FormState>> formKeys = <GlobalKey<FormState>>[
//     GlobalKey<FormState>(),
//     GlobalKey<FormState>(),
//   ];
//
//   int _currentStep = 0;
//   FocusNode focusNode;
//
//   // final DatabaseHelper _databaseHelper = DatabaseHelper();
//   final CheckAccLinkController _checkAccLinkController =
//       CheckAccLinkController();
//
//   final TextEditingController _phoneNumberTextFieldController =
//       TextEditingController();
//   final TextEditingController _accountNumberTextFieldController =
//       TextEditingController();
//   final TextEditingController _pinTextFieldController = TextEditingController();
//
//   final LinkedAccount currentLinkedAccount = Get.find<LinkedAccount>();
//
//   FocusNode phoneNumberFocusNode;
//   FocusNode accountNumberFocusNode;
//   FocusNode pinFocusNode;
//   FocusNode otpFocusNode;
//   String otp;
//   String _code;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     // _listenOTP();
//     phoneNumberFocusNode = FocusNode();
//     accountNumberFocusNode = FocusNode();
//     pinFocusNode = FocusNode();
//     otpFocusNode = FocusNode();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     phoneNumberFocusNode = FocusNode();
//     accountNumberFocusNode = FocusNode();
//     pinFocusNode = FocusNode();
//     otpFocusNode = FocusNode();
//     // SmsAutoFill().unregisterListener();
//     super.dispose();
//   }
//
//   // Future<void> _listenOTP() async {
//   //   await SmsAutoFill().listenForCode;
//   // }
//   //
//   // Future<String> getSignature() async {
//   //   final String signCode = await SmsAutoFill().getAppSignature;
//   //   debugPrintSynchronously(signCode);
//   //   return signCode;
//   // }
//
//   void _fieldFocusChange(
//     BuildContext context,
//     FocusNode currentFocus,
//     FocusNode nextFocus,
//   ) {
//     currentFocus.unfocus();
//     FocusScope.of(context).requestFocus(nextFocus);
//   }
//
//   void tapped(int step) {
//     setState(() => _currentStep = step);
//   }
//
//   void continueStep() {
//     _currentStep < 1
//         ? setState(
//             () {
//               if (formKeys[_currentStep].currentState.validate()) {
//                 final CheckLinkAccount _checkLinkAccount = CheckLinkAccount(
//                   phoneNumber: _phoneNumberTextFieldController.text.toString(),
//                   accountNumber:
//                       _accountNumberTextFieldController.text.toString(),
//                   pin: _pinTextFieldController.text.toString(),
//                 );
//                 _checkAccLinkController.fetchAccLink(_checkLinkAccount);
//                 // getSignature();
//                 _currentStep += 1;
//               } else {
//                 _currentStep = 0;
//               }
//             },
//           )
//         : setState(() {
//             if (otp.isNotEmpty) {
//               debugPrintSynchronously(otp);
//               debugPrintSynchronously(currentLinkedAccount.token);
//               _checkAccLinkController.validateOTPForLinking(
//                 currentLinkedAccount.token,
//                 otp,
//               );
//             }
//           });
//   }
//
//   void cancelStep() {
//     _currentStep > 0
//         ? setState(() => _currentStep -= 1)
//         : Navigator.pop(context);
//   }
//
//   Widget _stepTitle(String title) {
//     return Text(
//       title,
//       style: TextStyle(
//         fontSize: displayWidth(context) * 0.04,
//         color: Get.isDarkMode ? kAccentColor : kLightPrimaryColor,
//       ),
//     );
//   }
//
//   List<Step> steps() {
//     return <Step>[
//       Step(
//         title: _stepTitle('Account Details'),
//         isActive: _currentStep >= 0,
//         state: _currentStep > 0 ? StepState.complete : StepState.editing,
//         content: Form(
//           key: formKeys[0],
//           child: Column(
//             children: <Widget>[
//               BaseInputField(
//                 autoFocus: true,
//                 inputFocusNode: phoneNumberFocusNode,
//                 inputLabel: 'Phone Number',
//                 inputMaxLength: 10,
//                 inputController: _phoneNumberTextFieldController,
//                 inputType: TextInputType.number,
//                 inputLetterSpacing: displayWidth(context) * 0.01,
//                 textInputAction: TextInputAction.next,
//                 inputFormatter: <TextInputFormatter>[
//                   FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),
//                 ],
//                 inputValidator: (String value) {
//                   const String pattern = r'(^0[2,5]{1}[0-9]+$)';
//                   final RegExp regExp = RegExp(pattern);
//                   if (value.isEmpty) {
//                     return 'Please enter your mobile number';
//                   } else if (!regExp.hasMatch(value)) {
//                     return '''
// Please enter a valid 10-digit mobile number''';
//                   }
//                   debugPrint(value);
//                   return null;
//                 },
//                 inputOnFieldSubmitted: (String term) {
//                   _fieldFocusChange(
//                     context,
//                     phoneNumberFocusNode,
//                     accountNumberFocusNode,
//                   );
//                 },
//               ),
//               sizedBoxHeight(context, 0.02),
//               BaseInputField(
//                 inputFocusNode: accountNumberFocusNode,
//                 inputLabel: 'Account Number',
//                 inputType: TextInputType.number,
//                 inputMaxLength: 13,
//                 inputController: _accountNumberTextFieldController,
//                 inputLetterSpacing: displayWidth(context) * 0.01,
//                 textInputAction: TextInputAction.next,
//                 inputValidator: (String value) {
//                   const String pattern = r'(^(\d{13})?$)';
//                   final RegExp regExp = RegExp(pattern);
//                   if (value.isEmpty) {
//                     return 'Please enter your account number';
//                   } else if (!regExp.hasMatch(value)) {
//                     return 'Please enter a valid 13-digit account number';
//                   }
//                   debugPrint(value);
//                   return null;
//                 },
//                 inputOnFieldSubmitted: (String term) {
//                   _fieldFocusChange(
//                     context,
//                     accountNumberFocusNode,
//                     pinFocusNode,
//                   );
//                 },
//               ),
//               sizedBoxHeight(context, 0.02),
//               BaseInputField(
//                 inputFocusNode: pinFocusNode,
//                 inputLabel: 'User PIN',
//                 inputMaxLength: 4,
//                 inputLetterSpacing: displayWidth(context) * 0.12,
//                 inputType: TextInputType.number,
//                 obscureText: true,
//                 inputController: _pinTextFieldController,
//                 textInputAction: TextInputAction.next,
//                 inputValidator: (String value) {
//                   const String pattern = r'(^(\d{4})?$)';
//                   final RegExp regExp = RegExp(pattern);
//                   if (value.isEmpty) {
//                     return 'Please enter your PIN';
//                   } else if (!regExp.hasMatch(value)) {
//                     return 'Please enter a valid 4-digit PIN';
//                   }
//                   return null;
//                 },
//                 inputOnFieldSubmitted: (String term) {
//                   _fieldFocusChange(context, pinFocusNode, otpFocusNode);
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//       Step(
//         title: _stepTitle('Verification'),
//         isActive: _currentStep >= 0,
//         state: _currentStep >= 1 ? StepState.editing : StepState.disabled,
//         content: Form(
//           key: formKeys[1],
//           child: Column(
//             children: <Widget>[],
//           ),
//         ),
//       ),
//     ];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: Form(
//         key: _formKey,
//         child: ListView(
//           children: <Widget>[
//             Stepper(
//               controlsBuilder: (BuildContext context,
//                   {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
//                 return Padding(
//                   padding: const EdgeInsets.only(top: 32.0),
//                   child: Row(
//                     children: <Widget>[
//                       Expanded(
//                         child: PrimaryButton(
//                           onTap: onStepContinue,
//                           text: 'Next',
//                         ),
//                       ),
//                       sizedBoxWidth(context, 0.04),
//                       // SizedBox(width: 8,),
//                       Expanded(
//                         child: SecondaryButton(
//                           onTap: onStepCancel,
//                           text: 'Cancel',
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//               physics: const ScrollPhysics(),
//               currentStep: _currentStep,
//               onStepContinue: continueStep,
//               onStepCancel: cancelStep,
//               onStepTapped: (int step) => tapped(step),
//               steps: steps(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
