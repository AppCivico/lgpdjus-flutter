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
import 'package:lgpdjus/features/about/domain/entity/details_screen.dart';
import 'package:lgpdjus/features/about/presentation/lgpd/details/details_controller.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => _DetailsPageState();
}

class _DetailsPageState
    extends ModularWidgetState<DetailsPage, DetailsController>
    with SnackBarHandler {
  late final WidgetResolver _widgetResolver = inject();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: OrangeThemeFactory().of(context),
      child: Scaffold(
        appBar: ThemedAppBar(title: widget.title),
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

  Widget _onLoaded(DetailsScreen screen) {
    return SingleChildScrollView(
      child: Container(
        decoration: BackgroundDecoration.orange(),
        padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
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
