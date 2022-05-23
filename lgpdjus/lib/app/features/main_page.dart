import 'package:flutter/material.dart';
import 'package:lgpdjus/features/home/home_module.dart';
import 'package:lgpdjus/app/features/mainboard/presentation/mainboard_app_bar_page.dart';
import 'package:lgpdjus/features/drawer/drawer_module.dart';

class MainBoardPage extends StatefulWidget {
  final String title;

  const MainBoardPage({Key? key, this.title = "Main"}) : super(key: key);

  @override
  _MainBoardPageState createState() => _MainBoardPageState();
}

class _MainBoardPageState extends State<MainBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainBoardAppBarPage(),
      drawer: DrawerModule(),
      backgroundColor: Colors.white,
      body: HomeModule(),
    );
  }
}
