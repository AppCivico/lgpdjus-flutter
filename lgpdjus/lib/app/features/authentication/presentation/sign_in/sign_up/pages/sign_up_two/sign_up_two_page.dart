import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/input_box_style.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/single_text_input.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:lgpdjus/app/shared/design_system/button_shape.dart';
import 'package:lgpdjus/app/shared/design_system/colors.dart';
import 'package:lgpdjus/app/shared/design_system/linear_gradient_design_system.dart';
import 'package:lgpdjus/app/shared/design_system/text_styles.dart';
import 'package:mobx/mobx.dart';

import 'sign_up_two_controller.dart';

class SignUpTwoPage extends StatefulWidget {
  final String title;
  const SignUpTwoPage({Key? key, this.title = "SignUpTwo"}) : super(key: key);

  @override
  _SignUpTwoPageState createState() => _SignUpTwoPageState();
}

class _SignUpTwoPageState
    extends ModularState<SignUpTwoPage, SignUpTwoController>
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
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          body: PageProgressIndicator(
            progressState: _currentState,
            child: GestureDetector(
              onTap: () => _handleTap(context),
              onPanDown: (_) => _handleTap(context),
              child: SafeArea(
                  child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _buildHeader(),
                    SizedBox(height: 18.0),
                    _buildSubHeader(),
                    SizedBox(height: 22.0),
                    Observer(builder: (_) => _buildNickName()),
                    SizedBox(height: 24.0),
                    SizedBox(height: 40.0, child: _buildNextButton()),
                  ],
                ),
              )),
            ),
          ),
        ),
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

  RaisedButton _buildNextButton() {
    return RaisedButton(
      onPressed: () => controller.nextStepPressed(),
      elevation: 0,
      color: DesignSystemColors.blue1,
      child: Text(
        "Pr??ximo",
        style: kTextStyleDefaultFilledButtonLabel,
      ),
      shape: kButtonShapeFilled,
    );
  }

  static List<DropdownMenuItem<String>> _buildDataSource(
      List<MenuItemModel> list) {
    return list
        .map(
          (v) => DropdownMenuItem<String>(
            child: Text(v.display),
            value: v.value,
          ),
        )
        .toList();
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

  SizedBox _buildSubHeader() {
    return SizedBox(
      height: 60.0,
      child: Text(
        'Nos conte um pouco mais sobre voc??.',
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

  _handleTap(BuildContext context) {
    if (MediaQuery.of(context).viewInsets.bottom > 0)
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
  }
}
