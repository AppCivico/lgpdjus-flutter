import 'package:lgpdjus/features/user/account/domain/user_account_entities.dart';
import 'package:lgpdjus/features/user/account/domain/user_account_repository.dart';

class GetAccountUseCase {
  GetAccountUseCase(this._repository);

  final AccountRepository _repository;

  Stream<Account?> call() => _repository.get();
}
