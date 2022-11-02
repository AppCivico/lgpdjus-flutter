import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lgpdjus/app/app_module.dart';
import 'package:lgpdjus/app/app_widget.dart';
import 'package:lgpdjus/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Future.wait([
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(kDebugMode),
    FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(kDebugMode),
  ]);

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  EquatableConfig.stringify = true;

  runZonedGuarded(() async {
    runApp(
      ModularApp(
        module: AppModule(),
        child: AppWidget(),
        // notAllowedParentBinds: true,
      ),
    );
  }, FirebaseCrashlytics.instance.recordError);
}
