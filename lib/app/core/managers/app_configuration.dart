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

  Future<void> saveLogoutUrl(String? url);

  Future<String?> logout();

  Uri get apiBaseUri;

  Future<AuthorizationStatus> get authorizationStatus;

  Future<bool> get isFirstRun;

  Future<void> removeFirstRunKey();

  Future<bool> get hasPendingLgpdTutorial;

  set pendingLgpdTutorial(bool hasPendingLgpdTutorial);

  Future<String?> get savedAppVersion;

  set appVersion(String version);
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
  @Deprecated('will be removed soon')
  final _isFirstRunKey = 'br.com.jusbrasil.lgpd.isFirstRun';
  final _hasPendingLgpdTutorialKey =
      'br.com.jusbrasil.lgpd.hasPendingLgpdTutorial';
  final _logoutUrlKey = 'br.com.jusbrasil.lgpd.logout';
  final _appVersionKey = 'br.com.jusbrasil.lgpd.appVersion';

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
    return _storage.hasKey(_isFirstRunKey).then((value) => !value);
  }

  @override
  Future<void> removeFirstRunKey() => _storage.delete(_isFirstRunKey);

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
  Future<String?> get savedAppVersion => _storage.get(_appVersionKey);

  @override
  set appVersion(String version) {
    _storage.put(_appVersionKey, version);
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
  }

  @override
  Future<void> saveLogoutUrl(String? url) async {
    url ??= "";
    await _storage.put(_logoutUrlKey, url);
  }

  @override
  Future<String?> logout() async {
    String? logoutUrl = await _storage.get(_logoutUrlKey);
    await Future.wait([
      saveApiToken(token: null),
      _storage.delete(USER_DATA_KEY),
      _storage.delete(_logoutUrlKey),
      _storage.delete(_hasPendingLgpdTutorialKey),
    ]);
    return logoutUrl;
  }
}
