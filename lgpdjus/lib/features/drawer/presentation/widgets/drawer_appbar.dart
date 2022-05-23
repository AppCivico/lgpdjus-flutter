import 'package:flutter/material.dart';

typedef void OnCloseClicked();

class DrawerAppBar extends AppBar {
  DrawerAppBar(String title, {OnCloseClicked? onCloseClicked})
      : super(
          primary: false,
          title: Text(title),
          centerTitle: false,
          elevation: 0,
          titleSpacing: 40,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(Icons.close),
              onPressed: onCloseClicked,
              iconSize: 28,
            )
          ],
        );
}
