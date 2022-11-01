import 'package:lgpdjus/app/core/error/failures.dart';
import 'package:lgpdjus/app/shared/logger/log.dart';
import 'package:lgpdjus/app/shared/navigation/navigator.dart';

mixin MapFailureMessage {
  final String internetConnectionFailure =
      'O servidor está inacessível, o dispositivo está com acesso à Internet?';
  final String serverFailure =
      "O servidor está com problema neste momento, tente novamente.";
  final String loginNeededFailure = "Você precisa fazer login para acessar.";
  final String authFailed = "Finalize o login utilizando o botão acima.";
  final String genericFailure = "Ops.. ocorreu um erro inesperado.";

  String mapFailureMessage(Object failure, [StackTrace? stack]) {
    if (failure is String) return failure;

    switch (failure.runtimeType) {
      case InternetConnectionFailure:
        return internetConnectionFailure;
      case ServerFailure:
        return serverFailure;
      case ServerSideFormFieldValidationFailure:
        return mapServerSideValidationFailure(
          failure as ServerSideFormFieldValidationFailure,
        );
      case ServerSideSessionFailed:
        AppNavigator.pushLogin();
        return loginNeededFailure;
      case AuthenticationFailed:
        return authFailed;
      default:
        error(failure, stack);
        return genericFailure;
    }
  }

  String mapServerSideValidationFailure(
      ServerSideFormFieldValidationFailure failure) {
    return failure.message;
  }
}
