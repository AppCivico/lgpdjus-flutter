import 'package:lgpdjus/app/core/auth/authentication.dart';
import 'package:lgpdjus/app/core/data/authorization_status.dart';
import 'package:lgpdjus/app/core/storage/i_local_storage.dart';
import 'package:lgpdjus/core/config.dart';

const String USER_DATA_KEY = 'br.com.jusbrasil.lgpd.userProfile';

abstract class IAppConfiguration {
  Future<String?> get apiToken;
  Future<String?> get authToken;

  Future<void> saveApiToken({required String? token});

  Future<void> saveAuthToken(String? token);

  Future<void> logout();

  Uri get apiBaseUri;

  Future<AuthorizationStatus> get authorizationStatus;

  Future<bool> get isFirstRun;

  set firstRun(bool isFirstRun);

  Future<bool> get hasPendingLgpdTutorial;

  set pendingLgpdTutorial(bool hasPendingLgpdTutorial);
}

class AppConfiguration implements IAppConfiguration {
  AppConfiguration({
    required ILocalStorage storage,
    required AuthenticationSubject authenticationSubject,
  })  : this._storage = storage,
        this._authenticationSubject = authenticationSubject;

  final ILocalStorage _storage;
  final AuthenticationSubject _authenticationSubject;

  final _tokenKey = 'br.com.jusbrasil.lgpd.tokenServer';
  final _authTokenKey = 'br.com.jusbrasil.lgpd.authToken';
  final _isFirstRunKey = 'br.com.jusbrasil.lgpd.isFirstRun';
  final _hasPendingLgpdTutorialKey =
      'br.com.jusbrasil.lgpd.hasPendingLgpdTutorial';

  @override
  late Uri apiBaseUri = Uri.parse(kApiBaseUrl);

  set _authorizationStatus(AuthorizationStatus status) {
    _authenticationSubject.add(status);
  }

  @override
  Future<String?> get apiToken {
    return _storage.get(_tokenKey);
  }

  @override
  Future<String?> get authToken => _storage.get(_authTokenKey);

  @override
  Future<bool> get isFirstRun {
    return _storage.getBool(_isFirstRunKey, true);
  }

  @override
  set firstRun(bool value) {
    _storage.setBool(_isFirstRunKey, value);
  }

  @override
  Future<bool> get hasPendingLgpdTutorial {
    return _storage.getBool(_hasPendingLgpdTutorialKey, true);
  }

  @override
  set pendingLgpdTutorial(bool value) {
    _storage.setBool(_hasPendingLgpdTutorialKey, value);
  }

  @override
  Future<AuthorizationStatus> get authorizationStatus async {
    final value = await apiToken;
    final status = value == null || value.isEmpty
        ? AuthorizationStatus.anonymous
        : AuthorizationStatus.authenticated;
    _authorizationStatus = status;
    return status;
  }

  @override
  Future<void> saveApiToken({required String? token}) async {
    token ??= "";
    await _storage.put(_tokenKey, token);
    _authorizationStatus = token.isNotEmpty
        ? AuthorizationStatus.authenticated
        : AuthorizationStatus.anonymous;
    return;
  }

  @override
  Future<void> saveAuthToken(String? token) async {
    token ??= "";
    await _storage.put(_authTokenKey, token);
    return;
  }

  @override
  Future<void> logout() async {
    await saveApiToken(token: null);
    await _storage.delete(USER_DATA_KEY);
  }
}
