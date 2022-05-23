import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:lgpdjus/app/core/error/failures.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:lgpdjus/app/features/common/presentation/support_center_general_error.dart';
import 'package:lgpdjus/app/shared/design_system/theme.dart';
import 'package:lgpdjus/app/shared/widgets/appbar/appbar.dart';
import 'package:lgpdjus/app/shared/widgets/card/card.dart';
import 'package:lgpdjus/common/navigation/action_handler.dart';
import 'package:lgpdjus/core/di/widget_module.dart';
import 'package:lgpdjus/features/ticket/domain/entities/ticket_screen.dart';
import 'package:lgpdjus/features/ticket/presentation/detail/ticket_detail_controller.dart';

class TicketDetailPage extends StatefulWidget {
  @override
  _TicketDetailPageState createState() => _TicketDetailPageState();
}

class _TicketDetailPageState
    extends ModularWidgetState<TicketDetailPage, TicketDetailController> {
  late final actionHandler = Modular.get<ActionHandler>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: BlueThemeFactory().of(context),
      child: Observer(builder: _buildState),
    );
  }

  Widget _buildState(BuildContext context) {
    return controller.state.when(
      initial: _buildLoading,
      error: _buildError,
      loaded: _buildLoaded,
    );
  }

  Widget _buildLoaded(TicketScreen screen) {
    final cards = screen.items.map(
      (e) {
        return Flexible(
          child: RoundedCard(
            margin: EdgeInsets.only(bottom: 16.0),
            child: InkWell(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      child: HtmlWidget(e.content),
                      width: double.infinity,
                    ),
                    if (e is ActionTicketItem)
                      ElevatedButton(
                        child: Text('Responder'),
                        onPressed: () {
                          actionHandler.handle(e).then((shouldRefresh) {
                            if (shouldRefresh == true) controller.retry();
                          });
                        },
                      )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
    return _buildScaffold(
      title: screen.title,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: cards.toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return _buildScaffold(
      child: PageProgressIndicator(
        progressState: PageProgressState.loading,
        progressMessage: "Carregando...",
        child: Container(),
      ),
    );
  }

  Widget _buildError(Object error) {
    return _buildScaffold(
      child: SupportCenterGeneralError(
        message: extractErrorMessage(error),
        onPressed: controller.retry,
      ),
    );
  }

  Widget _buildScaffold({required Widget child, String title: 'Solicitação'}) {
    return Scaffold(
      appBar: ThemedAppBar(title: title),
      body: child,
    );
  }

  String extractErrorMessage(Object error) {
    if (error is String) {
      return error;
    }
    if (error is Failure) {
      return error.message;
    }

    return "Ops.. ocorreu um erro inesperado.";
  }
}
