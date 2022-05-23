import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lgpdjus/core/di/bind.dart';
import 'package:lgpdjus/features/quiz/domain/entity.dart';
import 'package:lgpdjus/features/quiz/presentation/widgets/quiz_divider.dart';

class BoxTileWidget extends StatelessWidget {
  const BoxTileWidget(this.boxTile, {Key? key}) : super(key: key);

  final BoxTile boxTile;

  @override
  Widget build(BuildContext context) {
    final dividerColor = Theme.of(context).primaryColor;
    final boxRadius = const BorderRadius.all(const Radius.circular(10));

    return Flexible(child: _buildContent(boxRadius, context, dividerColor));
  }

  Widget _buildContent(
    BorderRadius boxRadius,
    BuildContext context,
    Color dividerColor,
  ) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: boxTile.shadow,
        borderRadius: boxRadius,
        border: boxTile.getBorder(context),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(top: boxTile.marginTop),
      padding: EdgeInsets.only(right: 16, left: 16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _buildChildren(dividerColor),
        ),
      ),
    );
  }

  List<Widget> _buildChildren(Color dividerColor) {
    final children = boxTile.rows
        .map<Widget>((e) => Modular.getBindParameterized(e))
        .map((e) => e);

    return addDividers(
      children,
      dividerColor: dividerColor,
    ).toList();
  }
}

extension Style on BoxTile {
  List<BoxShadow>? get shadow {
    if (style != BoxTileStyle.shadowed) return null;
    return const [
      const BoxShadow(
        color: Color(0x29000000),
        offset: Offset(0, 3),
        blurRadius: 6,
      ),
    ];
  }

  BoxBorder? getBorder(BuildContext context) {
    if (style != BoxTileStyle.bordered) return null;
    return Border.all(color: Theme.of(context).primaryColor);
  }
}
