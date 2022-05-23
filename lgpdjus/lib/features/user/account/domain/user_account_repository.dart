import 'package:lgpdjus/features/user/account/domain/user_account_entities.dart';

abstract class AccountRepository {
  Stream<Account?> get();
}
