import 'package:flutter/material.dart';
import 'package:lgpdjus/features/tutorial/presentation/tutorial_page_view_widget.dart';
import 'package:lgpdjus/app/shared/design_system/colors.dart';
import 'package:lgpdjus/features/tutorial/presentation/tutorial_page.dart';
import 'package:lgpdjus/features/tutorial/presentation/welcome/space_span.dart';

class WelcomeTutorialPage extends TutorialPage {
  WelcomeTutorialPage()
      : super([
          FirstTutorialPage(),
          SecondTutorialPage(),
          ThirdTutorialPage(),
          FourthTutorialPage(),
          FifthTutorialPage(),
        ]);
}

class FirstTutorialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return TutorialPageViewWidget(
      image: 'assets/images/tutorial/tutorial_0.svg',
      content: TextSpan(
        children: [
          TextSpan(text: 'Olá, tudo bem?', style: textTheme.headline6),
          SpaceSpan.br(),
          TextSpan(
            text:
                'Que ótimo que você instalou o aplicativo LGPDjus do Tribunal de Justiça de Santa Catarina!',
            style: textTheme.bodyText2,
          ),
          SpaceSpan.paragraph(),
          TextSpan(
            text:
                'Aqui você pode consultar, alterar e excluir os dados que o TJSC possui sobre você, além de conhecer mais sobre a proteção de privacidade de dados pessoais.',
            style: textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}

class SecondTutorialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return TutorialPageViewWidget(
      image: 'assets/images/tutorial/tutorial_1.svg',
      content: TextSpan(
        children: [
          TextSpan(
            text:
                '1. Quer entender como usamos suas informações para nossas atividades?',
            style: textTheme.bodyText2,
          ),
          SpaceSpan.br(),
          TextSpan(
            text:
                '2. Quer alterar ou apagar uma informação pessoal armazenada no TJSC?',
            style: textTheme.bodyText2,
          ),
          SpaceSpan.paragraph(),
          TextSpan(
            text: 'O aplicativo LGPDjus TJSC está aqui para te ajudar!',
            style: textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}

class ThirdTutorialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return TutorialPageViewWidget(
      image: 'assets/images/tutorial/tutorial_2.svg',
      content: TextSpan(
        children: [
          TextSpan(
              text: 'Tudo isso de forma simples!', style: textTheme.headline6),
          SpaceSpan.br(),
          TextSpan(
            text: 'O aplicativo é dividido nas cores ',
            style: textTheme.bodyText2,
          ),
          TextSpan(
            text: 'vermelho',
            style: textTheme.bodyText2?.copyWith(color: DesignSystemColors.red),
          ),
          TextSpan(text: ', ', style: textTheme.bodyText2),
          TextSpan(
            text: 'laranja',
            style:
                textTheme.bodyText2?.copyWith(color: DesignSystemColors.orange),
          ),
          TextSpan(text: ' e ', style: textTheme.bodyText2),
          TextSpan(
            text: 'azul',
            style:
                textTheme.bodyText2?.copyWith(color: DesignSystemColors.blue),
          ),
          TextSpan(
            text: ' para facilitar a sua navegação.',
            style: textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}

class FourthTutorialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return TutorialPageViewWidget(
      image: 'assets/images/tutorial/tutorial_3.svg',
      content: TextSpan(
        children: [
          TextSpan(
              text: 'Ficou com dúvida?\nNão se preocupe!',
              style: textTheme.headline6),
          SpaceSpan.br(),
          TextSpan(
            text:
                'Essas informações estarão sempre disponíveis no seu perfil. É só clicar em Tutorial no menu lateral do app.',
            style: textTheme.bodyText2,
          ),
          SpaceSpan.paragraph(),
          TextSpan(
            text:
                'Antes de começar, vamos compartilhar algumas informações importantes com você, tudo bem?',
            style: textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}

class FifthTutorialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return TutorialPageViewWidget(
      image: 'assets/images/tutorial/tutorial_4.svg',
      content: TextSpan(
        children: [
          TextSpan(
            text:
                'O app LGPDjus precisa guardar alguns dados seus para oferecer um melhor atendimento',
            style: textTheme.bodyText1,
          ),
          SpaceSpan.paragraph(),
          TextSpan(
            text:
                'Para saber mais sobre as informações que guardamos e como as utilizamos, não deixe de checar nossa Política de Privacidade. Pode parecer chato, mas é muito importante!',
            style: textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
