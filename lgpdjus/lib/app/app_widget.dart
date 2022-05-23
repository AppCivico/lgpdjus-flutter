import 'package:asuka/asuka.dart' as asuka;
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lgpdjus/app/shared/design_system/theme.dart';

class AppWidget extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    analytics.setAnalyticsCollectionEnabled(!kDebugMode);
    return MaterialApp(
      title: 'LGPDjus',
      debugShowCheckedModeBanner: false,
      theme: ThemeFactory.main.of(context),
      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      navigatorObservers: [observer],
      supportedLocales: [
        const Locale('pt', "BR"),
      ],
      builder: asuka.builder,
    ).modular();
  }
}
