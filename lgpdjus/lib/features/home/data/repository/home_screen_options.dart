import 'package:lgpdjus/app/shared/design_system/theme.dart';
import 'package:lgpdjus/common/domain/titles/entity.dart';
import 'package:lgpdjus/features/home/data/know_lgpd_action.dart';
import 'package:lgpdjus/features/home/domain/entities.dart';
import 'package:lgpdjus/features/home/domain/repositories/screen_options.dart';

class HomeScreenOptionsRepository extends ScreenOptionsRepository {
  @override
  Future<Screen> get() async {
    return Screen(
      title: "O que você gostaria de fazer no aplicativo LGPDjus?",
      options: [
        Option(
          text: "Meus Dados Pessoais",
          action: NavData(
            '/mainboard/tickets/available',
            data: RedThemeFactory(),
          ),
          theme: RedThemeFactory(),
        ),
        Option(
          text: "Conhecer sobre o uso da LGPD",
          action: KnowLgpdAction(),
          theme: OrangeThemeFactory(),
        ),
        Option(
          text: "Acompanhar as minhas solicitações",
          action: NavData('/mainboard/tickets/my', data: BlueThemeFactory()),
          theme: BlueThemeFactory(),
        ),
      ],
    );
  }
}
