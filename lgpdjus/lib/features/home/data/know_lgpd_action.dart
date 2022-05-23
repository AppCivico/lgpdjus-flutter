import 'package:flutter/foundation.dart';
import 'package:lgpdjus/app/core/managers/app_configuration.dart';
import 'package:lgpdjus/app/shared/design_system/theme.dart';
import 'package:lgpdjus/app/shared/navigation/navigator.dart';
import 'package:lgpdjus/common/domain/titles/entity.dart';
import 'package:lgpdjus/core/di/widget_module.dart';

class KnowLgpdAction implements Runnable {
  KnowLgpdAction();

  final IAppConfiguration _appConfiguration = inject();

  @override
  VoidCallback get run => execute;

  void execute() {
    _appConfiguration.hasPendingLgpdTutorial.then((isPending) {
      AppNavigator.pushNamedIfExists(
        '/mainboard/about/lgpd',
        args: OrangeThemeFactory(),
      );
      if (isPending) {
        AppNavigator.pushNamedIfExists('/tutorial/lgpd');
        _appConfiguration.pendingLgpdTutorial = false;
      }
    });
  }

  @override
  List<Object?> get props => [run];

  @override
  bool? get stringify => true;
}
