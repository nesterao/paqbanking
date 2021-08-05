import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pa_quick_banking/data/model/form_content.dart';

import '../../ui/screens/exported_screens.dart';
import '../../ui/widgets/exported_widgets.dart';
import '../constants/exported_constants.dart';
import '../model/exported_models.dart';
import '../services/request_manager.dart';

class AccountController extends GetxController {
  bool isLoading = false.obs();
  AccountDto accountDto = AccountDto(phoneNumber: '').obs();
  SecurityDto securityDto = SecurityDto().obs();
  List<Question> questions = <Question>[].obs();
  FormContent formContent = FormContent().obs();
  int source = 0.obs();
  int _retry = 0;

  void _endLoading() {
    isLoading = false;
    DialogHelper.hideLoading();
  }

  void _startLoading() {
    isLoading = true;
    DialogHelper.showLoading();
  }

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    _startLoading();
    Map<String, dynamic> _responseData;
    try {
      final Response<dynamic> response = await RequestManager().postRequest(
        APIs.verifyPhoneNumberUrl,
        postQuery: <String, dynamic>{'phoneNumber': phoneNumber},
      );

      _responseData = jsonDecode(response.bodyString) as Map<String, dynamic>;
      final bool isSuccessful = _responseData['successful'] as bool;
      if (isSuccessful) {
        final Map<String, dynamic> data =
            _responseData['data'] as Map<String, dynamic>;
        accountDto.phoneNumber = phoneNumber;
        accountDto.token = data['token'] as String;
        accountDto.tokenExpiry = DateTime.parse(data['tokenExpiry'] as String);
        accountDto.termsAndConditions = data['termsAndConditions'] as String;
        await fetchFormContent();
        source = 1;
        _endLoading();
        Get.toNamed(OTPVerification.routeName);
      } else {
        _endLoading();
        DialogHelper.showErrorDialog(
            title: Constants.errorTitle,
            description: _responseData['msg'] as String);
      }
    } catch (e) {
      _endLoading();
      DialogHelper.showErrorDialog(
        title: Constants.errorTitle,
      );
    }
  }

  Future<void> validateOTP(String otp) async {
    _startLoading();
    if (source == 1) {
      Map<String, dynamic> _responseData;
      try {
        final Response<dynamic> response = await RequestManager().postRequest(
          APIs.validateOtpForNewRegistrationUrl,
          postHeader: <String, String>{'opToken': accountDto.token},
          postQuery: <String, dynamic>{'otp': otp},
        );

        _responseData = jsonDecode(response.bodyString) as Map<String, dynamic>;
        final bool isSuccessful = _responseData['successful'] as bool;
        if (isSuccessful) {
          final Map<String, dynamic> data =
              _responseData['data'] as Map<String, dynamic>;
          accountDto.token = data['token'] as String;
          accountDto.tokenExpiry =
              DateTime.parse(data['tokenExpiry'] as String);
          source = 1;
          debugPrintSynchronously(source.toString());
          _endLoading();
          Get.toNamed(CreateAccountScreen.routeName);
        } else {
          _endLoading();
          DialogHelper.showErrorDialog(
              title: Constants.errorTitle,
              description: _responseData['msg'] as String);
        }
      } catch (e) {
        _endLoading();
        DialogHelper.showErrorDialog(
          title: Constants.errorTitle,
        );
      }
    }
  }

  Future<void> fetchFormContent() async {
    _startLoading();
    Map<String, dynamic> _resultsQuestions;
    Map<String, dynamic> _resultsIdTypes;
    Map<String, dynamic> _resultsTitles;

    //
    try {
      final Response<dynamic> _responseQuestions =
          await RequestManager().getRequest(
        APIs.questionsUrl,
        getHeader: <String, String>{'opToken': accountDto.token},
      );
      _resultsQuestions =
          jsonDecode(_responseQuestions.bodyString) as Map<String, dynamic>;

      final Response<dynamic> _responseIdTypes =
          await RequestManager().getRequest(
        APIs.idTypesUrl,
        getHeader: <String, String>{'opToken': accountDto.token},
      );
      _resultsIdTypes =
          jsonDecode(_responseIdTypes.bodyString) as Map<String, dynamic>;

      final Response<dynamic> _responseTitles =
          await RequestManager().getRequest(
        APIs.titlesUrl,
        getHeader: <String, String>{'opToken': accountDto.token},
      );
      _resultsTitles =
          jsonDecode(_responseTitles.bodyString) as Map<String, dynamic>;

      final bool isQuestionsSuccessful =
          _resultsQuestions['successful'] as bool;
      final bool isIdTypesSuccessful = _resultsIdTypes['successful'] as bool;
      final bool isTitlesSuccessful = _resultsTitles['successful'] as bool;

      if (isQuestionsSuccessful && isIdTypesSuccessful && isTitlesSuccessful) {
        final List<Question> questions =
            (_resultsQuestions['data'] as List<dynamic>)
                .map((dynamic e) => Question.fromMap(e as Map<String, dynamic>))
                .toList();
        formContent.questions = questions;

        final List<IdType> idTypes = (_resultsIdTypes['data'] as List<dynamic>)
            .map((dynamic e) => IdType.fromMap(e as Map<String, dynamic>))
            .toList();
        formContent.idTypes = idTypes;

        final List<String> titles = (_resultsTitles['data'] as List<dynamic>)
            .map((dynamic e) => e as String)
            .toList();
        formContent.titles = titles;
      } else {
        _endLoading();
        if (_retry < 2) {
          _retry++;
          await fetchFormContent();
        } else {
          DialogHelper.showErrorDialog(
            title: 'else',
          );
        }
      }
    } catch (e) {
      _endLoading();
      DialogHelper.showErrorDialog(
        title: Constants.errorTitle,
      );
      debugPrintSynchronously(e.toString());
    }
  }
}
