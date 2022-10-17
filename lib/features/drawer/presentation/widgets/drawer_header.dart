import 'package:flutter/material.dart';
import 'package:lgpdjus/app/shared/design_system/link_button.dart';
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
    final header = item;
    if (header is MenuHeaderUnverified)
      return _buildHeaderForUnverified(header);
    return _buildHeaderDefault(header);
  }

  Widget _buildHeaderDefault(MenuHeader item) {
    return DrawerHeaderTitle(
      title: item.title,
      status: item.status,
      padding: EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 8),
    );
  }

  Widget _buildHeaderForUnverified(MenuHeaderUnverified item) {
    return Container(
      padding: EdgeInsets.only(left: 8, top: 16, bottom: 8, right: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeaderTitle(
            title: item.title,
            status: item.status,
            padding: EdgeInsets.only(left: 8),
          ),
          Container(
            padding: EdgeInsets.only(left: 8, top: 16),
            child: Text(item.subtitle, overflow: TextOverflow.ellipsis),
          ),
          LinkButton(
            text: item.action.name,
            onPressed: () {
              onTap(item.action);
            },
          ),
        ],
      ),
    );
  }
}
