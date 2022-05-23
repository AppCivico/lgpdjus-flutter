import 'package:lgpdjus/core/data/mapper.dart';
import 'package:lgpdjus/core/types.dart';
import 'package:lgpdjus/features/user/account/domain/user_account_entities.dart';

class AccountStatusJsonToEnum extends IMapper<JsonObject, AccountStatus> {
  @override
  AccountStatus call(JsonObject source) {
    if ("${source['account_verified']}" == '1') return AccountStatus.verified;
    if ("${source['account_verification_pending']}" == '1')
      return AccountStatus.processing;
    return AccountStatus.unverified;
  }
}

class AccountStatusStringToEnum extends IMapper<String, AccountStatus> {
  @override
  AccountStatus call(String source) {
    switch (source) {
      case 'verified':
        return AccountStatus.verified;
      case 'processing':
        return AccountStatus.processing;
      case 'unverified':
        return AccountStatus.unverified;
      default:
        throw Exception("AccountStatus name '$source' not found");
    }
  }
}

class AccountStatusEnumToString extends IMapper<AccountStatus, String> {
  @override
  String call(AccountStatus source) => source.toString().split('.').last;
}
