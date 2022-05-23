import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/src/core/interfaces/modular_interface.dart';
import 'package:flutter_modular/src/presenters/modular_impl.dart';

class BindTagged<T extends Object> extends Bind<T> {
  BindTagged(
    this.tag,
    T Function(Inject i) inject, {
    isSingleton = true,
    isLazy = true,
    export = false,
  }) : super(inject, isSingleton: isSingleton, isLazy: isLazy, export: export);

  final dynamic tag;
}

class BindParameterized<P, T extends Object> extends Bind<T> {
  BindParameterized(
    T Function(P param, Inject i) resolve, {
    isSingleton = true,
    isLazy = true,
    export = false,
  })  : this.resolve = resolve,
        super(
          _fakeInject,
          isSingleton: isSingleton,
          isLazy: isLazy,
          export: export,
        );

  final dynamic resolve;

  bool canUse(dynamic param) => param.runtimeType.toString() == P.toString();
}

T _fakeInject<T>(Inject i) {
  throw Exception("It is fake!");
}

extension Helpers on ModularInterface {
  ModularImpl get _impl => this as ModularImpl;

  Map<String, Module> get injects {
    return _impl.injectMap;
  }

  void addCoreInit(Module module) {
    injects[module.name] = module;
    module.instance(_getAllSingletons());
  }

  List<dynamic> _getAllSingletons() {
    final list = <dynamic>[];
    for (var key in injects.keys) {
      final module = injects[key]!;
      list.addAll(module.instanciatedSingletons);
    }
    return list;
  }

  void removeModule(Module module) {
    module.cleanInjects();
    injects.remove(module.name);
  }

  T getBindTagged<T extends Object>(dynamic tag) {
    for (var value in injects.values) {
      for (var bind in value.binds) {
        if (bind is BindTagged<T> && bind.tag == tag) {
          return bind.inject(Inject());
        }
      }
    }
    throw Exception("Bind of type ${T.toString()} and tag $tag not found");
  }

  T getBindParameterized<T extends Object, P>(P param) {
    for (var value in injects.values) {
      for (var bind in value.binds) {
        if (bind is BindParameterized<P, T> && bind.canUse(param)) {
          return bind.resolve(param, Inject());
        }
      }
    }
    throw Exception("Bind of type ${T.toString()} for param $param not found");
  }

  bool isSingleton<T extends Object>(T bind) {
    for (var module in injects.values) {
      if (module.getInjectedBind<T>() != null) {
        return true;
      }
    }
    return false;
  }
}

extension ModuleHelper on Module {
  String get name => runtimeType.toString();
}
