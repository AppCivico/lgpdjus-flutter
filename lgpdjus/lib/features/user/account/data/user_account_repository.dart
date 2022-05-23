import 'package:lgpdjus/app/shared/logger/log.dart';
import 'package:lgpdjus/core/data/mapper.dart';
import 'package:lgpdjus/features/user/account/data/user_account_datasource.dart';
import 'package:lgpdjus/features/user/account/data/user_account_model.dart';
import 'package:lgpdjus/features/user/account/domain/user_account_entities.dart';
import 'package:lgpdjus/features/user/account/domain/user_account_repository.dart';
import 'package:rxdart/rxdart.dart';

class AccountRepositoryImpl extends AccountRepository {
  AccountRepositoryImpl(
    this._localDataSource,
    this._remoteDataSource,
    this._toEntityMapper,
  );

  final AccountLocalDataSource _localDataSource;
  final AccountRemoteDataSource _remoteDataSource;

  final IMapper<AccountModel, Account> _toEntityMapper;

  @override
  Stream<Account?> get() {
    return Rx.concat<Account?>([
      _fromLocalDataSource(),
      _fromRemoteDataSource(),
    ]).startWith(null).distinct();
  }

  Stream<Account?> _fromLocalDataSource() async* {
    final profile = await _localDataSource.get();
    if (profile != null) {
      yield _toEntityMapper.call(profile);
    }
  }

  Stream<Account> _fromRemoteDataSource() {
    return _remoteDataSource
        .get()
        .doOnData(_localDataSource.save)
        .doOnError(catchErrorLogger)
        .onErrorResumeNext(Stream.empty())
        .map(_toEntityMapper);
  }
}
