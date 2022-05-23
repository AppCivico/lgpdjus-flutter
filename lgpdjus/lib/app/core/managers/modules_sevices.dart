import 'dart:convert';

import 'package:lgpdjus/app/core/extension/iterable.dart';
import 'package:lgpdjus/app/core/storage/i_local_storage.dart';
import 'package:lgpdjus/app/features/appstate/domain/entities/app_state_entity.dart';

abstract class IAppModulesServices {
  Future<void> save(List<AppStateModuleEntity> modules);

  Future<AppStateModuleEntity> feature({required String name});
}

class AppModulesServices implements IAppModulesServices {
  final ILocalStorage _storage;
  final _appModuleKey = 'br.com.jusbrasil.lgpd..appModules';

  AppModulesServices({required ILocalStorage storage})
      : this._storage = storage;

  @override
  Future<void> save(List<AppStateModuleEntity> modules) {
    final data = modules.map((e) => e.toJson()).toList();
    final jsonString = jsonEncode(data);
    return _storage.put(_appModuleKey, jsonString);
  }

  @override
  Future<AppStateModuleEntity> feature({required String name}) {
    return _storage
        .get(_appModuleKey)
        .then((source) => jsonDecode(source!) as List<dynamic>)
        .then((value) => _filterFeature(name: name, objects: value)!);
  }

  AppStateModuleEntity? _filterFeature({
    String? name,
    required List<dynamic> objects,
  }) {
    final object = objects.firstWhereOrNull((e) => e?['code'] == name);

    if (object == null || object.isEmpty) {
      return null;
    }

    return AppStateModuleEntityJson.fromJson(object);
  }
}

extension AppStateModuleEntityJson on AppStateModuleEntity {
  Map<String, dynamic> toJson() => {'code': this.code, 'meta': this.meta};

  static AppStateModuleEntity fromJson(Map<String, dynamic> object) =>
      AppStateModuleEntity(
        code: object['code'],
        meta: object['meta'],
      );
}
