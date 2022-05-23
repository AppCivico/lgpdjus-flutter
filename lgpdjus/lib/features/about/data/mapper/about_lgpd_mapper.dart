import 'package:lgpdjus/common/domain/titles/entity.dart';
import 'package:lgpdjus/core/types.dart';
import 'package:lgpdjus/features/about/domain/entity/details_screen.dart';
import 'package:lgpdjus/features/about/domain/entity/topics_screen.dart';

class TopicsScreenMapper {
  TopicsScreen call(JsonObject jsonData) {
    return TopicsScreen(
      items: [
        IntroductionTile(
          content:
              'Para proteger a privacidade e os dados pessoais das pessoas, a LGPD define conceitos e explica o que são dados pessoais, titular dos dados, etc.\n\nEla também define quais são os nossos direitos e quais as obrigações de quem usa nossos dados e informações pessoais',
        ),
        SectionTitleTile(content: 'O que você gostaria de conhecer?'),
        ..._parseItems(jsonData['rows']),
        LinkButtonTile(text: 'Ajuda', action: NavData('/tutorial/lgpd')),
      ],
    );
  }

  List<Tile> _parseItems(JsonList jsonData) {
    return jsonData
        .map(
          (e) => CardTile(
            leading: Uri.parse(e['link_imagem']),
            title: e['nome'],
            description: e['descricao'],
            action:
                NavData("/mainboard/about/lgpd/${e['id']}", data: e['nome']),
          ),
        )
        .toList();
  }
}

class DetailsScreenMapper {
  DetailsScreen call(JsonObject jsonData) {
    return DetailsScreen(items: [
      HeaderTile(
        introduction: jsonData['introducao_linha_1'],
        instruction: jsonData['introducao_linha_2'],
      ),
      ..._parseItems(jsonData['perguntas']),
      FooterTile(content: jsonData['rodape']),
    ]);
  }

  List<Tile> _parseItems(JsonList jsonData) {
    return jsonData
        .map(
          (e) => CollapsedContentTile(
            title: e['pergunta'],
            content: e['resposta'],
          ),
        )
        .toList();
  }
}
