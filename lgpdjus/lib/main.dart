import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lgpdjus/app/app_module.dart';
import 'package:lgpdjus/app/app_widget.dart';
import 'package:lgpdjus/core/config.dart';

const _kTestingCrashlytics = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Pass all uncaught errors from the framework to Crashlytics.
  FirebaseCrashlytics.instance
      .setCrashlyticsCollectionEnabled(_kTestingCrashlytics || !kDebugMode);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  EquatableConfig.stringify = true;

  runZonedGuarded(() async {
    final config = await Config.load();
    runApp(
      ModularApp(
        module: AppModule(config),
        child: AppWidget(),
        // notAllowedParentBinds: true,
      ),
    );
  }, FirebaseCrashlytics.instance.recordError);
}
