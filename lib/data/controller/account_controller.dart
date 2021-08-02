import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../ui/screens/screens.dart';
import '../../ui/widgets/widgets.dart';
import '../helpers/helpers.dart';
import '../model/model.dart';
import '../services/services.dart';
import 'controller.dart';

class AccountController extends GetxController with BaseController {
  // APIs _apIs = APIs();

  static const String _verifyPhoneNumberAPI = '/api/Mobile/verifyPhoneNumber';
  static const String _checkAccForLinkAPI =
      '/api/Mobile/checkAccountForLinking';
  static const String _validatePinForLinkingAPI =
      '/api/Mobile/validatePinForLinking';
  static const String _validateOtpForLinkingAPI =
      '/api/Mobile/validateOtpForLinking';

  RxBool isLoading = false.obs;

  Account _account = Account().obs();
  AccountInDB accountInDB = AccountInDB().obs();
  ValidationResponseModel _validationResponse = ValidationResponseModel();
  List<AccountInDB> accountInDBList = <AccountInDB>[AccountInDB()].obs;

  final DatabaseHelper _databaseHelper = DatabaseHelper();

  // Future<void> submit

  Future<void> verifyPhoneNumber({String phoneNumber}) async {
    isLoading(true);
    DialogHelper.showLoading();
    Response<dynamic> _res;
    try {
      _res = await BaseClient().verifyPhoneNumber(
        _verifyPhoneNumberAPI,
        phoneNumber,
      );
      _validationResponse = ValidationResponseModel.fromJson(_res.bodyString);
      DialogHelper.hideLoading();
      if (_validationResponse.successful) {
        _account.accountData.accountDetails.phoneNumber = phoneNumber;
        _account.accountData.accountDetails.tNcs =
            _validationResponse.responseData.tNcs;
        _account.accountData.requestMsg = 'verifyPhoneNumber';
        Get.toNamed(
          OTPVerification.routeName,
          arguments: _account.accountData,
        );
        await SmsAutoFill().listenForCode;
        DialogHelper.showSuccessSnackBar('Phone Number confirmed.'
            '\n Please wait for your OTP for verification');
      } else {
        //TODO: Handle _account .
        DialogHelper.showErrorDialog(
          description: '(Create Account Error Message.'
              '\n ${_account.msg})',
        );
      }
    } catch (handleError) {
      DialogHelper.hideLoading();
      if (handleError is AppException) {
        DialogHelper.showErrorDialog(
          description: handleError.message,
        );
      } else {
        DialogHelper.showErrorDialog();
      }
    }
    if (_res == null) return;
    // }
    isLoading(false);
  }

  Future<void> validateOTP({AccountData accountData}) async {
    _account.accountData = accountData;
    switch (_account.accountData.requestMsg) {
      case 'verifyPhoneNumber':
        Get.toNamed(
          SecurityScreen.routeName,
          arguments: _account.accountData,
        );
        return;
        break;
      default:
        return;
    }

    // if(_account.accountData.requestMsg == 'verifyPhoneNumber'
    // ) {
    //   Get.toNamed(PinInput.routeName, arguments: _account.accountData);
    // } else if (_account.accountData.isQuickAccount &&
    //     !_account.accountData.accountDetails.otp.isBlank &&
    //     !_account.accountData.accountDetails.pin.isBlank) {
    //   _account.accountData = accountData;
    //   Get.toNamed(SecurityScreen.routeName, arguments: _account.accountData);
    // } else if()
  }

  Future<void> validatePIN({AccountData accountData}) async {
    _account.accountData = accountData;
    switch (_account.accountData.requestMsg) {
      case 'verifyPhoneNumber':
        Get.toNamed(SecurityScreen.routeName, arguments: _account.accountData);
        return;
        break;
      default:
        return;
    }

    // if(_account.accountData.requestMsg == 'verifyPhoneNumber'
    // ) {
    //   Get.toNamed(PinInput.routeName, arguments: _account.accountData);
    // } else if (_account.accountData.isQuickAccount &&
    //     !_account.accountData.accountDetails.otp.isBlank &&
    //     !_account.accountData.accountDetails.pin.isBlank) {
    //   _account.accountData = accountData;
    //   Get.toNamed(SecurityScreen.routeName, arguments: _account.accountData);
    // } else if()
  }

  Future<void> checkLinkAccount({
    String phoneNumber,
    String accountNumber,
  }) async {
    isLoading(true);
    DialogHelper.showLoading();

    final bool accountExist = await _databaseHelper.isAccountInDB(
      phoneNumber,
    );

    if (accountExist) {
      isLoading(false);
      DialogHelper.hideLoading();
      DialogHelper.showErrorSnackBar('Your Quick account is already linked. \n'
          'Please login.');
      Future.delayed(const Duration(seconds: 3), () {
        if (Get.isDialogOpen) Get.back();
        Get.toNamed(LoginScreen.routeName);
      });
    } else {
      final CheckLinkAccountModel checkLinkAccount = CheckLinkAccountModel(
        phoneNumber: phoneNumber,
        accountNumber: accountNumber,
      );
      Response<dynamic> _res;
      try {
        _res = await BaseClient().checkAccForLinking(
          _checkAccForLinkAPI,
          checkLinkAccount.toMap(),
        );
        _account = Account.fromJson(_res.bodyString);
        DialogHelper.hideLoading();
        if (_account.successful) {
          Get.toNamed(
            OTPVerification.routeName,
            arguments: _account.accountData,
          );
          await SmsAutoFill().listenForCode;
          DialogHelper.showSuccessSnackBar('Account Details Confirmed.'
              '\n Please wait for your OTP for verification');
        } else {
          //TODO: Handle _account .
          DialogHelper.showErrorDialog(
            description: '(Account Error Message.'
                '\n ${_account.msg})',
          );
        }
      } catch (handleError) {
        DialogHelper.hideLoading();
        if (handleError is AppException) {
          DialogHelper.showErrorDialog(
            description: handleError.message,
          );
        } else {
          DialogHelper.showErrorDialog();
        }
      }
      if (_res == null) return;
      // }
      isLoading(false);
    }

    Future<void> validatePinForLink({AccountData accountData}) async {
      isLoading(true);
      DialogHelper.showLoading();

      Response<dynamic> _res;
      final ValidatePinModel _validatePin = ValidatePinModel(
          pin: accountData.accountDetails.pin,
          otp: accountData.accountDetails.otp);
      try {
        // _res = await BaseClient().validatePinForLinking(
        //   _validatePinForLinking,
        //   accountData.token,
        //   _validatePin.toMap(),
        // );
        DialogHelper.hideLoading();
        if (_account.successful) {
          Get.toNamed(
            OTPVerification.routeName,
            arguments: _account.accountData,
          );
          await SmsAutoFill().listenForCode;
          DialogHelper.showSuccessSnackBar('Account Details Confirmed.'
              '\n Please wait for your OTP for verification');
        } else {
          //TODO: Handle _account .
          DialogHelper.showErrorDialog(
            description: '(Account Error Message.'
                '\n ${_account.msg})',
          );
        }
      } catch (handleError) {
        DialogHelper.hideLoading();
        if (handleError is AppException) {
          DialogHelper.showErrorDialog(
            description: handleError.message,
          );
        } else {
          DialogHelper.showErrorDialog();
        }
      }
      if (_res == null) return;

      Get.toNamed(
        PinInput.routeName,
        arguments: accountData,
      );
      DialogHelper.showSuccessSnackBar('Quick Account Details Confirmed.'
          '\n Please enter your PIN for verification');
    }

    // Future<void> validateOtpForLink({AccountData accountData}) async {
    //   isLoading(true);
    //   DialogHelper.showLoading();
    //
    //
    //
    //   if (_account.accountData.isQuickAccount &&
    //       accountData.accountDetails.pin?.isEmpty == true) {
    //
    //   } else if(_account.accountData.isQuickAccount &&
    //       accountData.accountDetails.pin?.isNotEmpty == true) {
    //     Get.toNamed(
    //       OTPVerification.routeName,
    //       arguments: _account.accountData,
    //     );
    //     DialogHelper.showSuccessSnackBar('Account Details Confirmed.'
    //         '\n Please wait for your OTP for verification');
    //   }else if(!_account.accountData.isQuickAccount) {
    //     Get.toNamed(
    //       OTPVerification.routeName,
    //       arguments: _account.accountData,
    //     );
    //     DialogHelper.showSuccessSnackBar('Account Details Confirmed.'
    //         '\n Please wait for your OTP for verification');
    //   }
    //
    //   if () {
    //     final ValidatePinModel validatePin = ValidatePinModel(
    //       otp: otp,
    //       pin: accountData.accountDetails.pin,
    //     );
    //     _res = await BaseClient().validatePinForLinking(
    //       _validatePinForLinking,
    //       accountData.token,
    //       accountData.accountDetails.pin,
    //     );
    //     _valRes = ValidationResponseModel.fromJson(_res.bodyString);
    //     if (_valRes.successful) {
    //       accountData.token = _valRes.responseData.token;
    //       accountData.tokenExpiry = _valRes.responseData.tokenExpiry;
    //       Get.offAll(
    //         OTPVerification.routeName,
    //         arguments: _account,
    //       );
    //       await SmsAutoFill().listenForCode;
    //     } else {
    //       DialogHelper.showErrorDialog(
    //         description: '(Account Error Message.'
    //             '\n ${_account.msg})',
    //       );
    //     }
    //   } else {
    //     _res = await BaseClient().validateOtpForLinking(
    //       _validateOtpForLinking,
    //       accountData.token,
    //       validatePin.toMap(),
    //       accountData.accountDetails.otp,
    //     );
    //   }
    //   debugPrintSynchronously(_res.bodyString);
    //
    //   if (_valRes.successful) {
    //     accountData.token = _valRes.responseData.token;
    //     accountData.tokenExpiry = _valRes.responseData.tokenExpiry;
    //     debugPrintSynchronously(_account.toJson());
    //     Get.offAll(
    //       MainScreen.routeName,
    //       // arguments: _account,
    //     );
    //   } else {
    //     DialogHelper.showErrorDialog(
    //       description: '(Account Error Message.'
    //           '\n ${_account.msg})',
    //     );
    //   }
    //
    //   // account = Account.fromJson(_res.bodyString);
    //
    //   if (_res == null) return;
    //   isLoading(false);
    // }

    // Future<void> addAccountToDB(Account account) async {
    //   DialogHelper.showLoading();
    //   if (account.successful) {
    //     accountInDB = AccountInDB(
    //       token: account.accountData.token,
    //       tokenExpiry: account.accountData.tokenExpiry,
    //       name: account.accountData.accountDetails.name,
    //       accountType: account.accountData.accountDetails.accountType,
    //       kycLevel: account.accountData.accountDetails.kycLevel,
    //       phoneNumber: account.accountData.accountDetails.phoneNumber,
    //       accountNumber: account.accountData.accountDetails.accountNumber,
    //     );
    //     // await _databaseHelper.insertAccountInDB(accountInDB);
    //     //TODO: Receive OTP and validate
    //     DialogHelper.hideLoading();
    //     if (account.accountData.isQuickAccount) {
    //       Get.toNamed(PinInput.routeName);
    //     } else {
    //       Get.toNamed(OTPVerification.routeName);
    //     }
    //     DialogHelper.showSuccessSnackBar('Account Details Confirmed.'
    //         '\n Please wait for your OTP for verification');
    //   }
    //   isLoading(false);
    // }

    Future<void> getAccountInDB() async {
      await _databaseHelper
          .getAccountInDB()
          .then((List<Map<String, dynamic>> accounts) {
        for (final Map<String, dynamic> account in accounts) {
          accountInDBList.add(AccountInDB.fromMap(account));
        }
      });
    }
  }
}
