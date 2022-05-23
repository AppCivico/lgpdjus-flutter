import 'package:lgpdjus/features/drawer/domain/entities.dart';
import 'package:lgpdjus/features/drawer/domain/repositories/menu_sections.dart';
import 'package:lgpdjus/features/user/account/domain/user_account_entities.dart';
import 'package:lgpdjus/features/user/account/domain/user_account_usecase.dart';
import 'package:rxdart/rxdart.dart';

class GetMenuSectionsUseCase {
  GetMenuSectionsUseCase(this._getAccount, this._repository);

  final GetAccountUseCase _getAccount;
  final MenuSectionsRepository _repository;

  Stream<Menu> call() {
    return _getAccount.call().onErrorReturn(null).asyncMap(_getMenu);
  }

  Future<Menu> _getMenu(Account? account) {
    if (account == null) {
      return _repository.getUnauthenticated();
    }
    return _repository.getAuthenticated(account);
  }
}
