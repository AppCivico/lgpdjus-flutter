import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:lgpdjus/app/core/error/exceptions.dart';
import 'package:lgpdjus/app/features/authentication/data/models/login_session.dart';
import 'package:lgpdjus/app/features/authentication/data/models/session_model.dart';
import 'package:package_info_plus/package_info_plus.dart';

abstract class IAuthenticationDataSource {
  Future<LoginSession> getLoginSession();
  Future<SessionModel> getApiToken(String authToken);
}

class AuthenticationDataSource implements IAuthenticationDataSource {
  final http.Client apiClient;

  AuthenticationDataSource({
    required this.apiClient,
  });

  Future<LoginSession> getLoginSession() async {
    final loginUri = Uri(path: '/login-govbr');

    final appVersion =
        await PackageInfo.fromPlatform().then((info) => info.version);
    final body = {
      'app_version': appVersion,
    };

    final response = await apiClient.post(loginUri, body: body);

    if (response.statusCode == HttpStatus.ok) {
      return LoginSession.fromJson(jsonDecode(response.body));
    } else {
      throw ApiProviderException(bodyContent: jsonDecode(response.body));
    }
  }

  @override
  Future<SessionModel> getApiToken(String authToken) async {
    final loginUri = Uri(path: '/status-govbr', queryParameters: {
      'token': authToken,
    });

    final response = await apiClient.get(loginUri);

    if (response.statusCode == HttpStatus.ok) {
      return SessionModel.fromJson(jsonDecode(response.body));
    } else {
      throw ApiProviderException(bodyContent: jsonDecode(response.body));
    }
  }
}
