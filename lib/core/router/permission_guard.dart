import 'package:flutter_modular/flutter_modular.dart';
import 'package:lgpdjus/common/domain/titles/entity.dart';
import 'package:lgpdjus/common/widgets/dialog.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionGuard extends RouteGuard with DialogHandler {
  PermissionGuard(this.permissions, this.title, this.description) : super(null);

  final List<Permission> permissions;
  final String title;
  final String description;

  @override
  Future<bool> canActivate(String path, ModularRoute router) async {
    Map<Permission, PermissionStatus> statuses = await permissions.request();
    if (statuses.containsValue(PermissionStatus.permanentlyDenied)) {
      await requestManualPermission();
      return false;
    }
    bool isGranted = statuses.values.fold(
      true,
      (previousValue, element) => previousValue && element.isGranted,
    );
    return isGranted;
  }

  Future requestManualPermission() {
    return showAlertDialog(
      title,
      description,
      NamedAction(
        'Sim',
        Runnable(() {
          openAppSettings();
        }),
      ),
      NamedAction('Não', null),
    );
  }
}

class CameraPermissionGuard extends PermissionGuard {
  CameraPermissionGuard()
      : super(
          [Permission.camera],
          "Câmera bloqueada",
          "O acesso a câmera está bloqueado.\nAgora a autorização precisa ser realizada manualmente.\n\nDeseja permitir o acesso?",
        );
}
