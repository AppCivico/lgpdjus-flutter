import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/password_text_input.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:lgpdjus/app/shared/design_system/button_shape.dart';
import 'package:lgpdjus/app/shared/design_system/colors.dart';
import 'package:lgpdjus/app/shared/design_system/linear_gradient_design_system.dart';
import 'package:lgpdjus/app/shared/design_system/text_styles.dart';
import 'package:lgpdjus/app/shared/widgets/appbar/appbar.dart';
import 'package:mobx/mobx.dart';

import 'reset_password_three_controller.dart';

class ResetPasswordThreePage extends StatefulWidget {
  final String title;

  const ResetPasswordThreePage({Key? key, this.title = "ResetPasswordThree"})
      : super(key: key);

  @override
  _ResetPasswordThreePageState createState() => _ResetPasswordThreePageState();
}

class _ResetPasswordThreePageState
    extends ModularState<ResetPasswordThreePage, ResetPasswordThreeController>
    with SnackBarHandler {
  List<ReactionDisposer>? _disposers;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageProgressState _currentState = PageProgressState.initial;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      _showProgress(),
      _showErrorMessage(),
    ];
  }

  @override
  void dispose() {
    _disposers?.forEach((d) => d());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        decoration: kLinearGradientDesignSystem,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: ThemedAppBar(title: 'Verificação'),
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: false,
          body: PageProgressIndicator(
            progressState: _currentState,
            child: GestureDetector(
              onTap: () => _handleTap(context),
              onPanDown: (_) => _handleTap(context),
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40)
                      .copyWith(bottom: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 60,
                        child: Text(
                          'Configure uma nova senha',
                          style: kTextStyleRegisterHeaderLabelStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 102,
                            width: 102,
                            child: SvgPicture.asset(
                              'assets/images/svg/reset_password/recovery_password_step_3.svg',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      SizedBox(
                        height: 40,
                        child: Text(
                          'Crie uma senha diferente das anteriores',
                          style: kTextStyleRegisterSubtitleLabelStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 24),
                      Observer(
                        builder: (_) {
                          return _buildPasswordField();
                        },
                      ),
                      SizedBox(height: 24.0),
                      Observer(
                          builder: (_) => _buildConfirmationPasswordField()),
                      SizedBox(height: 24),
                      SizedBox(height: 40.0, child: _buildNextButton()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return PasswordInputField(
      labelText: 'Senha',
      hintText: 'Digite sua nova senha',
      errorText: controller.warningPassword,
      onChanged: controller.setPassword,
    );
  }

  PasswordInputField _buildConfirmationPasswordField() {
    return PasswordInputField(
      labelText: 'Confirmação de senha',
      hintText: 'Digite sua senha novamente',
      errorText: controller.warningConfirmationPassword,
      onChanged: controller.setConfirmationPassword,
    );
  }

  RaisedButton _buildNextButton() {
    return RaisedButton(
      onPressed: () => controller.nextStepPressed(),
      elevation: 0,
      color: DesignSystemColors.blue1,
      child: Text(
        "Salvar",
        style: kTextStyleDefaultFilledButtonLabel,
      ),
      shape: kButtonShapeFilled,
    );
  }

  _handleTap(BuildContext context) {
    if (MediaQuery.of(context).viewInsets.bottom > 0)
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
  }

  ReactionDisposer _showErrorMessage() {
    return reaction((_) => controller.errorMessage, (String message) {
      showSnackBar(scaffoldKey: _scaffoldKey, message: message);
    });
  }

  ReactionDisposer _showProgress() {
    return reaction((_) => controller.currentState, (PageProgressState status) {
      setState(() {
        _currentState = status;
      });
    });
  }
}
