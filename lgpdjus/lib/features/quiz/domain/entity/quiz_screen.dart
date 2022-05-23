import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:lgpdjus/common/domain/titles/entity.dart';
import 'package:lgpdjus/features/quiz/domain/entity/quiz_answer.dart';

@immutable
class QuizScreen {
  const QuizScreen({
    required this.title,
    required this.progress,
    required this.rows,
    required this.reply,
    this.close = const CloseQuizAnswer(),
    this.hasRootScroll = false,
  })  : assert(progress >= 0),
        assert(progress <= 1);

  final String title;
  final double progress;
  final List<Tile> rows;
  final ButtonQuizAnswer reply;
  final CloseQuizAnswer close;
  final bool hasRootScroll;
}

@immutable
class TextTile extends Tile {
  const TextTile({
    required this.text,
    this.marginTop = 24,
  });

  final String text;
  final double marginTop;

  @override
  List<Object?> get props => [text];
}

enum BoxTileStyle { shadowed, bordered }

@immutable
class BoxTile extends Tile {
  const BoxTile({
    required this.rows,
    required this.style,
    this.marginTop = 24,
  });

  final BoxTileStyle style;
  final List<Tile> rows;
  final double marginTop;

  factory BoxTile.shadowed({required List<Tile> rows}) =>
      BoxTile(rows: rows, style: BoxTileStyle.shadowed);

  factory BoxTile.bordered({required List<Tile> rows}) =>
      BoxTile(rows: rows, style: BoxTileStyle.bordered);

  @override
  List<Object?> get props => [style, rows];
}

@immutable
class SpaceTile extends Tile {
  const SpaceTile({this.height: 24});

  final double height;

  @override
  List<Object?> get props => [height];
}

@immutable
class EditTextTile extends Tile {
  const EditTextTile({required this.reference});

  final String reference;

  @override
  List<Object?> get props => [reference];
}

@immutable
class CpfEditTextTile extends EditTextTile {
  const CpfEditTextTile({required String reference})
      : super(reference: reference);
}

@immutable
class BirthdayEditTextTile extends EditTextTile {
  const BirthdayEditTextTile({required String reference})
      : super(reference: reference);
}

@immutable
class RadioTile extends Tile {
  const RadioTile({required this.reference, required this.options})
      : assert(options.length > 0);

  final String reference;
  final List<Option> options;

  @override
  List<Object?> get props => [reference, options];
}

@immutable
class CheckboxTile extends Tile {
  const CheckboxTile({required this.reference, required this.options})
      : assert(options.length > 0);

  final String reference;
  final List<Option> options;

  @override
  List<Object?> get props => [reference, options];
}

@immutable
class Option extends Equatable {
  const Option({required this.label, required this.value});

  final String label;

  final String value;

  @override
  List<Object?> get props => [label, value];
}

@immutable
class HtmlTile extends Tile {
  const HtmlTile({required this.content});

  final String content;

  @override
  List<Object?> get props => [content];
}
