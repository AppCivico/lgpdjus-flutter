import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lgpdjus/core/di/bind.dart';

abstract class ModularWidget extends WidgetModule {
  @override
  Widget build(BuildContext context) {
    return ModularProvider(
      module: this,
      child: view,
    );
  }
}

class ModularProvider extends StatefulWidget {
  final Module module;
  final Widget child;

  const ModularProvider({Key? key, required this.module, required this.child})
      : super(key: key);

  @override
  _ModularProviderState createState() => _ModularProviderState();
}

class _ModularProviderState extends State<ModularProvider> {
  @override
  void initState() {
    super.initState();
    Modular.addCoreInit(widget.module);
    Modular.debugPrintModular("-- ${widget.module.name} INITIALIZED");
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    Modular.removeModule(widget.module);
    Modular.debugPrintModular("-- ${widget.module.name} DISPOSED");
    super.dispose();
  }
}

abstract class ModularWidgetState<TWidget extends StatefulWidget,
    TBind extends Object> extends State<TWidget> {
  late final TBind _scope = inject();

  TBind get controller => _scope;

  @override
  void dispose() {
    super.dispose();
    if (Modular.isSingleton(_scope)) return;
    final isDisposed = Modular.dispose<TBind>();
    if (isDisposed) {
      return;
    }

    if (_scope is Disposable) {
      (_scope as Disposable).dispose();
    }

    if (_scope is Sink) {
      (_scope as Sink).close();
    } else if (_scope is ChangeNotifier) {
      (_scope as ChangeNotifier).dispose();
    }
  }
}

T inject<T extends Object>() => Modular.get<T>();
