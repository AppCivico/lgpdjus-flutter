import 'dart:io';

import 'package:http/http.dart';
import 'package:lgpdjus/app/core/error/failures.dart';
import 'package:lgpdjus/app/core/network/interceptor/interceptor.dart';
import 'package:lgpdjus/app/core/network/network_info.dart';

class ConnectionInterceptor implements HttpInterceptor {
  ConnectionInterceptor(this.networkInfo);

  final INetworkInfo networkInfo;

  @override
  Future<StreamedResponse> intercept(
    BaseRequest request,
    Next next,
  ) async {
    if (!await networkInfo.isConnected) {
      throw InternetConnectionFailure();
    }
    try {
      return next(request);
    } catch (e) {
      if (e is IOException && !await networkInfo.isConnected) {
        throw InternetConnectionFailure();
      }
      rethrow;
    }
  }
}
