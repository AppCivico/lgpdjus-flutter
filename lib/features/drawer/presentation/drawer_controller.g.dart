// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drawer_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DrawerMenuController on _DrawerMenuControllerBase, Store {
  late final _$stateAtom =
      Atom(name: '_DrawerMenuControllerBase.state', context: context);

  @override
  DrawerState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(DrawerState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
