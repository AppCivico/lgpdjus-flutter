import 'package:flutter/material.dart';
import 'package:lgpdjus/app/shared/design_system/dimens.dart';
import 'package:lgpdjus/app/shared/widgets/button/rounded_button.dart';
import 'package:lgpdjus/app/shared/widgets/card/card.dart';
import 'package:lgpdjus/common/navigation/action_handler.dart';
import 'package:lgpdjus/core/di/widget_module.dart';
import 'package:lgpdjus/features/home/domain/entities.dart';

typedef void OnOptionClicked(Option option);

class CardOption extends StatelessWidget {
  CardOption(this.option);

  final Option option;
  late final ActionHandler _actionHandler = inject();
  final borderRadius = DesignSystemDimens.cardRadius;

  @override
  Widget build(BuildContext context) {
    final theme = option.theme.of(context);

    return Theme(
      data: theme,
      child: RoundedCard(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: InkWell(
          onTap: () => _actionHandler.handle(option),
          child: Row(
            children: [
              _buildOptionIndicator(theme),
              _buildOptionText(theme, option.text),
              _buildOptionButton(option),
            ],
          ),
        ),
      ),
    );
  }

  // region Card item
  Widget _buildOptionIndicator(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(borderRadius),
        ),
      ),
      child: SizedBox(width: 24, height: 96),
    );
  }

  Widget _buildOptionText(ThemeData theme, String text) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Text(
          text,
          style: theme.textTheme.headline6?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton(Option option) {
    return RoundedButton(
      icon: Icons.arrow_forward_ios_rounded,
      onPressed: () => _actionHandler.handle(option),
    );
  }
}
