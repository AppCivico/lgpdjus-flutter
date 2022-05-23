import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:lgpdjus/app/core/entities/valid_fiel.dart';
import 'package:lgpdjus/app/core/error/exceptions.dart';
import 'package:lgpdjus/app/core/network/api_server_configure.dart';
import 'package:lgpdjus/app/features/authentication/data/models/session_model.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/cpf.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/email_address.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/full_name.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/nickname.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/sign_up_password.dart';

abstract class IUserRegisterDataSource {
  Future<SessionModel> register({
    required EmailAddress emailAddress,
    required SignUpPassword password,
    required Cpf cpf,
    required Fullname fullname,
    required Nickname nickName,
  });

  Future<ValidField> checkField({
    EmailAddress? emailAddress,
    SignUpPassword? password,
    Cpf? cpf,
    Fullname? fullname,
    Nickname? nickName,
  });
}

class UserRegisterDataSource implements IUserRegisterDataSource {
  final http.Client apiClient;
  final IApiServerConfigure serverConfiguration;

  UserRegisterDataSource({
    required this.apiClient,
    required this.serverConfiguration,
  });

  @override
  Future<SessionModel> register({
    required EmailAddress emailAddress,
    required SignUpPassword password,
    required Cpf cpf,
    required Fullname fullname,
    required Nickname nickName,
  }) async {
    final userAgent = await serverConfiguration.userAgent;
    final Map<String, String?> queryParameters = {
      'app_version': userAgent,
      'dry': '0',
      'email': emailAddress.rawValue,
      'senha': password.rawValue,
      'cpf': cpf.rawValue,
      'nome_completo': fullname.rawValue,
      'apelido': nickName.rawValue,
    };

    final httpHeader = await _setupHttpHeader();
    final httpRequest =
        await _setupHttpRequest(queryParameters: queryParameters);

    final response = await apiClient.post(httpRequest, headers: httpHeader);
    if (response.statusCode == HttpStatus.ok) {
      return SessionModel.fromJson(json.decode(response.body));
    } else {
      throw ApiProviderException(bodyContent: json.decode(response.body));
    }
  }

  @override
  Future<ValidField> checkField({
    EmailAddress? emailAddress,
    SignUpPassword? password,
    Cpf? cpf,
    Fullname? fullname,
    Nickname? nickName,
  }) async {
    final userAgent = await serverConfiguration.userAgent;
    final Map<String, String?> queryParameters = {
      'app_version': userAgent,
      'dry': '1',
      'email': emailAddress?.rawValue,
      'senha': password?.rawValue,
      'cpf': cpf?.rawValue,
      'nome_completo': fullname?.rawValue,
      'apelido': nickName?.rawValue,
    };

    final httpHeader = await _setupHttpHeader();
    final httpRequest =
        await _setupHttpRequest(queryParameters: queryParameters);
    final response = await apiClient.post(httpRequest, headers: httpHeader);
    if (response.statusCode == HttpStatus.ok) {
      return ValidField();
    } else {
      throw ApiProviderException(bodyContent: json.decode(response.body));
    }
  }

  Future<Map<String, String>> _setupHttpHeader() async {
    final userAgent = await serverConfiguration.userAgent;
    return {
      'User-Agent': userAgent,
      'Content-Type': 'application/x-www-form-urlencoded'
    };
  }

  Future<Uri> _setupHttpRequest(
      {required Map<String, String?> queryParameters}) async {
    queryParameters.removeWhere((k, v) => v == null);
    return Uri(
      path: '/signup',
      queryParameters: queryParameters,
    );
  }
}
