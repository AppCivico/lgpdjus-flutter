import 'package:lgpdjus/app/shared/navigation/navigator.dart';
import 'package:lgpdjus/common/domain/titles/entity.dart';

abstract class ActionHandler {
  Future navigate(ActionData data);

  Future handle(Actionable action);
}

class DefaultActionHandler implements ActionHandler {
  Future navigate(ActionData action) async {
    if (action is LinkData) {
      return await AppNavigator.launchUrl(action.url);
    }
    if (action is NavData) {
      return await AppNavigator.pushNamedIfExists(
        action.route,
        args: action.data,
      );
    }
    if (action is Runnable) {
      return action.run();
    }
  }

  Future handle(Actionable action) async {
    final actionData = action.action;
    if (actionData != null) {
      return await navigate(actionData);
    }
  }
}
