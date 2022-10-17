import 'package:http/http.dart' as http;
import 'package:lgpdjus/app/core/extension/http.dart';
import 'package:lgpdjus/core/types.dart';

class AboutLgpdDataSource {
  AboutLgpdDataSource(this._apiClient);

  final http.Client _apiClient;

  Future<JsonObject> getTopics() async {
    final bodyResponse = await _apiClient.get(
      Uri(path: '/sobrelgpd'),
    );
    return bodyResponse.bodyJson;
  }

  Future<JsonObject> getDetails(String topic) async {
    final bodyResponse = await _apiClient.get(
      Uri(path: "/sobrelgpd/$topic"),
    );
    return bodyResponse.bodyJson['sobrelgpd'];
  }
}
