import 'package:lgpdjus/features/user/account/data/user_account_model.dart';

abstract class AccountRemoteDataSource {
  Stream<AccountModel> get();
}

abstract class AccountLocalDataSource {
  Future<AccountModel?> get();

  Future<void> save(AccountModel profile);
}
