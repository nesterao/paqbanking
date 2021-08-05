class APIs {
  static const String verifyPhoneNumberUrl =
      '$_baseURL/api/Mobile/verifyPhoneNumber';
  static const String validateOtpForNewRegistrationUrl =
      '$_baseURL/api/Mobile/validateOtpForNewRegistration';
  static const String createNewAccountUrl =
      '$_baseURL/api/Mobile/createNewAccount';
  static const String loginUrl = '$_baseURL/api/Mobile/login';
  static const String validateOtpForLoginUrl =
      '$_baseURL/api/Mobile/validateOtpForLogin';
  static const String checkAccForLinkUrl =
      '$_baseURL/api/Mobile/checkAccountForLinking';
  static const String validatePinForLinkingUrl =
      '$_baseURL/api/Mobile/validatePinForLinking';
  static const String validateOtpForLinkingUrl =
      '$_baseURL/api/Mobile/validateOtpForLinking';
  static const String linkQuickAccountUrl =
      '$_baseURL/api/Mobile/linkQuickAccount';
  static const String linkAccountUrl = '$_baseURL/api/Mobile/linkAccount';

  //GETTERS
  static const String questionsUrl = '$_baseURL/api/Mobile/questions';
  static const String dataFromIdUrl = '$_baseURL/api/Mobile/dataFromId';
  static const String idTypesUrl = '$_baseURL/api/Mobile/idTypes';
  static const String titlesUrl = '$_baseURL/api/Mobile/titles';
  static const String transactionsUrl = '$_baseURL/api/Mobile/transactions';
  static const String balanceUrl = '$_baseURL/api/Mobile/balance';
  static const String accountInfoUrl = '$_baseURL/api/Mobile/accountInfo';
}

const String _baseURL = 'https://qa-quickmobileapi.azurewebsites.net';
