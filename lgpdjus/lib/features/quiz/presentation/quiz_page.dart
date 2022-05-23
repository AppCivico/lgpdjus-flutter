import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:lgpdjus/app/features/common/presentation/support_center_general_error.dart';
import 'package:lgpdjus/app/shared/design_system/theme.dart';
import 'package:lgpdjus/app/shared/widgets/appbar/appbar.dart';
import 'package:lgpdjus/common/domain/titles/entity.dart';
import 'package:lgpdjus/common/widgets/background_decoration.dart';
import 'package:lgpdjus/common/widgets/dialog.dart';
import 'package:lgpdjus/common/widgets/snackbar.dart';
import 'package:lgpdjus/core/di/bind.dart';
import 'package:lgpdjus/core/di/widget_module.dart';
import 'package:lgpdjus/features/quiz/domain/entity.dart';
import 'package:lgpdjus/features/quiz/presentation/quiz_controller.dart';
import 'package:lgpdjus/features/quiz/presentation/widgets/quiz_progress.dart';
import 'package:mobx/mobx.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class QuizPage extends StatefulWidget {
  QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends ModularWidgetState<QuizPage, QuizController>
    with TickerProviderStateMixin, SnackBarHandler, DialogHandler {
  ReactionDisposer? _disposer;
  final _btnController = RoundedLoadingButtonController();

  @override
  void initState() {
    super.initState();
    if (_disposer == null || _disposer?.reaction.isDisposed == true) {
      _disposer = autorun(
        (_) {
          controller.reaction?.when(
            showDialog: (dialog) {
              _btnController.reset();
              this.showDialog(dialog);
            },
            showError: (error) {
              _btnController.reset();
              showSnackBarError(error);
            },
            hideLoading: _btnController.reset,
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _disposer?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: RedThemeFactory().of(context),
      child: Observer(
        builder: _buildState,
      ),
    );
  }

  Widget _buildState(BuildContext context) {
    return controller.state.when(
      initial: _buildLoading,
      error: _buildError,
      loaded: _buildLoaded,
    );
  }

  Widget _buildLoaded(QuizScreen screen) {
    final content = Container(
      padding: const EdgeInsets.all(16),
      decoration: BackgroundDecoration.red(),
      child: _buildContent(screen),
    );

    final body =
        screen.hasRootScroll ? SingleChildScrollView(child: content) : content;

    return _buildScaffold(
      title: screen.title,
      closeIsVisible: screen.close.closeIsVisible,
      child: body,
    );
  }

  Widget _buildLoading() {
    return _buildScaffold(
      title: 'Verificação', // have loading only in account verification
      child: PageProgressIndicator(
        progressState: PageProgressState.loading,
        progressMessage: "Carregando...",
        child: Container(),
      ),
    );
  }

  Widget _buildError(error) {
    return _buildScaffold(
      title: 'Verificação', // have loading only in account verification
      child: SupportCenterGeneralError(
        message: extractErrorMessage(error),
        onPressed: controller.retry,
      ),
    );
  }

  Widget _buildScaffold({
    required String title,
    bool closeIsVisible = true,
    required Widget child,
  }) {
    return WillPopScope(
      onWillPop: controller.close,
      child: Scaffold(
        appBar: ThemedAppBar(
          title: title,
          leading: closeIsVisible
              ? IconButton(
                  icon: Icon(Icons.close),
                  tooltip: 'Sair',
                  onPressed: () {
                    controller.close();
                  },
                )
              : Container(),
        ),
        body: child,
      ),
    );
  }

  Widget _buildContent(QuizScreen screen) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 40),
        QuizProgressIndicator(
          value: screen.progress,
        ),
        ...resolveWidgets(screen.rows),
        SizedBox(height: 26),
        Center(
          child: RoundedLoadingButton(
            child: Text(
              screen.reply.label,
              style: Theme.of(context)
                  .textTheme
                  .button
                  ?.copyWith(color: Colors.white),
            ),
            borderRadius: 10.0,
            color: screen.reply.getColor(context),
            controller: _btnController,
            onPressed: controller.sendAnswer,
          ),
        ),
      ],
    );
  }

  List<Widget> resolveWidgets(List<Tile> tiles) =>
      tiles.map<Widget>((e) => Modular.getBindParameterized(e)).toList();
}

extension AnswerStyle on ButtonQuizAnswer {
  Color getColor(BuildContext context) {
    if (style == ButtonQuizAnswerStyle.secondary)
      return Color.fromARGB(255, 60, 60, 59);
    return Theme.of(context).primaryColor;
  }
}
