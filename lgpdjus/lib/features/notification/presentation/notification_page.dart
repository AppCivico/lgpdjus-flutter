import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:lgpdjus/app/features/common/presentation/support_center_general_error.dart';
import 'package:lgpdjus/app/shared/design_system/colors.dart';
import 'package:lgpdjus/app/shared/design_system/text_styles.dart';
import 'package:lgpdjus/app/shared/widgets/appbar/appbar.dart';
import 'package:lgpdjus/common/widgets/background_decoration.dart';
import 'package:lgpdjus/features/notification/domain/entities/notification_session_entity.dart';
import 'package:lgpdjus/features/notification/domain/states/notification_state.dart';
import 'package:lgpdjus/features/notification/presentation/widgets/notification_card.dart';

import 'notification_controller.dart';

class NotificationPage extends StatefulWidget {
  final String title;

  NotificationPage({
    Key? key,
    this.title = "Notificações",
  }) : super(key: key);

  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState
    extends ModularState<NotificationPage, NotificationController>
    with SnackBarHandler {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemedAppBar(
        title: "Notificações",
      ),
      body: Container(
        decoration: BackgroundDecoration.main(),
        child: Observer(
          builder: (_) {
            return bodyBuilder(controller.state);
          },
        ),
      ),
    );
  }
}

extension _PageStateBuilder on _NotificationState {
  Widget bodyBuilder(NotificationState state) {
    return state.when(
      initial: () => buildInitialState(),
      loaded: (notifications) => buildLoaded(notifications),
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
          'Você não tem notificações',
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

  Widget buildLoaded(List<NotificationEntity> notifications) {
    return Material(
      child: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (BuildContext context, int index) {
          final notification = notifications[index];
          return NotificationCard(
            notification: notification,
          );
        },
      ),
    );
  }
}
