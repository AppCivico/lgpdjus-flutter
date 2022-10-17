import 'package:lgpdjus/features/user/account/domain/user_account_entities.dart';
import 'package:lgpdjus/features/drawer/domain/entities.dart';

abstract class MenuSectionsRepository {
  Future<Menu> getAuthenticated(Account account);
  Future<Menu> getUnauthenticated();
}
