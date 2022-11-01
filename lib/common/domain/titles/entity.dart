import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class Tile extends Equatable {
  const Tile();
}

abstract class ActionData extends Equatable {}

abstract class Actionable extends Equatable {
  ActionData? get action;

  @override
  List<Object?> get props => [action];
}

class NamedAction extends Actionable {
  NamedAction(this.name, this.action);

  final String name;
  @override
  final ActionData? action;

  @override
  List<Object?> get props => [name, ...super.props];
}

class NavData extends ActionData {
  NavData(this.route, {this.data});

  final String route;
  final dynamic data;

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [route, data];
}

class LinkData extends ActionData {
  LinkData(this.url);

  final Uri url;

  @override
  List<Object?> get props => [];
}

class Runnable extends ActionData {
  Runnable(this.run);

  final VoidCallback run;

  @override
  List<Object?> get props => [run];
}