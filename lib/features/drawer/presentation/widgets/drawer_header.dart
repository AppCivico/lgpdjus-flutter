import 'package:flutter/material.dart';
import 'package:lgpdjus/common/domain/titles/entity.dart';
import 'package:lgpdjus/features/drawer/domain/entities.dart';
import 'package:lgpdjus/features/drawer/presentation/widgets/drawer_header_title.dart';

typedef OnTap(Actionable action);

class DrawerAccountHeader extends StatelessWidget {
  DrawerAccountHeader({required this.item, required this.onTap});

  final MenuHeader item;
  final OnTap onTap;

  @override
  Widget build(BuildContext context) {
    return DrawerHeaderTitle(
      title: item.title,
      status: item.status,
      padding: EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 8),
    );
  }
}
