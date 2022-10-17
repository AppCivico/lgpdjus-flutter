import 'package:flutter/material.dart';
import 'package:lgpdjus/app/core/pages/image_resolver_widget.dart';
import 'package:lgpdjus/app/shared/widgets/card/card.dart';
import 'package:lgpdjus/common/navigation/action_handler.dart';
import 'package:lgpdjus/core/di/widget_module.dart';
import 'package:lgpdjus/features/about/domain/entity/topics_screen.dart';

class CardWidget extends StatelessWidget {
  CardWidget(this.tile);

  final CardTile tile;
  late final ActionHandler _actionHandler = inject();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final textTheme = themeData.textTheme;

    return RoundedCard(
      margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: InkWell(
        onTap: () {
          _actionHandler.handle(tile);
        },
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Flexible(child: ImageResolverWidget(tile.leading)),
              SizedBox(width: 8),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tile.title,
                      style: textTheme.headline6,
                    ),
                    Text(
                      tile.description,
                      style: textTheme.bodyText2
                          ?.copyWith(color: Color(0xBF3C3C3B)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
