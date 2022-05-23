import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:lgpdjus/app/core/entities/valid_fiel.dart';
import 'package:lgpdjus/app/core/error/exceptions.dart';
import 'package:lgpdjus/app/core/network/api_server_configure.dart';
import 'package:lgpdjus/app/features/authentication/data/models/password_reset_response_model.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/email_address.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/sign_up_password.dart';

abstract class IChangePasswordDataSource {
  Future<ValidField> reset({
    required EmailAddress emailAddress,
    required SignUpPassword password,
    required String resetToken,
  });

  Future<ValidField> validToken({
    required EmailAddress emailAddress,
    required String resetToken,
  });

  Future<PasswordResetResponseModel> request({
    required EmailAddress emailAddress,
  });
}

class ChangePasswordDataSource implements IChangePasswordDataSource {
  final http.Client apiClient;
  final IApiServerConfigure serverConfiguration;

  ChangePasswordDataSource({
    required this.apiClient,
    required this.serverConfiguration,
  });

  @override
  Future<PasswordResetResponseModel> request({
    required EmailAddress emailAddress,
  }) async {
    final userAgent = await serverConfiguration.userAgent;
    final Map<String, String> queryParameters = {
      'app_version': userAgent,
      'email': emailAddress.rawValue,
    };

    final httpHeader = await _setupHttpHeader();
    final httpRequest = Uri(
      path: '/reset-password/request-new',
      queryParameters: queryParameters,
    );

    final response = await apiClient.post(httpRequest, headers: httpHeader);
    if (response.statusCode == HttpStatus.ok) {
      return PasswordResetResponseModel.fromJson(json.decode(response.body));
    } else {
      throw ApiProviderException(bodyContent: json.decode(response.body));
    }
  }

  @override
  Future<ValidField> reset({
    required EmailAddress emailAddress,
    required SignUpPassword password,
    required String resetToken,
  }) async {
    final userAgent = await serverConfiguration.userAgent;
    final Map<String, String> queryParameters = {
      'dry': '0',
      'app_version': userAgent,
      'email': emailAddress.rawValue,
      'senha': password.rawValue,
      'token': resetToken,
    };

    final httpHeader = await _setupHttpHeader();
    final httpRequest = Uri(
      path: '/reset-password/write-new',
      queryParameters: queryParameters,
    );

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

  @override
  Future<ValidField> validToken({
    required EmailAddress emailAddress,
    required String resetToken,
  }) async {
    final userAgent = await serverConfiguration.userAgent;
    final Map<String, String> queryParameters = {
      'dry': '1',
      'app_version': userAgent,
      'email': emailAddress.rawValue,
      'token': resetToken,
    };

    final httpHeader = await _setupHttpHeader();
    final httpRequest = Uri(
      path: '/reset-password/write-new',
      queryParameters: queryParameters,
    );

    final response = await apiClient.post(httpRequest, headers: httpHeader);
    if (response.statusCode == HttpStatus.ok) {
      return ValidField();
    } else {
      throw ApiProviderException(bodyContent: json.decode(response.body));
    }
  }
}
