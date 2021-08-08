import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../ui/screens/exported_screens.dart';
import '../../ui/widgets/exported_widgets.dart';
import '../constants/exported_constants.dart';
import '../helpers/db_helper.dart';
import '../model/exported_models.dart';
import '../services/request_manager.dart';

class AccountController extends GetxController {
  bool isLoading = false.obs();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  AccountDto accountDto =
      AccountDto(accountDetails: AccountDetails(phoneNumber: '')).obs();
  UserAccount userAccount = UserAccount(phoneNumber: '').obs();
  SecurityDto securityDto = SecurityDto().obs();
  List<UserAccount> accountInDBList = <UserAccount>[].obs();
  List<Question> questions = <Question>[].obs();
  List<String> accountType =
      <String>['Quick Save Account', 'Quick TriSave Account'].obs();
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

  Future<void> getAccountInDB() async {
    _startLoading();
    accountInDBList = await _databaseHelper.getUserAccountInDBList();
    _endLoading();
  }

  Future<void> checkAccountLink() async {
    _startLoading();
    Map<String, dynamic> _responseData;
    try {
      final Response<dynamic> response = await RequestManager().postRequest(
        APIs.checkAccForLinkUrl,
        postData: <String, dynamic>{
          'phoneNumber': accountDto.accountDetails.phoneNumber,
          'accountNumber': accountDto.accountDetails.accountNumber,
        },
      );

      _responseData = jsonDecode(response.bodyString) as Map<String, dynamic>;
      final bool isSuccessful = _responseData['successful'] as bool;
      if (isSuccessful) {
        final Map<String, dynamic> data =
            _responseData['data'] as Map<String, dynamic>;

        accountDto.token = data['token'] as String;
        accountDto.tokenExpiry = DateTime.parse(data['tokenExpiry'] as String);
        accountDto.isQuickAccount = data['isQuickAccount'] as bool;

        final Map<String, dynamic> accountDetails =
            data['accountDetails'] as Map<String, dynamic>;

        accountDto.accountDetails.name = accountDetails['name'] as String;
        accountDto.accountDetails.phoneNumber =
            accountDetails['phoneNumber'] as String;
        accountDto.accountDetails.accountNumber =
            accountDetails['accountNumber'] as String;
        accountDto.accountDetails.kycLevel =
            accountDetails['kycLevel'] as String;
        accountDto.accountDetails.accountType =
            accountDetails['accountType'] as String;

        source = 2;
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
      debugPrintSynchronously(e.toString());
    }
  }

  Future<void> createNewAccount() async {
    _startLoading();
    Map<String, dynamic> _responseData;
    try {
      final Response<dynamic> response = await RequestManager().postRequest(
        APIs.createNewAccountUrl,
        postData: securityDto.toMap(),
      );

      _responseData = jsonDecode(response.bodyString) as Map<String, dynamic>;
      final bool isSuccessful = _responseData['successful'] as bool;
      if (isSuccessful) {
        final Map<String, dynamic> data =
            _responseData['data'] as Map<String, dynamic>;

        userAccount.token = data['token'] as String;
        userAccount.tokenExpiry = DateTime.parse(data['tokenExpiry'] as String);
        userAccount.accountNumber = data['accountNumber'] as String;
        userAccount.kycLevel = data['kycLevel'] as String;
        userAccount.firstName = securityDto.firstName;
        userAccount.surname = securityDto.surname;
        userAccount.phoneNumber = accountDto.accountDetails.phoneNumber;
        userAccount.accountType = securityDto.accountType;
        userAccount.availableBalance = 0;
        userAccount.actualBalance = 0;
        userAccount.isQuickAccount = true;
        await _databaseHelper.insertAccountInDB(userAccount);

        final Response<dynamic> infoResponse =
            await RequestManager().getRequest(
          APIs.accountInfoUrl,
          getHeader: <String, String>{'opToken': userAccount.token},
        );

        final Map<String, dynamic> _infoResponseData =
            jsonDecode(infoResponse.bodyString) as Map<String, dynamic>;

        final Map<String, dynamic> _infoData =
            _infoResponseData['data'] as Map<String, dynamic>;

        userAccount.phoneNumber = _infoData['phoneNumber'] as String;
        userAccount.availableBalance = _infoData['availableBalance'] as double;
        userAccount.actualBalance = _infoData['actualBalance'] as double;
        userAccount.accountNumber = _infoData['accountNumber'] as String;
        userAccount.kycLevel = _infoData['kycLevel'] as String;
        userAccount.transactions = (_infoData['transactions'] as List<dynamic>)
            .map((dynamic e) => Transaction.fromMap(e as Map<String, dynamic>))
            .toList();

        await _databaseHelper.updateAccountInDB(userAccount);
        accountDto =
            AccountDto(accountDetails: AccountDetails(phoneNumber: ''));
        securityDto = SecurityDto();
        _endLoading();
        Get.toNamed(MainScreen.routeName);
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
      debugPrintSynchronously(e.toString());
    }
  }

  Future<void> verifyPhoneNumber() async {
    _startLoading();
    Map<String, dynamic> _responseData;
    try {
      final Response<dynamic> response = await RequestManager().postRequest(
        APIs.verifyPhoneNumberUrl,
        postQuery: <String, dynamic>{
          'phoneNumber': accountDto.accountDetails.phoneNumber,
        },
      );

      _responseData = jsonDecode(response.bodyString) as Map<String, dynamic>;
      final bool isSuccessful = _responseData['successful'] as bool;
      if (isSuccessful) {
        final Map<String, dynamic> data =
            _responseData['data'] as Map<String, dynamic>;
        accountDto.token = data['token'] as String;
        accountDto.tokenExpiry = DateTime.parse(data['tokenExpiry'] as String);
        accountDto.termsAndConditions = data['termsAndConditions'] as String;
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

  void validateOTP() {
    if (source == 1) {
      validateOTPNewAccount();
    } else if (accountDto.isQuickAccount) {
      Get.toNamed(PinInput.routeName);
    } else if (source == 2 && !accountDto.isQuickAccount) {
      _validateOtpForLinking();
    } else {
      _validateOtpForLogin();
    }
  }

  void validatePIN() {
    if (source == 1) {
      createNewAccount();
    } else if (source == 2 && accountDto.isQuickAccount) {
      _validatePinForLinking();
    } else if (source == 2 && !accountDto.isQuickAccount) {
      linkAccount();
    }
  }

  Future<void> linkAccount() async {
    _startLoading();
    Map<String, dynamic> _responseData;
    try {
      final Response<dynamic> response = await RequestManager().postRequest(
        accountDto.isQuickAccount
            ? APIs.linkQuickAccountUrl
            : APIs.linkAccountUrl,
        postHeader: <String, String>{'opToken': accountDto.token},
        postData: <String, String>{
          'motherMaidenName': securityDto.motherMaidenName,
          'question1': securityDto.question1,
          'answer1': securityDto.answer1,
          'question2': securityDto.question2,
          'answer2': securityDto.answer2,
          'pin': accountDto.isQuickAccount ? securityDto.pin : '',
        },
      );

      _responseData = jsonDecode(response.bodyString) as Map<String, dynamic>;
      final bool isSuccessful = _responseData['successful'] as bool;
      if (isSuccessful) {
        final Map<String, dynamic> data =
            _responseData['data'] as Map<String, dynamic>;
        userAccount.isQuickAccount = true;
        userAccount.token = data['token'] as String;
        userAccount.tokenExpiry = DateTime.parse(data['tokenExpiry'] as String);

        final Response<dynamic> infoResponse =
            await RequestManager().getRequest(
          APIs.accountInfoUrl,
          getHeader: <String, String>{'opToken': userAccount.token},
        );

        final Map<String, dynamic> _infoResponseData =
            jsonDecode(infoResponse.bodyString) as Map<String, dynamic>;

        final Map<String, dynamic> _infoData =
            _infoResponseData['data'] as Map<String, dynamic>;

        userAccount.phoneNumber = _infoData['phoneNumber'] as String;
        userAccount.availableBalance = _infoData['availableBalance'] as double;
        userAccount.actualBalance = _infoData['actualBalance'] as double;
        userAccount.accountNumber = _infoData['accountNumber'] as String;
        userAccount.kycLevel = _infoData['kycLevel'] as String;
        final Map<String, dynamic> _user =
            _infoData['user'] as Map<String, dynamic>;
        userAccount.firstName = _user['firstName'] as String;
        userAccount.surname = _user['surname'] as String;
        userAccount.transactions = (_infoData['transactions'] as List<dynamic>)
            .map((dynamic e) => Transaction.fromMap(e as Map<String, dynamic>))
            .toList();

        await _databaseHelper.insertAccountInDB(userAccount);

        accountDto =
            AccountDto(accountDetails: AccountDetails(phoneNumber: ''));
        securityDto = SecurityDto();

        _endLoading();

        Get.toNamed(MainScreen.routeName);
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

  Future<void> _validatePinForLinking() async {
    _startLoading();
    Map<String, dynamic> _responseData;
    try {
      final Response<dynamic> response = await RequestManager().postRequest(
        APIs.validatePinForLinkingUrl,
        postHeader: <String, String>{'opToken': accountDto.token},
        postData: <String, String>{
          'otp': accountDto.otp,
          'pin': securityDto.pin,
        },
      );

      _responseData = jsonDecode(response.bodyString) as Map<String, dynamic>;
      final bool isSuccessful = _responseData['successful'] as bool;
      if (isSuccessful) {
        final Map<String, dynamic> data =
            _responseData['data'] as Map<String, dynamic>;
        accountDto.token = data['token'] as String;
        accountDto.tokenExpiry = DateTime.parse(data['tokenExpiry'] as String);
        await fetchFormContent();
        _endLoading();
        Get.toNamed(SecurityScreen.routeName);
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

  Future<void> _validateOtpForLinking() async {
    _startLoading();
    Map<String, dynamic> _responseData;
    try {
      final Response<dynamic> response = await RequestManager().postRequest(
        APIs.validatePinForLinkingUrl,
        postHeader: <String, String>{'opToken': accountDto.token},
        postQuery: <String, String>{
          'otp': accountDto.otp,
        },
      );

      _responseData = jsonDecode(response.bodyString) as Map<String, dynamic>;
      final bool isSuccessful = _responseData['successful'] as bool;
      if (isSuccessful) {
        final Map<String, dynamic> data =
            _responseData['data'] as Map<String, dynamic>;
        accountDto.token = data['token'] as String;
        accountDto.tokenExpiry = DateTime.parse(data['tokenExpiry'] as String);
        await fetchFormContent();
        _endLoading();
        Get.toNamed(SecurityScreen.routeName);
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

  Future<void> _validateOtpForLogin() async {
    _startLoading();
    Map<String, dynamic> _responseData;
    try {
      final Response<dynamic> response = await RequestManager().postRequest(
        APIs.validateOtpForLoginUrl,
        postHeader: <String, String>{'opToken': accountDto.token},
        postQuery: <String, String>{
          'otp': accountDto.otp,
        },
      );

      _responseData = jsonDecode(response.bodyString) as Map<String, dynamic>;
      final bool isSuccessful = _responseData['successful'] as bool;
      if (isSuccessful) {
        final Map<String, dynamic> data =
            _responseData['data'] as Map<String, dynamic>;
        accountDto.token = data['token'] as String;
        accountDto.tokenExpiry = DateTime.parse(data['tokenExpiry'] as String);
        await fetchFormContent();
        _endLoading();
        Get.toNamed(SecurityScreen.routeName);
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

  Future<void> validateOTPNewAccount() async {
    _startLoading();
    Map<String, dynamic> _responseData;
    try {
      final Response<dynamic> response = await RequestManager().postRequest(
        APIs.validateOtpForNewRegistrationUrl,
        postHeader: <String, String>{'opToken': accountDto.token},
        postQuery: <String, dynamic>{'otp': accountDto.otp},
      );

      _responseData = jsonDecode(response.bodyString) as Map<String, dynamic>;
      final bool isSuccessful = _responseData['successful'] as bool;
      if (isSuccessful) {
        final Map<String, dynamic> data =
            _responseData['data'] as Map<String, dynamic>;
        accountDto.token = data['token'] as String;
        accountDto.tokenExpiry = DateTime.parse(data['tokenExpiry'] as String);
        await fetchFormContent();
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

  Future<void> fetchFormContent() async {
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
