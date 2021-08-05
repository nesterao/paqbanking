import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class RequestManager extends GetConnect {
  static const int TIME_OUT_DURATION = 20;

  Future<Response<dynamic>> postRequest(
    String url, {
    Map<String, dynamic> postData,
    Map<String, dynamic> postQuery,
    Map<String, String> postHeader,
  }) async {
    try {
      final Response<dynamic> response = await post(
        url,
        postData,
        headers: postHeader,
        query: postQuery,
      ).timeout(const Duration(seconds: TIME_OUT_DURATION));
      if (response.unauthorized) {
        throw 'Request Unauthorized';
      }
      return response;
    }
    // on SocketException {
    //   throw FetchDataException(
    //     'No Internet Connection',
    //   );
    // }
    // } on TimeoutException {
    //   throw ApiNotRespondingException(
    //     'API not responding in time',
    //     uri.toString(),
    //   );
    // }
    catch (e) {
      debugPrintSynchronously(e.toString());
      rethrow;
    }
  }

  Future<Response<dynamic>> getRequest(
    String url, {
    Map<String, dynamic> getQuery,
    Map<String, String> getHeader,
  }) async {
    try {
      final Response<dynamic> response = await get(
        url,
        headers: getHeader,
        query: getQuery,
      ).timeout(const Duration(seconds: TIME_OUT_DURATION));
      if (response.unauthorized) {
        throw 'Request Unauthorized';
      }
      return response;
    }
    // on SocketException {
    //   throw FetchDataException(
    //     'No Internet Connection',
    //   );
    // }
    // } on TimeoutException {
    //   throw ApiNotRespondingException(
    //     'API not responding in time',
    //     uri.toString(),
    //   );
    // }
    catch (e) {
      debugPrintSynchronously(e.toString());
      rethrow;
    }
  }
}
