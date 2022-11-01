import 'dart:io';

import 'package:lgpdjus/common/domain/titles/entity.dart';
import 'package:lgpdjus/features/drawer/domain/entities.dart';
import 'package:lgpdjus/features/drawer/domain/repositories/menu_sections.dart';
import 'package:lgpdjus/features/user/account/domain/user_account_entities.dart';

class DrawerMenuSectionsRepository implements MenuSectionsRepository {
  DrawerMenuSectionsRepository();

  @override
  Future<Menu> getUnauthenticated() async {
    final sections = [
      MenuItem(title: 'Entrar', action: NavData('/authentication')),
      ..._commonSections,
    ];
    return Menu(sections: sections);
  }

  @override
  Future<Menu> getAuthenticated(Account account) async {
    final sections = [
      _getHeaderForAccount(account),
      MenuItem(
        title: 'Minha Conta',
        action: NavData('/mainboard/menu/profile_edit'),
      ),
      ..._commonSections,
      MenuItem(title: 'Sair', action: NavData('/logout')),
    ];
    return Menu(sections: sections);
  }

  MenuHeader _getHeaderForAccount(Account account) {
    if (account.status == AccountStatus.verified)
      return MenuHeader(title: account.fullName, status: account.status);
    return MenuHeaderUnverified(
      title: account.fullName,
      subtitle: 'Faça a verificação da sua conta.',
      action: MenuAction('Validar conta', NavData(account.status.route)),
      status: account.status,
    );
  }

  List<MenuSection> get _commonSections {
    return [
      MenuItem(
        title: 'Site da LGPD no TJSC',
        action: LinkData(
          Uri.parse(
            'https://www.tjsc.jus.br/web/ouvidoria/lei-geral-de-protecao-de-dados-pessoais',
          ),
        ),
      ),
      MenuItem(title: 'Tutorial', action: NavData('/tutorial/welcome')),
      MenuItem(
        title: 'Fale com a Encarregada',
        action: NavData('/web', data: {
          'title': 'Fale com a Encarregada',
          'url': '/web/sobre',
        }),
      ),
      MenuItem(
        title: 'Política de Privacidade',
        action: NavData('/web', data: {
          'title': 'Política de privacidade',
          'url': '/web/politica-privacidade',
        }),
      ),
      MenuItem(
        title: 'Sobre recursos de acessibilidade',
        action: NavData('/web', data: {
          'title': 'Sobre recursos de acessibilidade',
          'url': Platform.isIOS
              ? '/web/acessibilidade-ios'
              : '/web/acessibilidade-android',
        }),
      ),
      MenuItem(
        title: 'Sobre permissões e contas',
        action: NavData('/web', data: {
          'title': 'Sobre permissões e contas',
          'url': '/web/permisoes-e-contas',
        }),
      ),
    ];
  }
}

extension AccountStatusHelper on AccountStatus {
  String get route {
    switch (this) {
      case AccountStatus.unverified:
        return '/account/verify';
      case AccountStatus.processing:
        return '/authentication/verification_in_progress';
      default:
        throw Exception('Get route not allowed');
    }
  }
}
