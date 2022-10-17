import 'package:flutter_modular/flutter_modular.dart' as modular;

abstract class Module extends modular.Module {
  abstract final List<modular.Module> modules;

  Module() : super() {
    binds.insertAll(0, modules.expand((e) => e.binds));
    routes.insertAll(0, modules.expand((e) => e.routes));
  }
}
