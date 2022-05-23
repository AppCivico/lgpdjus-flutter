import 'package:flutter/material.dart';
import 'package:lgpdjus/features/tutorial/presentation/tutorial_page_view_widget.dart';
import 'package:lgpdjus/features/tutorial/presentation/tutorial_page.dart';

class LgpdTutorialPage extends TutorialPage {
  LgpdTutorialPage()
      : super([
          FirstTutorialPage(),
          SecondTutorialPage(),
        ]);
}

class FirstTutorialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return TutorialPageViewWidget(
      image: 'assets/images/tutorial/about_lgpd_01.svg',
      content: TextSpan(
          text:
              'A tecnologia e a internet fazem parte do nosso dia a dia. Da rede social que sugere uma amizade, ao site que apresenta uma oportunidade de trabalho, passando pelo aplicativo que aponta o melhor caminho para casa, todos eles têm em comum o mesmo combustível: os nossos dados pessoais.',
          style: textTheme.bodyText2),
    );
  }
}

class SecondTutorialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return TutorialPageViewWidget(
      image: 'assets/images/tutorial/about_lgpd_02.svg',
      content: TextSpan(
          text:
              'Por isso, foi criada a Lei Geral de Proteção de Dados Pessoais (LGPD). Ela entrou em vigor em 2018 e veio com toda a força para proteger os direitos fundamentais de liberdade e de privacidade das pessoas, bem como o livre desenvolvimento de suas personalidades.',
          style: textTheme.bodyText2),
    );
  }
}
