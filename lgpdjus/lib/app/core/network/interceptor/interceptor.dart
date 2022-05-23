import 'package:http/http.dart';

export 'auth.dart';
export 'connection.dart';
export 'failure_handler.dart';
export 'user_agent.dart';

typedef Future<StreamedResponse> Next(BaseRequest request);

abstract class HttpInterceptor {
  Future<StreamedResponse> intercept(BaseRequest request, Next next);
}
