import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  Config(this._env);

  static Map<String, String> get _defaults => {
        "API_BASE_URL": "https://lgpdjus-api.appcivico.com/",
      };

  final Map<String, String> _env;
  late final String apiBaseUrl = _env["API_BASE_URL"]!;

  static Future<Config> load() async {
    if (!kDebugMode) return Config(_defaults);

    return await dotenv
        .load(fileName: 'assets/config/env')
        .then((_) => dotenv.env)
        .catchError((_) => Map<String, String>())
        .then((e) => {..._defaults, ...e})
        .then((e) => Config(e));
  }
}
