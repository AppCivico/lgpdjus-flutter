import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:lgpdjus/app/core/error/exceptions.dart';
import 'package:lgpdjus/app/core/network/api_server_configure.dart';
import 'package:lgpdjus/app/features/authentication/data/models/session_model.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/email_address.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/sign_in_password.dart';

abstract class IAuthenticationDataSource {
  /// Calls the http://server.api/login? endpoint
  ///
  /// Throws a [ServerException] for all error codes
  Future<SessionModel> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required SignInPassword password,
  });
}

class AuthenticationDataSource implements IAuthenticationDataSource {
  final http.Client apiClient;
  final IApiServerConfigure serverConfiguration;

  AuthenticationDataSource({
    required this.apiClient,
    required this.serverConfiguration,
  });

  @override
  Future<SessionModel> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required SignInPassword password,
  }) async {
    final userAgent = await serverConfiguration.userAgent;
    final queryParameters = {
      'app_version': userAgent,
      'email': emailAddress.rawValue,
      'senha': password.rawValue,
    };

    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };

    final loginUri = Uri(
      path: '/login',
      queryParameters: queryParameters,
    );

    final response = await apiClient.post(loginUri, headers: headers);

    if (response.statusCode == HttpStatus.ok) {
      return SessionModel.fromJson(json.decode(response.body));
    } else {
      throw ApiProviderException(bodyContent: json.decode(response.body));
    }
  }
}
