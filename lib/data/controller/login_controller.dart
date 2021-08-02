import 'package:get/get.dart';

import '../helpers/helpers.dart';
import 'controller.dart';

class LoginController extends GetxController with BaseController {
  static const String _checkAccForLinkAPI =
      '/api/Mobile/checkAccountForLinking';
  RxBool isLoading = false.obs;

  final DatabaseHelper _databaseHelper = DatabaseHelper();

  // Future<void> loginAccount(Account account) async {
  //   DialogHelper.showLoading('Fetching data...');
  //
  //   if (account.successful) {
  //     _accountInDB = AccountInDB(
  //       token: account.accountData.token,
  //       tokenExpiry: account.accountData.tokenExpiry,
  //       name: account.accountData.accountDetails.name,
  //       accountType: account.accountData.accountDetails.accountType,
  //       kycLevel: account.accountData.accountDetails.kycLevel,
  //       phoneNumber: account.accountData.accountDetails.phoneNumber,
  //       accountNumber: account.accountData.accountDetails.accountNumber,
  //     );
  //     await _databaseHelper.insertAccountInDB(_accountInDB);
  //     //TODO: Receive OTP and validate
  //     Get.put<AccountInDB>(_accountInDB, permanent: true);
  //     DialogHelper.hideLoading();
  //     DialogHelper.showSuccessSnackBar('Account Details Confirmed.'
  //         '\n Please wait for your OTP for verification');
  //   }
  //   isLoading(false);
  // }
}
