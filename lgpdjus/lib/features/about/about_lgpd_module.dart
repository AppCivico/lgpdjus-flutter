import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lgpdjus/core/di/bind.dart';
import 'package:lgpdjus/core/di/feature_module.dart';
import 'package:lgpdjus/features/about/data/datasource/about_lgpd_datasource.dart';
import 'package:lgpdjus/features/about/data/mapper/about_lgpd_mapper.dart';
import 'package:lgpdjus/features/about/data/repository/about_lgpd_repository.dart';
import 'package:lgpdjus/features/about/domain/entity/details_screen.dart';
import 'package:lgpdjus/features/about/domain/entity/topics_screen.dart';
import 'package:lgpdjus/features/about/domain/repository/about_lgpd_repository.dart';
import 'package:lgpdjus/features/about/domain/usecases/about_lgpd_usecases.dart';
import 'package:lgpdjus/features/about/presentation/lgpd/details/details_controller.dart';
import 'package:lgpdjus/features/about/presentation/lgpd/details/details_page.dart';
import 'package:lgpdjus/features/about/presentation/lgpd/details/widgets/collapsed_content_widget.dart';
import 'package:lgpdjus/features/about/presentation/lgpd/details/widgets/footer_widget.dart';
import 'package:lgpdjus/features/about/presentation/lgpd/details/widgets/header_widget.dart';
import 'package:lgpdjus/features/about/presentation/lgpd/topics/topics_controller.dart';
import 'package:lgpdjus/features/about/presentation/lgpd/topics/topics_page.dart';
import 'package:lgpdjus/features/about/presentation/lgpd/topics/widgets/card_widget.dart';
import 'package:lgpdjus/features/about/presentation/lgpd/topics/widgets/introduction_widget.dart';
import 'package:lgpdjus/features/about/presentation/lgpd/topics/widgets/link_button_widget.dart';
import 'package:lgpdjus/features/about/presentation/lgpd/topics/widgets/section_title_widget.dart';

class AboutLgpdModule extends Module with FeatureModule {
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/lgpd',
          child: (_, args) => TopicsPage(),
        ),
        ChildRoute(
          '/lgpd/tutorial',
          child: (_, args) => TopicsPage(),
        ),
        ChildRoute(
          '/lgpd/:id',
          child: (_, args) => DetailsPage(title: args.data),
        ),
      ];

  @override
  final List<Bind> presentationBinds = [
    Bind.factory((i) => TopicsController(i())),
    Bind.factory((i) => DetailsController(i.args?.params["id"], i())),

    // Tile Widgets
    BindParameterized<IntroductionTile, Widget>(
      (param, i) => IntroductionWidget(param),
    ),
    BindParameterized<SectionTitleTile, Widget>(
      (param, i) => SectionTitleWidget(param),
    ),
    BindParameterized<CardTile, Widget>(
      (param, i) => CardWidget(param),
    ),
    BindParameterized<HeaderTile, Widget>(
      (param, i) => HeaderWidget(param),
    ),
    BindParameterized<FooterTile, Widget>(
      (param, i) => FooterWidget(param),
    ),
    BindParameterized<CollapsedContentTile, Widget>(
      (param, i) => CollapsedContentWidget(param),
    ),
    BindParameterized<LinkButtonTile, Widget>(
      (param, i) => LinkButtonWidget(param),
    ),
  ];

  @override
  List<Bind<Object>> get domainBinds => [
        Bind.factory((i) => GetTopicsUseCase(i())),
        Bind.factory((i) => GetDetailsUseCase(i())),
      ];

  @override
  List<Bind<Object>> get dataBinds => [
        Bind.lazySingleton<AboutLgpdRepository>(
          (i) => AboutLgpdRepositoryImpl(i(), i(), i()),
        ),
        Bind.factory((i) => AboutLgpdDataSource(i())),
        Bind.factory((i) => TopicsScreenMapper()),
        Bind.factory((i) => DetailsScreenMapper()),
      ];
}
