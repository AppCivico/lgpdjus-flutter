import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:lgpdjus/app/shared/design_system/button_shape.dart';
import 'package:lgpdjus/app/shared/design_system/colors.dart';
import 'package:lgpdjus/app/shared/design_system/linear_gradient_design_system.dart';
import 'package:lgpdjus/app/shared/design_system/text_styles.dart';
import 'package:lgpdjus/app/shared/widgets/appbar/appbar.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mobx/mobx.dart';

import 'reset_password_two_controller.dart';

class ResetPasswordTwoPage extends StatefulWidget {
  final String title;

  const ResetPasswordTwoPage({Key? key, this.title = "ResetPasswordTwo"})
      : super(key: key);

  @override
  _ResetPasswordTwoPageState createState() => _ResetPasswordTwoPageState();
}

class _ResetPasswordTwoPageState
    extends ModularState<ResetPasswordTwoPage, ResetPasswordTwoController>
    with SnackBarHandler {
  List<ReactionDisposer>? _disposers;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageProgressState _currentState = PageProgressState.initial;

  final _maskToken = MaskTextInputFormatter(
    mask: '# # # # # #',
    filter: {"#": RegExp(r'[0-9]')},
  );

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
                        height: 40,
                        child: Text(
                          'Verifique seu e-mail',
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
                              'assets/images/svg/reset_password/recovery_password_step_2.svg',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 46),
                      SizedBox(
                        height: 60,
                        child: Text(
                          'Por favor, digite o código de verificação que enviamos para o e-mail de recuperação.',
                          style: kTextStyleRegisterSubtitleLabelStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 4),
                      Observer(builder: (_) {
                        return _buildInputField(
                          labelText: 'Token',
                          keyboardType: TextInputType.number,
                          onChanged: controller.setToken,
                          onError: controller.warrningToken,
                        );
                      }),
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

  Widget _buildInputField({
    String? labelText,
    String? hintText,
    TextInputType? keyboardType,
    Function(String)? onChanged,
    String? onError,
  }) {
    return TextFormField(
      onChanged: onChanged,
      keyboardType: keyboardType,
      autofocus: true,
      autocorrect: false,
      inputFormatters: [_maskToken],
      textAlign: TextAlign.center,
      textInputAction: TextInputAction.done,
      style: TextStyle(fontSize: 48),
    );
  }

  RaisedButton _buildNextButton() {
    return RaisedButton(
      onPressed: () => controller.nextStepPressed(),
      elevation: 0,
      color: DesignSystemColors.blue1,
      child: Text(
        "Próximo",
        style: kTextStyleDefaultFilledButtonLabel,
      ),
      shape: kButtonShapeFilled,
    );
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

  void _handleTap(BuildContext context) {
    if (MediaQuery.of(context).viewInsets.bottom > 0)
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
  }
}
