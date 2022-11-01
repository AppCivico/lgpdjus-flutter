import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/logout.dart';
import 'package:lgpdjus/app/shared/logger/log.dart';
import 'package:lgpdjus/app/shared/navigation/navigator.dart';
import 'package:lgpdjus/common/domain/titles/entity.dart';
import 'package:lgpdjus/features/drawer/domain/entities.dart';
import 'package:lgpdjus/features/drawer/domain/usecases/get_menu_sections.dart';
import 'package:lgpdjus/features/drawer/presentation/drawer_states.dart';
import 'package:mobx/mobx.dart';

part 'drawer_controller.g.dart';

class DrawerMenuController extends _DrawerMenuControllerBase
    with _$DrawerMenuController {
  DrawerMenuController(
    GetMenuSectionsUseCase getScreenOptions,
    LogoutUseCase logout,
  ) : super(getScreenOptions, logout);
}

abstract class _DrawerMenuControllerBase with Store {
  _DrawerMenuControllerBase(this._getMenuSections, this._logout) {
    setup();
  }

  final GetMenuSectionsUseCase _getMenuSections;
  final LogoutUseCase _logout;

  @observable
  DrawerState state = DrawerState.loading();

  Future navigateTo(Actionable item) async {
    final action = item.action;
    if (action is LinkData) {
      return AppNavigator.popAndLaunchUrl(action.url);
    }
    if (action is NavData) {
      switch (action.route) {
        case '/logout':
          await _callLogout();
          Modular.to.pop();
          break;
        default:
          AppNavigator.popAndPushNamedIfExists(action.route, args: action.data);
      }
    }
  }

  Future<void> _callLogout() async {
    final logoutUrl = await _logout();
    if (logoutUrl == null) return;

    await FlutterWebAuth.authenticate(
      url: logoutUrl,
      callbackUrlScheme: 'lgpdjus',
    ).catchError(catchErrorLogger);
  }
}

extension _PrivateMethod on _DrawerMenuControllerBase {
  Future<void> setup() async {
    loadData();
  }

  Future<void> loadData() async {
    _getMenuSections().listen(_onSuccess, onError: _onError);
  }

  _onSuccess(Menu menu) {
    state = DrawerState.loaded(menu);
  }

  _onError(Object error, stacktrace) {
    state = DrawerState.error(error as Error);
  }
}
