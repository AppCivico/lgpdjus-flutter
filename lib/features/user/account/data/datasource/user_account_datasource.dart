import 'package:lgpdjus/app/core/managers/app_configuration.dart';
import 'package:lgpdjus/app/core/managers/local_store.dart';
import 'package:lgpdjus/app/core/storage/i_local_storage.dart';
import 'package:lgpdjus/common/data/appstate/datasource.dart';
import 'package:lgpdjus/core/data/mapper.dart';
import 'package:lgpdjus/core/types.dart';
import 'package:lgpdjus/features/user/account/data/user_account_datasource.dart';
import 'package:lgpdjus/features/user/account/data/user_account_model.dart';

class AccountLocalDataSourceImpl extends LocalStore<AccountModel>
    implements AccountLocalDataSource {
  AccountLocalDataSourceImpl(
    ILocalStorage storage,
    this._fromJsonMapper,
    this._toJsonMapper,
  ) : super(USER_DATA_KEY, storage);

  final IMapper<JsonObject, AccountLocalModel> _fromJsonMapper;
  final IMapper<AccountModel, JsonObject> _toJsonMapper;

  @override
  Future<AccountModel?> get() => retrieve();

  @override
  AccountModel fromJson(JsonObject json) => _fromJsonMapper.call(json);

  @override
  JsonObject toJson(AccountModel model) => _toJsonMapper.call(model);
}

class AccountRemoteDataSourceImpl extends AccountRemoteDataSource {
  AccountRemoteDataSourceImpl(
    this._appStateDataSource,
    this._mapper,
  );

  final AppStateDataSource _appStateDataSource;
  final IMapper<JsonObject, AccountRemoteModel> _mapper;

  @override
  Stream<AccountModel> get() =>
      _appStateDataSource.observer().map(_parseProfile);

  AccountModel _parseProfile(JsonObject jsonData) {
    if (!jsonData.containsKey('user_profile'))
      throw Exception('Profile data not found');
    return _mapper.call(jsonData['user_profile']);
  }
}
