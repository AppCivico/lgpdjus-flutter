import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:lgpdjus/app/features/common/presentation/support_center_general_error.dart';
import 'package:lgpdjus/app/shared/design_system/theme.dart';
import 'package:lgpdjus/app/shared/widgets/appbar/appbar.dart';
import 'package:lgpdjus/common/di/widget_resolver.dart';
import 'package:lgpdjus/common/widgets/background_decoration.dart';
import 'package:lgpdjus/common/widgets/snackbar.dart';
import 'package:lgpdjus/core/di/widget_module.dart';
import 'package:lgpdjus/features/about/domain/entity/topics_screen.dart';
import 'package:lgpdjus/features/about/presentation/lgpd/topics/topics_controller.dart';

class TopicsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TopicsPageState();
}

class _TopicsPageState extends ModularWidgetState<TopicsPage, TopicsController>
    with SnackBarHandler {
  late final WidgetResolver _widgetResolver = inject();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: OrangeThemeFactory().of(context),
      child: Scaffold(
        appBar: ThemedAppBar(title: 'Sobre LGPD'),
        body: Observer(builder: _bodyBuilder),
      ),
    );
  }

  Widget _bodyBuilder(BuildContext context) {
    return controller.state.when(
      loading: _onLoading,
      loaded: _onLoaded,
      failed: _onFailure,
    );
  }

  Widget _onLoaded(TopicsScreen screen) {
    return SingleChildScrollView(
      child: Container(
        decoration: BackgroundDecoration.orange(),
        padding: EdgeInsets.all(16).copyWith(top: 32),
        child: Column(
          children: _widgetResolver.resolveAll(screen.items),
        ),
      ),
    );
  }

  Widget _onLoading() {
    return PageProgressIndicator(
      progressState: PageProgressState.loading,
      progressMessage: "Carregando...",
      child: Container(),
    );
  }

  Widget _onFailure(Object error) {
    return SupportCenterGeneralError(
      message: extractErrorMessage(error),
      onPressed: controller.retry,
    );
  }
}
