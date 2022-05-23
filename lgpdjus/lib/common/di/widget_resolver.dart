import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lgpdjus/common/domain/titles/entity.dart';
import 'package:lgpdjus/core/di/bind.dart';

class WidgetResolver {
  Widget resolve(Tile tile) => Modular.getBindParameterized(tile);

  List<Widget> resolveAll(List<Tile> tiles) =>
      tiles.map<Widget>(resolve).toList();
}
