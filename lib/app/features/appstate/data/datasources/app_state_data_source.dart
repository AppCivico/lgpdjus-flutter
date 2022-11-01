import 'package:http/http.dart' as http;
import 'package:lgpdjus/app/core/extension/http.dart';
import 'package:lgpdjus/app/features/appstate/data/model/app_state_model.dart';
import 'package:lgpdjus/app/features/appstate/domain/entities/update_user_profile_entity.dart';
import 'package:lgpdjus/common/data/appstate/datasource.dart' as appState;

abstract class IAppStateDataSource {
  Future<AppStateModel> check();

  Future<AppStateModel> update(UpdateUserProfileEntity update);
}

class AppStateDataSource implements IAppStateDataSource {
  final http.Client _apiClient;
  final appState.AppStateDataSource _dataSource;

  AppStateDataSource({
    required http.Client apiClient,
    required appState.AppStateDataSource dataSource,
  })  : this._apiClient = apiClient,
        this._dataSource = dataSource;

  @override
  Future<AppStateModel> check() async {
    final response = await _dataSource.refreshAndGet();
    return AppStateModel.fromJson(response);
  }

  @override
  Future<AppStateModel> update(UpdateUserProfileEntity update) async {
    final httpRequest = Uri(path: "/me");

    final parameters = {
      if (update.nickName != null) 'apelido': update.nickName,
      if (update.email != null) 'email': update.email,
    };


    final call = _apiClient.put(
      httpRequest,
      headers: contentTypeFormUrlencoded,
      body: parameters,
    );
    final response = await _dataSource.refreshFromCall(call);
    return AppStateModel.fromJson(response);
  }
}
