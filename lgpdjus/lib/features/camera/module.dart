import 'package:flutter_modular/flutter_modular.dart';
import 'package:lgpdjus/features/camera/presentation/page.dart';

class CameraModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (_, args) => CameraPage(args.data),
        ),
      ];
}
