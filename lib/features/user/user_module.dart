import 'package:flutter_modular/flutter_modular.dart';
import 'package:lgpdjus/core/di/feature_module.dart';
import 'package:lgpdjus/features/user/account/data/datasource/user_account_datasource.dart';
import 'package:lgpdjus/features/user/account/data/mapper/user_account_mapper.dart';
import 'package:lgpdjus/features/user/account/data/user_account_datasource.dart';
import 'package:lgpdjus/features/user/account/data/user_account_repository.dart';
import 'package:lgpdjus/features/user/account/domain/user_account_repository.dart';
import 'package:lgpdjus/features/user/account/domain/user_account_usecase.dart';

class AccountModule extends Module with FeatureModule {
  @override
  List<Bind<Object>> get domainBinds => [
        Bind.lazySingleton<GetAccountUseCase>((i) => GetAccountUseCase(i())),
      ];

  @override
  List<Bind<Object>> get dataBinds => [
        Bind.factory<AccountRepository>(
          (i) => AccountRepositoryImpl(i(), i(), i()),
        ),
        Bind.factory<AccountLocalDataSource>(
          (i) => AccountLocalDataSourceImpl(i(), i(), i()),
        ),
        Bind.factory<AccountRemoteDataSource>(
          (i) => AccountRemoteDataSourceImpl(i(), i()),
        ),

        // Mappers
        Bind.factory<IMapper<JsonObject, AccountLocalModel>>(
          (i) => AccountJsonToLocalModel(),
        ),
        Bind.factory<IMapper<JsonObject, AccountRemoteModel>>(
          (i) => AccountJsonToRemoteModel(),
        ),
        Bind.factory<IMapper<AccountModel, Account>>(
          (i) => AccountModelToEntity(),
        ),
        Bind.factory<IMapper<AccountModel, JsonObject>>(
          (i) => AccountModelToJson(),
        ),
      ];
}
