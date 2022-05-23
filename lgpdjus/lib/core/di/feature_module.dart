import 'package:flutter_modular/flutter_modular.dart';

mixin FeatureModule on Module {
  final List<Bind> presentationBinds = [];
  final List<Bind> domainBinds = [];
  final List<Bind> dataBinds = [];

  @override
  late final List<Bind> binds = presentationBinds + domainBinds + dataBinds;
}