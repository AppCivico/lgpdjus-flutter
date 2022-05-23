import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:lgpdjus/core/di/widget_module.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:lgpdjus/app/features/common/presentation/support_center_general_error.dart';
import 'package:lgpdjus/app/shared/design_system/colors.dart';
import 'package:lgpdjus/app/shared/design_system/dimens.dart';
import 'package:lgpdjus/app/shared/design_system/text_styles.dart';
import 'package:lgpdjus/app/shared/widgets/appbar/appbar.dart';
import 'package:lgpdjus/app/shared/widgets/button/rounded_button.dart';
import 'package:lgpdjus/app/shared/widgets/card/card.dart';
import 'package:lgpdjus/common/domain/titles/entity.dart';
import 'package:lgpdjus/features/ticket/domain/entities/ticket_tiles.dart';
import 'package:lgpdjus/features/ticket/domain/states/ticket_state.dart';
import 'package:lgpdjus/features/ticket/presentation/list/tickets_controller.dart';

class TicketsPage extends StatefulWidget {
  const TicketsPage({
    Key? key,
    this.title = "Ticket",
    this.theme,
  }) : super(key: key);

  final String title;
  final ThemeData? theme;

  @override
  _TicketsPageState createState() => _TicketsPageState();
}

class _TicketsPageState extends ModularWidgetState<TicketsPage, TicketsController>
    with SnackBarHandler {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: widget.theme ?? Theme.of(context),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: ThemedAppBar(
          title: widget.title,
        ),
        body: Observer(
          builder: (_) => bodyBuilder(controller.state),
        ),
      ),
    );
  }
}

extension _PageStateBuilder on _TicketsPageState {
  Widget bodyBuilder(TicketState state) {
    return state.when(
      initial: () => buildInitialState(),
      loaded: (tiles) => buildLoaded(tiles),
      empty: () => buildEmptyState(),
      error: (message) => SupportCenterGeneralError(
        message: message,
        onPressed: controller.retry,
      ),
    );
  }

  Widget buildEmptyState() {
    return SafeArea(
      child: Center(
        child: Text(
          'Você não tem solicitações',
          style: kTextEmptyList,
        ),
      ),
    );
  }

  Widget buildInitialState() {
    return SafeArea(
      child: PageProgressIndicator(
        progressState: PageProgressState.loading,
        progressMessage: "Carregando...",
        child: Container(color: DesignSystemColors.white),
      ),
    );
  }

  Widget buildLoaded(List<Tile> tiles) {
    return SafeArea(
      child: ListView.builder(
        padding: EdgeInsets.only(top: 16.0),
        itemCount: tiles.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildTileItem(context, tiles[index]);
        },
      ),
    );
  }

  Widget _buildTileItem(BuildContext context, Tile tile,
      {bool isVerticalScroll: true}) {
    if (tile is HeaderTile) {
      return Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
        child: Text(
          tile.text,
          style: widget.theme?.textTheme.headline6,
        ),
      );
    }
    if (tile is TicketTile) {
      return RoundedCard(
        margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
        child: InkWell(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: HtmlWidget(tile.content),
          ),
          onTap: () => controller.navigate(tile),
        ),
      );
    }
    if (tile is Questionnaires) {
      return SizedBox(
        height: 86,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
          itemCount: tile.items.length,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: 220,
              child: _buildTileItem(
                context,
                tile.items[index],
                isVerticalScroll: false,
              ),
            );
          },
        ),
      );
    }
    if (tile is Questionnaire) {
      final verticalMargin = isVerticalScroll ? 16.0 : 4.0;
      return RoundedCard(
        elevation: DesignSystemDimens.cardElevation,
        margin: EdgeInsets.only(
          left: verticalMargin,
          right: verticalMargin,
          bottom: 16.0,
        ),
        child: InkWell(
          onTap: () => controller.navigate(tile),
          child: Row(
            children: [
              Expanded(
                child: ListTile(
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  title: Text(
                    tile.header,
                    maxLines: 2,
                    style: widget.theme?.textTheme.headline6?.copyWith(
                      color: widget.theme?.primaryColor,
                      fontSize: 18,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    tile.body,
                  ),
                ),
              ),
              RoundedButton(
                icon: Icons.arrow_forward_ios_rounded,
                onPressed: () => controller.navigate(tile),
              ),
            ],
          ),
        ),
      );
    }
    return Container();
  }
}
