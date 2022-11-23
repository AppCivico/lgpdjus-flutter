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
      MenuHeader(
        title: account.fullName,
        status: account.status,
      ),
      MenuItem(
        title: 'Minha Conta',
        action: NavData('/mainboard/menu/profile_edit'),
      ),
      ..._commonSections,
      MenuItem(title: 'Sair', action: NavData('/logout')),
    ];
    return Menu(sections: sections);
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
          'title': 'Política de Privacidade',
          'url': '/web/politica-privacidade',
        }),
      ),
      MenuItem(
        title: 'Sobre Recursos de Acessibilidade',
        action: NavData('/web', data: {
          'title': 'Sobre Recursos de Acessibilidade',
          'url': Platform.isIOS
              ? '/web/acessibilidade-ios'
              : '/web/acessibilidade-android',
        }),
      ),
      MenuItem(
        title: 'Sobre Permissões e Contas',
        action: NavData('/web', data: {
          'title': 'Sobre Permissões e Contas',
          'url': '/web/permisoes-e-contas',
        }),
      ),
      MenuItem(
        title: "Termos de Uso",
        action: NavData("/terms_of_use"),
      ),
    ];
  }
}
