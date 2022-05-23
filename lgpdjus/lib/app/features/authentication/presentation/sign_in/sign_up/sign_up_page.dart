import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/input_box_style.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/single_text_input.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:lgpdjus/app/shared/design_system/button_shape.dart';
import 'package:lgpdjus/app/shared/design_system/colors.dart';
import 'package:lgpdjus/app/shared/design_system/linear_gradient_design_system.dart';
import 'package:lgpdjus/app/shared/design_system/text_styles.dart';
import 'package:lgpdjus/app/shared/widgets/appbar/appbar.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher.dart';

import 'sign_up_controller.dart';

class SignUpPage extends StatefulWidget {
  final String title;
  const SignUpPage({Key? key, this.title = "SignUp"}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends ModularState<SignUpPage, SignUpController>
    with SnackBarHandler {
  List<ReactionDisposer>? _disposers;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageProgressState _currentState = PageProgressState.initial;

  final format = DateFormat("dd/MM/yyyy");

  final _maskCpf = MaskTextInputFormatter(
    mask: '###.###.###-##',
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
          appBar: ThemedAppBar(title: 'Cadastro'),
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: false,
          body: PageProgressIndicator(
            progressState: _currentState,
            child: GestureDetector(
              onTap: () => _handleTap(context),
              onPanDown: (_) => _handleTap(context),
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40).copyWith(bottom: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _buildHeader(),
                      SizedBox(height: 18.0),
                      _buildSubHeader(),
                      SizedBox(height: 22.0),
                      Observer(builder: (_) => _buildFullName()),
                      SizedBox(height: 24.0),
                      Observer(builder: (_) => _buildCpf()),
                      SizedBox(height: 24.0),
                      Observer(builder: (_) => _buildNickName()),
                      SizedBox(height: 24.0),
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

  SingleTextInput _buildCpf() {
    return SingleTextInput(
      inputFormatter: _maskCpf,
      onChanged: controller.setCpf,
      keyboardType: TextInputType.number,
      boxDecoration: WhiteBoxDecorationStyle(
        hintText: 'CPF',
        labelText: 'CPF',
        errorText: controller.warningCpf,
      ),
    );
  }

  SingleTextInput _buildFullName() {
    return SingleTextInput(
      onChanged: controller.setFullname,
      boxDecoration: WhiteBoxDecorationStyle(
        labelText: 'Nome completo',
        errorText: controller.warningFullname,
      ),
    );
  }

  SingleTextInput _buildNickName() {
    return SingleTextInput(
      keyboardType: TextInputType.text,
      onChanged: controller.setNickname,
      boxDecoration: WhiteBoxDecorationStyle(
        labelText: 'Como deseja ser chamado(a)?',
        errorText: controller.warningNickname,
      ),
    );
  }

  SizedBox _buildSubHeader() {
    return SizedBox(
      height: 40.0,
      child: Text(
        'Etapa 1',
        style: kTextStyleRegisterSubHeaderLabelStyle,
        textAlign: TextAlign.center,
      ),
    );
  }

  Text _buildHeader() {
    return Text(
      'Crie sua conta',
      style: kTextStyleRegisterHeaderLabelStyle,
      textAlign: TextAlign.center,
    );
  }

  void _handleTap(BuildContext context) {
    if (MediaQuery.of(context).viewInsets.bottom > 0)
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
  }

  RaisedButton _buildNextButton() {
    return RaisedButton(
      onPressed: () => controller.nextStepPressed(),
      elevation: 0,
      color: DesignSystemColors.doJus,
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
}
