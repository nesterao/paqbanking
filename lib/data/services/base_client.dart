import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pa_quick_banking/ui/widgets/dialog_helper.dart';

import '../services/services.dart';

class BaseClient extends GetConnect {
  static const String _baseURL = 'https://qa-quickmobileapi.azurewebsites.net';

  static const int TIME_OUT_DURATION = 20;

  Future<Response<dynamic>> verifyPhoneNumber(
    String api,
    String verifyPhoneNumber,
  ) async {
    final Uri uri = Uri.parse(_baseURL + api);
    final String url = _baseURL + api;
    try {
      final Response<dynamic> response = await post(
        url,
        query(verifyPhoneNumber),
      ).timeout(const Duration(seconds: TIME_OUT_DURATION));
      if (response.isOk) {
        debugPrintSynchronously(response.bodyString);
        return response;
      } else {
        DialogHelper.showErrorDialog(
          title: 'Error occurred ${response.statusCode}',
          description: response.statusText,
        );
        return null;
      }
      // return _processResponse(response) as Response;
    } on SocketException {
      throw FetchDataException(
        'No Internet Connection',
        uri.toString(),
      );
    } on TimeoutException {
      throw ApiNotRespondingException(
        'API not responding in time',
        uri.toString(),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<dynamic>> checkAccForLinking(
    String api,
    Map<String, String> checkAccLink,
  ) async {
    final Uri uri = Uri.parse(_baseURL + api);
    final String url = _baseURL + api;
    try {
      final Response<dynamic> response = await post(
        url,
        checkAccLink,
      ).timeout(const Duration(seconds: TIME_OUT_DURATION));
      if (response.isOk) {
        return response;
      } else {
        DialogHelper.showErrorDialog(
          title: 'Error occurred ${response.statusCode}',
          description: response.statusText,
        );
        return null;
      }
      // return _processResponse(response) as Response;
    } on SocketException {
      throw FetchDataException(
        'No Internet Connection',
        uri.toString(),
      );
    } on TimeoutException {
      throw ApiNotRespondingException(
        'API not responding in time',
        uri.toString(),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<dynamic>> validatePinForLinking(
    String api,
    String opToken,
    Map<String, String> validatePin,
  ) async {
    final Uri uri = Uri.parse(_baseURL + api);
    final String url = _baseURL + api;
    try {
      final Response<dynamic> response = await post(url, validatePin,
              headers: <String, String>{opToken: opToken})
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      if (response.isOk) {
        return response;
      } else {
        DialogHelper.showErrorDialog(
          title: 'Error occurred ${response.statusCode}',
          description: response.statusText,
        );
        return null;
      }
      // return _processResponse(response) as Response;
    } on SocketException {
      throw FetchDataException(
        'No Internet Connection',
        uri.toString(),
      );
    } on TimeoutException {
      throw ApiNotRespondingException(
        'API not responding in time',
        uri.toString(),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<dynamic>> validateOtpForLinking(
    String api,
    String opToken,
    Map<String, String> validateOtp,
    String otp,
  ) async {
    final Uri uri = Uri.parse(_baseURL + api);
    final String url = _baseURL + api;
    try {
      final Response<dynamic> response = await post(
        url,
        validateOtp,
        headers: <String, String>{opToken: opToken},
        query: <String, String>{opToken: otp},
      ).timeout(const Duration(seconds: TIME_OUT_DURATION));
      if (response.isOk) {
        return response;
      } else {
        DialogHelper.showErrorDialog(
          title: 'Error occurred ${response.statusCode}',
          description: response.statusText,
        );
        return null;
      }
      // return _processResponse(response) as Response;
    } on SocketException {
      throw FetchDataException(
        'No Internet Connection',
        uri.toString(),
      );
    } on TimeoutException {
      throw ApiNotRespondingException(
        'API not responding in time',
        uri.toString(),
      );
    } catch (e) {
      rethrow;
    }
  }

  // dynamic _processResponse(Response response) {
  //   if (response.statusCode > 199 && response.statusCode < 300) {
  //     return response;
  //   } else if (response.statusCode == 400) {
  //     throw BadRequestException(
  //       response.bodyString,
  //       response.request.url.toString(),
  //     );
  //   } else {
  //     throw FetchDataException(
  //       'Error occurred with code : ${response.statusCode}',
  //       response.request.url.toString(),
  //     );
  //   }
  //
  //   //   switch (response.statusCode) {
  //   //     case 200:
  //   //       return response;
  //   //       break;
  //   //     case 201:
  //   //       return response;
  //   //       break;
  //   //     case 400:
  //   //       throw BadRequestException(
  //   //         utf8.decode(response.bodyBytes),
  //   //         response.request.url.toString(),
  //   //       );
  //   //     case 401:
  //   //     case 403:
  //   //       throw UnAuthorizedException(
  //   //         utf8.decode(response.bodyBytes),
  //   //         response.request.url.toString(),
  //   //       );
  //   //     case 500:
  //   //     default:
  //   //       throw FetchDataException(
  //   //         'Error occurred with code : ${response.statusCode}',
  //   //         response.request.url.toString(),
  //   //       );
  //   //   }
  // }
}
