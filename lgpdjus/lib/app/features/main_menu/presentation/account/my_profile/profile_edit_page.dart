import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:lgpdjus/app/features/common/presentation/support_center_general_error.dart';
import 'package:lgpdjus/app/features/main_menu/domain/states/profile_edit_state.dart';
import 'package:lgpdjus/app/features/main_menu/presentation/account/my_profile/profile_edit_controller.dart';
import 'package:lgpdjus/app/features/main_menu/presentation/account/pages/card_profile_email_page.dart';
import 'package:lgpdjus/app/features/main_menu/presentation/account/pages/card_profile_name_page.dart';
import 'package:lgpdjus/app/features/main_menu/presentation/account/pages/card_profile_password_page.dart';
import 'package:lgpdjus/app/features/main_menu/presentation/account/pages/card_profile_single_tile_page.dart';
import 'package:lgpdjus/app/shared/design_system/colors.dart';
import 'package:lgpdjus/app/shared/navigation/navigator.dart';
import 'package:lgpdjus/app/shared/widgets/appbar/appbar.dart';
import 'package:lgpdjus/features/user/account/domain/user_account_entities.dart';
import 'package:mobx/mobx.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState
    extends ModularState<ProfileEditPage, ProfileEditController>
    with SnackBarHandler {
  List<ReactionDisposer>? _disposers;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      reaction((_) => controller.updateError, (String message) {
        showSnackBar(scaffoldKey: _scaffoldKey, message: message);
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: ThemedAppBar(title: 'Minha conta'),
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

extension _PageBuilder on _ProfileEditPageState {
  Widget bodyBuilder(ProfileEditState state) {
    return state.when(
      initial: () => bodyLoading(),
      loaded: (profile) =>
          bodyLoaded(profile),
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

  Widget bodyLoaded(Account profile) {
    return SafeArea(
      child: PageProgressIndicator(
        progressMessage: 'Atualizando...',
        progressState: controller.progressState,
        child: SingleChildScrollView(
          child: Column(
            children: [
              profileHeader(),
              CardProfileNamePage(
                name: profile.nickname,
                onChange: controller.editNickName,
              ),
              CardProfileSingleTilePage(
                title: "Nome completo",
                content: profile.fullName,
                background: DesignSystemColors.systemBackgroundColor,
              ),
              CardProfileEmailPage(
                content: profile.email,
                onChange: controller.updatedEmail,
              ),
              CardProfilePasswordPage(
                content: '************',
                onChange: controller.updatePassword,
              ),
              TextButton(
                child: Text(
                  'Desativar conta',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
                onPressed: () {
                  AppNavigator.pushNamedIfExists('/mainboard/menu/account_delete');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

extension _Modal on _ProfileEditPageState {}

extension _ProfileEditPage on _ProfileEditPageState {
  Widget profileHeader() {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Dados da conta", style: profileHeaderTitleTextStyle)
          ],
        ),
      ),
    );
  }
}

extension _TextStyle on _ProfileEditPageState {
  TextStyle get profileHeaderTitleTextStyle => TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      );
}
