import 'package:lgpdjus/features/user/account/domain/user_account_entities.dart';
import 'package:test/test.dart';

void main() {
  group('AccountStatus', () {
    test('should has 3 account status types', () {
      expect(3, AccountStatus.values.length);
    });
  });
}
