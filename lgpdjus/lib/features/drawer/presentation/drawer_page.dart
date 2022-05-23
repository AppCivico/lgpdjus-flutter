import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lgpdjus/core/di/widget_module.dart';
import 'package:lgpdjus/features/drawer/domain/entities.dart';
import 'package:lgpdjus/features/drawer/presentation/drawer_controller.dart';
import 'package:lgpdjus/features/drawer/presentation/drawer_states.dart';
import 'package:lgpdjus/features/drawer/presentation/widgets/drawer_appbar.dart';
import 'package:lgpdjus/features/drawer/presentation/widgets/drawer_header.dart';

class DrawerPage extends StatefulWidget {
  final String title;

  const DrawerPage({Key? key, this.title = "Menu"}) : super(key: key);

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState
    extends ModularWidgetState<DrawerPage, DrawerMenuController> {
  final int halfAlpha = (255 / 2).round();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final backgroundColor = Color.alphaBlend(
      themeData.primaryColor.withAlpha(halfAlpha),
      Colors.white,
    );

    return Drawer(
      child: Container(
        color: themeData.primaryColor,
        child: SafeArea(
          child: Scaffold(
            appBar: DrawerAppBar(
              widget.title,
              onCloseClicked: () {
                Navigator.pop(context);
              },
            ),
            body: Material(
              color: backgroundColor,
              child: Observer(
                builder: (context) => _handleState(context, controller.state),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _handleState(BuildContext context, DrawerState state) {
    return state.when(
      loading: () => _onLoadingState(),
      loaded: (menu) => _onLoadedState(context, menu),
      error: (error) => _onErrorState(error),
    );
  }

  Widget _onLoadingState() {
    return Container();
  }

  Widget _onErrorState(Error error) {
    return Container();
  }

  Widget _onLoadedState(BuildContext context, Menu menu) {
    final themeData = Theme.of(context);
    final sections = menu.sections;

    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: sections.length,
      itemBuilder: (context, position) => _buildMenuSection(sections[position]),
      separatorBuilder: (context, position) {
        return Divider(
          color: themeData.primaryColor,
          height: 0,
          thickness: 1,
        );
      },
    );
  }

  Widget _buildMenuSection(MenuSection section) {
    if (section is MenuItem) {
      return _buildMenuItem(section);
    }
    if (section is MenuHeader) {
      return _buildMenuHeader(section);
    }
    throw UnsupportedError("Invalid menu section");
  }

  Widget _buildMenuItem(MenuItem item) {
    return ListTile(
      title: Text(item.title),
      onTap: () {
        controller.navigateTo(item);
      },
    );
  }

  Widget _buildMenuHeader(MenuHeader item) {
    return DrawerAccountHeader(item: item, onTap: controller.navigateTo);
  }
}
