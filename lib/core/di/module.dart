import 'package:flutter_modular/flutter_modular.dart' as modular;
import 'package:lgpdjus/core/di/bind.dart';

abstract class Module extends modular.Module {
  abstract final List<modular.Module> modules;

  Module() : super() {
    binds.insertAll(0, modules.expand((m) {
      modular.Modular.debugPrintModular("-- ${m.name} INITIALIZED");
      return m.binds;
    }));
    routes.insertAll(0, modules.expand((e) => e.routes));
  }
}
