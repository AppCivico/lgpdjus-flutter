import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lgpdjus/app/shared/navigation/navigator.dart';
import 'package:lgpdjus/common/widgets/dialog.dart';
import 'package:lgpdjus/core/di/widget_module.dart';
import 'package:lgpdjus/features/home/domain/entities.dart';
import 'package:lgpdjus/features/home/presentation/home_controller.dart';
import 'package:lgpdjus/features/home/presentation/home_states.dart';
import 'package:lgpdjus/features/home/presentation/widgets/card_option.dart';
import 'package:mobx/mobx.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends ModularWidgetState<HomePage, HomeController>
    with DialogHandler {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final borderRadius = 10.0;

  ReactionDisposer? _reactionDisposer;

  @override
  void initState() {
    super.initState();
    _reactionDisposer ??= reaction((_) => controller.event, _handleEvent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Observer(
        builder: (_) => _handleState(controller.state),
      ),
    );
  }

  @override
  void dispose() {
    _reactionDisposer?.call();
    _reactionDisposer = null;
    super.dispose();
  }

  Widget _handleState(HomeState state) {
    return state.when(
      loading: () => _onLoadingState(),
      loaded: (screen) => _onLoadedState(screen),
      error: (error) => _onErrorState(error),
    );
  }

  void _handleEvent(HomeEvent? event) {
    print(event);
    event?.when(
      showTutorial: () {
        AppNavigator.push(AppRoute('/tutorial/welcome')).then((value) {
          controller.saveCurrentAppVersion();
        });
      },
      showDialog: maybeShowDialog,
    );
  }

  Widget _onLoadingState() {
    return Container();
  }

  Widget _onErrorState(Error error) {
    return Container();
  }

  Widget _onLoadedState(Screen screen) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildTitle(context, screen.title),
        ..._buildOptionItems(context, screen.options)
      ],
    );
  }

  Widget _buildTitle(BuildContext context, String title) {
    return Container(
      child: Container(
        padding: EdgeInsets.only(left: 40, right: 40, bottom: 16),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  List<Widget> _buildOptionItems(BuildContext context, List<Option> options) =>
      options.map((e) => CardOption(e)).toList();
}
