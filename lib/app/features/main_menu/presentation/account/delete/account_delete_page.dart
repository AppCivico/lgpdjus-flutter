import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/password_text_input.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:lgpdjus/app/features/common/presentation/support_center_general_error.dart';
import 'package:lgpdjus/app/features/main_menu/domain/states/profile_delete_state.dart';
import 'package:lgpdjus/app/shared/design_system/button_shape.dart';
import 'package:lgpdjus/app/shared/design_system/colors.dart';
import 'package:lgpdjus/app/shared/widgets/appbar/appbar.dart';
import 'package:mobx/mobx.dart';

import 'account_delete_controller.dart';

class AccountDeletePage extends StatefulWidget {
  const AccountDeletePage({Key? key}) : super(key: key);

  @override
  _AccountDeletePageState createState() => _AccountDeletePageState();
}

class _AccountDeletePageState
    extends ModularState<AccountDeletePage, AccountDeleteController>
    with SnackBarHandler {
  final textController = TextEditingController();
  List<ReactionDisposer>? _disposers;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      reaction((_) => controller.errorMessage, (String message) {
        showSnackBar(scaffoldKey: _scaffoldKey, message: message);
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: ThemedAppBar(
        title: "Desativar conta",
      ),
      body: Observer(
        builder: (context) => bodyBuilder(controller.state),
      ),
    );
  }

  @override
  void dispose() {
    _disposers?.forEach((d) => d());
    super.dispose();
  }
}

extension _PageBuilder on _AccountDeletePageState {
  Widget bodyBuilder(ProfileDeleteState state) {
    return state.when(
      initial: () => bodyLoading(),
      loaded: (msg) => bodyLoaded(msg),
      error: (msg) => SupportCenterGeneralError(
        message: msg,
        onPressed: controller.retry,
      ),
    );
  }

  Widget bodyLoading() {
    return SafeArea(
      child: PageProgressIndicator(
        progressMessage: 'Carregando...',
        progressState: PageProgressState.loading,
        child: Container(color: DesignSystemColors.systemBackgroundColor),
      ),
    );
  }

  Widget bodyLoaded(String bodyMessage) {
    return SafeArea(
      child: PageProgressIndicator(
        progressMessage: "Processando...",
        progressState: controller.progressState,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Desativar conta",
                  style: titleTextStyle,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: HtmlWidget(
                    bodyMessage,
                    webViewJs: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: PasswordInputField(
                    labelText: 'Digite a senha atual',
                    errorText: "",
                    onChanged: (password) {
                      textController.text = password;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  child: Center(
                    child: SizedBox(
                      height: 40,
                      width: 250,
                      child: RaisedButton(
                        onPressed: () => controller.delete(textController.text),
                        elevation: 0,
                        color: DesignSystemColors.blue1,
                        child: Text("Desativar conta", style: buttonTextStyle),
                        shape: kButtonShapeOutlinePurple,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension _TextStyle on _AccountDeletePageState {
  TextStyle get titleTextStyle => TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      );

  TextStyle get buttonTextStyle => TextStyle(
        color: Colors.white,
      );
}
