import 'package:flutter_modular/flutter_modular.dart';
import 'package:lgpdjus/app/features/main_menu/presentation/account/my_profile/profile_edit_controller.dart';
import 'package:lgpdjus/app/features/main_menu/presentation/account/my_profile/profile_edit_page.dart';
import 'package:lgpdjus/app/features/main_page.dart';
import 'package:lgpdjus/app/features/mainboard/presentation/notification_action_controller.dart';
import 'package:lgpdjus/features/about/about_lgpd_module.dart';
import 'package:lgpdjus/features/about/presentation/app/about_app_page.dart';
import 'package:lgpdjus/features/notification/data/repositories/notification_repository.dart';
import 'package:lgpdjus/features/notification/presentation/notification_controller.dart';
import 'package:lgpdjus/features/notification/presentation/notification_page.dart';
import 'package:lgpdjus/features/ticket/ticket_module.dart';

class MainBoardModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (_, args) => MainBoardPage(),
        ),
        ModuleRoute(
          '/about',
          module: AboutLgpdModule(),
          transition: TransitionType.rightToLeft,
        ),
        ModuleRoute(
          '/tickets',
          module: TicketModule(),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/notifications',
          child: (_, args) => NotificationPage(),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/menu/about',
          child: (context, args) => AboutAppPage(),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/menu/profile_edit',
          child: (context, args) => ProfileEditPage(),
          transition: TransitionType.rightToLeft,
        ),
      ];

  @override
  List<Bind> get binds => [
        Bind<INotificationRepository>(
          (i) => NotificationRepository(
            apiProvider: i.get(),
            authObserver: i.get(),
          ),
        ),
        Bind(
          (i) => NotificationController(
            notificationRepository: i.get(),
          ),
        ),
        Bind(
          (i) => ProfileEditController(i(), i()),
        ),
        Bind.factory(
          (i) => NotificationActionController(i()),
        )
      ];
}
