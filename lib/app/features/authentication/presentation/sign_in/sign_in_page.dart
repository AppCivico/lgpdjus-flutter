import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/login_button.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:lgpdjus/app/shared/design_system/linear_gradient_design_system.dart';
import 'package:lgpdjus/app/shared/design_system/text_styles.dart';
import 'package:lgpdjus/app/shared/navigation/navigator.dart';
import 'package:lgpdjus/app/shared/widgets/appbar/appbar.dart';
import 'package:mobx/mobx.dart';

import 'sign_in_controller.dart';

class SignInPage extends StatefulWidget {
  final String title;

  const SignInPage({Key? key, this.title = "Authentication"}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends ModularState<SignInPage, SignInController>
    with SnackBarHandler {
  List<ReactionDisposer>? _disposers;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageProgressState _currentState = PageProgressState.initial;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      reaction((_) => controller.errorMessage, (String message) {
        showSnackBar(scaffoldKey: _scaffoldKey, message: message);
      }),
      reaction((_) => controller.currentState, (PageProgressState status) {
        setState(() {
          _currentState = status;
        });
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        decoration: kLinearGradientDesignSystem,
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          appBar: ThemedAppBar(
            title: "Login",
          ),
          body: PageProgressIndicator(
            progressState: _currentState,
            child: SafeArea(
              child: Container(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Center(
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: SvgPicture.asset(
                          "assets/images/logo.svg",
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: RichText(
                        text: TextSpan(
                          text: 'Abertura e acompanhamento de solicitações '
                              'referente a nova legislação de '
                              'proteção de dados pessoais aplicada ao '
                              'Tribunal de Justiça de Santa Catarina.',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: LoginButton(
                          onChanged: () async => controller.login(),
                        ),
                      ),
                    ),
                    Flexible(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyText2,
                          children: [
                            TextSpan(
                              text: 'Ao entrar, você concorda com nosso\n',
                            ),
                            TextSpan(
                              text: 'termo de privacidade',
                              style: kTextStyleFeedTweetShowReply,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  AppNavigator.pushWebView(
                                    title: 'Política de privacidade',
                                    url: '/web/politica-privacidade',
                                  );
                                },
                            ),
                            TextSpan(text: '.'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _disposers?.forEach((d) => d());
    super.dispose();
  }
}
