import 'package:lgpdjus/core/data/mapper.dart';
import 'package:lgpdjus/core/types.dart';
import 'package:lgpdjus/features/user/account/data/user_account_model.dart';
import 'package:lgpdjus/features/user/account/domain/user_account_entities.dart';

export 'package:lgpdjus/core/data/mapper.dart';
export 'package:lgpdjus/core/types.dart';
export 'package:lgpdjus/features/user/account/data/user_account_model.dart';
export 'package:lgpdjus/features/user/account/domain/user_account_entities.dart';

class AccountJsonToLocalModel extends IMapper<JsonObject, AccountLocalModel> {
  AccountJsonToLocalModel(this.statusMapper);

  final IMapper<String, AccountStatus> statusMapper;

  @override
  AccountLocalModel call(JsonObject source) {
    return AccountLocalModel(
      email: source['email'],
      fullName: source['name'],
      nickname: source['nickname'],
      status: statusMapper.call(source['status']),
    );
  }
}

class AccountJsonToRemoteModel extends IMapper<JsonObject, AccountRemoteModel> {
  AccountJsonToRemoteModel(this.statusMapper);

  final IMapper<JsonObject, AccountStatus> statusMapper;

  @override
  AccountRemoteModel call(JsonObject source) {
    return AccountRemoteModel(
      email: source['email'] ?? '',
      fullName: source['nome_completo'] ?? '',
      nickname: source['apelido'] ?? '',
      status: statusMapper.call(source),
    );
  }
}

class AccountModelToEntity extends IMapper<AccountModel, Account> {
  @override
  Account call(AccountModel source) {
    return Account(
      email: source.email,
      fullName: source.fullName,
      nickname: source.nickname,
      status: source.status,
    );
  }
}

class AccountModelToJson implements IMapper<AccountModel, JsonObject> {
  AccountModelToJson(this.statusMapper);

  final IMapper<AccountStatus, String> statusMapper;

  @override
  JsonObject call(AccountModel source) {
    return {
      'email': source.email,
      'name': source.fullName,
      'nickname': source.nickname,
      'status': statusMapper.call(source.status),
    };
  }
}
