import 'package:lgpdjus/features/user/account/data/mapper/user_account_status_mapper.dart';
import 'package:lgpdjus/features/user/account/domain/user_account_entities.dart';
import 'package:test/test.dart';

void main() {
  group('AccountStatusJsonToEnum', () {
    final target = AccountStatusJsonToEnum();

    test('should map to `AccountStatus.verified`', () {
      final source = {'account_verified': 1};
      expect(AccountStatus.verified, target.call(source));
    });

    test('should map to `AccountStatus.processing`', () {
      final source = {'account_verified': 0, 'account_verification_pending': 1};
      expect(AccountStatus.processing, target.call(source));
    });

    test('should map to `AccountStatus.unverified`', () {
      final source = {'account_verified': 0, 'account_verification_pending': 0};
      expect(AccountStatus.unverified, target.call(source));
    });
  });

  group('AccountStatusStringToEnum', () {
    final target = AccountStatusStringToEnum();

    test('should map to `AccountStatus.verified`', () {
      expect(AccountStatus.verified, target.call('verified'));
    });

    test('should map to `AccountStatus.processing`', () {
      expect(AccountStatus.processing, target.call('processing'));
    });

    test('should map to `AccountStatus.unverified`', () {
      expect(AccountStatus.unverified, target.call('unverified'));
    });

    test('given invalid status Should throw error', () {
      expect(
        () => target.call('mock'),
        throwsA((e) => e.message == 'AccountStatus name \'mock\' not found'),
      );
    });
  });

  group('AccountStatusEnumToString', () {
    final target = AccountStatusEnumToString();

    test('given `AccountStatus.verified` should map to `verified`', () {
      expect('verified', target.call(AccountStatus.verified));
    });

    test('given `AccountStatus.unverified` should map to `unverified`', () {
      expect('unverified', target.call(AccountStatus.unverified));
    });

    test('given `AccountStatus.processing` should map to `processing`', () {
      expect('processing', target.call(AccountStatus.processing));
    });
  });
}
