import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lgpdjus/core/di/bind.dart';
import 'package:lgpdjus/core/di/feature_module.dart';
import 'package:lgpdjus/core/di/widget_module.dart';
import 'package:lgpdjus/features/quiz/data/datasource.dart';
import 'package:lgpdjus/features/quiz/data/mapper.dart';
import 'package:lgpdjus/features/quiz/data/repository.dart';
import 'package:lgpdjus/features/quiz/domain/entity.dart';
import 'package:lgpdjus/features/quiz/domain/usecase.dart';
import 'package:lgpdjus/features/quiz/presentation/quiz_controller.dart';
import 'package:lgpdjus/features/quiz/presentation/quiz_page.dart';
import 'package:lgpdjus/features/quiz/presentation/widgets/box_tile.dart';
import 'package:lgpdjus/features/quiz/presentation/widgets/quiz_bithday_edittext.dart';
import 'package:lgpdjus/features/quiz/presentation/widgets/quiz_checkbox_tile.dart';
import 'package:lgpdjus/features/quiz/presentation/widgets/quiz_cpf_edittext.dart';
import 'package:lgpdjus/features/quiz/presentation/widgets/quiz_edittext.dart';
import 'package:lgpdjus/features/quiz/presentation/widgets/quiz_radio_tile.dart';
import 'package:lgpdjus/features/quiz/presentation/widgets/text_tile.dart';

class QuizModule extends ModularWidget with FeatureModule {
  @override
  late final Widget view = QuizPage();

  @override
  final List<Bind> presentationBinds = [
    Bind.lazySingleton<QuizController>(
      (i) => QuizController(startQuizUseCase: i(), closeQuizUseCase: i()),
    ),

    // Tile Widgets
    BindParameterized<BoxTile, Widget>((param, i) => BoxTileWidget(param)),
    BindParameterized<TextTile, Widget>((param, i) => TextTileWidget(param)),
    BindParameterized<CpfEditTextTile, Widget>(
      (param, i) => CpfEditTextTileWidget(param),
    ),
    BindParameterized<BirthdayEditTextTile, Widget>(
      (param, i) => BirthdayEditTextTileWidget(param),
    ),
    BindParameterized<EditTextTile, Widget>(
      (param, i) => EditTextTileWidget(param),
    ),
    BindParameterized<RadioTile, Widget>((param, i) => RadioTileWidget(param)),
    BindParameterized<CheckboxTile, Widget>(
      (param, i) => CheckboxTileWidget(param),
    ),
    BindParameterized<SpaceTile, Widget>(
      (param, i) => SizedBox(height: param.height),
    ),
  ];

  @override
  final List<Bind> domainBinds = [
    Bind.factory((i) => StartQuizUseCase(i())),
    Bind.factory((i) => CloseQuizUseCase(i())),
    Bind.lazySingleton((i) => VerifyAccountUseCase(i())),

    // Answers
    BindTagged<ReplyQuizUseCase<StartQuizAnswer>>(
      StartQuizAnswer,
      (i) => TicketReplyQuizUseCase(i()),
    ),
    BindTagged<ReplyQuizUseCase<InputQuizAnswer>>(
      InputQuizAnswer,
      (i) => InputReplyQuizUseCase(i()),
    ),
    BindTagged<ReplyQuizUseCase<SendPictureQuizAnswer>>(
      SendPictureQuizAnswer,
      (i) => SendPictureReplyQuizUseCase(i(), i()),
    ),
  ];

  @override
  final List<Bind> dataBinds = [
    Bind.lazySingleton<QuizRepository>(
      (i) => QuizRepositoryImpl(i(), i(), i()),
    ),

    // Datasources
    Bind.factory<QuizLocalDataSource>(
      (i) => i.args?.params["id"] != null
          ? TicketQuizDataSource(i.args!.data)
          : i<QuizAppStateDataSource>(),
    ),
    Bind.lazySingleton<QuizAppStateDataSource>(
      (i) => QuizAppStateDataSource(i(), i()),
    ),
    Bind.factory<QuizRemoteDataSource>((i) => i<QuizAppStateDataSource>()),

    // Mapper
    Bind.factory((i) => QuizScreenMapper(i())),
    Bind.factory<List<QuizScreenConverter>>(
      (i) => [
        QuestionnaireConverter(),
        SingleChoiceConverter(),
        MultiChoicesConverter(),
        EditTextConverter(),
        CpfEditTextConverter(),
        BirthdayEditTextConverter(),
        ConfirmationConverter(),
        TakePictureConverter(),
      ],
    ),
  ];
}
