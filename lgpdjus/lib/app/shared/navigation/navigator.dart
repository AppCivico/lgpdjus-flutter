import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lgpdjus/app/shared/logger/log.dart';
import 'package:lgpdjus/app/shared/navigation/route.dart';
import 'package:url_launcher/url_launcher.dart';

typedef bool PopUntilPredicate(String? route);

class AppNavigator {
  static void popAndPush(AppRoute route) {
    Modular.to
        .popAndPushNamed(route.path, arguments: route.args)
        .catchError(catchErrorLogger);
  }

  static Future<void> push(AppRoute route) {
    return Modular.to
        .pushNamed(route.path, arguments: route.args)
        .catchError(catchErrorLogger);
  }

  static Future<void> pushAndRemoveUntil(
    String path,
    String removeUntil, {
    dynamic args,
  }) async {
    await popUntil(material.ModalRoute.withName(removeUntil)).then(
      (lastPath) async {
        if (path == lastPath) {
          return null;
        }
        if (removeUntil != lastPath) {
          return await Modular.to.pushReplacementNamed(path, arguments: args);
        }
        return await Modular.to.pushNamed(path, arguments: args);
      },
    ).catchError(catchErrorLogger);
  }

  static bool pop() {
    if (Modular.to.canPop()) {
      Modular.to.pop();
      return true;
    }
    return false;
  }

  static Future<void> popOrNavigateToHome() async {
    if (!pop()) {
      await pushAndRemoveUntil("/mainboard/", "/");
    }
  }

  static void popAuthentication() {
    popUntil(
      (route) => route.settings.name?.startsWith("/authentication") != true,
    );
  }

  static Future<String?> popUntil(RoutePredicate predicate) async {
    Route? lastRoute;
    Modular.to.popUntil(
      (route) {
        lastRoute = lastRoute ?? route;
        return !route.willHandlePopInternally &&
            (!Modular.to.canPop() || predicate(route));
      },
    );
    return lastRoute?.settings.name;
  }

  static Future<T?> pushNamedIfExists<T extends Object?>(
    String path, {
    dynamic args,
  }) =>
      Modular.to
          .pushNamed<T>(path, arguments: args)
          .catchError(catchErrorLogger);

  static void popAndPushNamedIfExists(String path, {dynamic args}) {
    pop();
    Modular.to.pushNamed(path, arguments: args).catchError(catchErrorLogger);
  }

  static void pushLogin() {
    Modular.to.pushNamed("/authentication").catchError(catchErrorLogger);
  }

  static bool isUrl(String url) {
    return url.startsWith(RegExp(r'https?:\/\/'));
  }

  static Future<void> popAndLaunchUrl(String url) async {
    launchUrl(url);
    pop();
  }

  static Future<void> launchUrl(String url) async {
    if (await canLaunch(url)) {
      launch(url);
    } else {
      error("Can't launch url `$url`");
    }
  }
}
