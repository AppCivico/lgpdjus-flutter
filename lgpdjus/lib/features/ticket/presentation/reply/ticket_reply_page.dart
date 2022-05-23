import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:lgpdjus/app/shared/design_system/theme.dart';
import 'package:lgpdjus/app/shared/navigation/navigator.dart';
import 'package:lgpdjus/app/shared/widgets/appbar/appbar.dart';
import 'package:lgpdjus/app/shared/widgets/card/card.dart';
import 'package:lgpdjus/common/extensions/xfile.dart';
import 'package:lgpdjus/common/widgets/snackbar.dart';
import 'package:lgpdjus/core/di/widget_module.dart';
import 'package:lgpdjus/features/ticket/domain/entities/ticket_screen.dart';
import 'package:lgpdjus/features/ticket/presentation/reply/ticket_reply_controller.dart';
import 'package:mobx/mobx.dart';

class TicketReplyPage extends StatefulWidget {
  TicketReplyPage(this.data, {Key? key}) : super(key: key);

  final TicketPendency data;

  @override
  _TicketReplyPageState createState() => _TicketReplyPageState();
}

class _TicketReplyPageState
    extends ModularWidgetState<TicketReplyPage, TicketReplyController>
    with SnackBarHandler {
  XFile? picture;
  String input = '';
  ReactionDisposer? _disposer;

  @override
  void initState() {
    super.initState();
    if (_disposer == null || _disposer?.reaction.isDisposed == true) {
      _disposer = autorun(
        (_) {
          controller.reaction?.when(showError: (error) {
            showSnackBarError(error);
          }, done: () {
            Navigator.pop(context, true);
          });
        },
      );
    }
  }

  @override
  void dispose() {
    _disposer?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var themeData = BlueThemeFactory().of(context);
    return Theme(
      data: themeData,
      child: _buildScaffold(),
    );
  }

  Widget _buildScaffold() {
    return Scaffold(
      appBar: ThemedAppBar(title: widget.data.title),
      body: Observer(builder: (BuildContext context) {
        final loading = controller.state.maybeMap(
          orElse: () => null,
          loading: (_) => PageProgressIndicator(
            progressState: PageProgressState.loading,
            progressMessage: "Enviando...",
            child: Container(),
          ),
        );
        return Stack(children: [
          _buildBody(context),
          if (loading != null) loading,
        ]);
      }),
    );
  }

  Widget _buildBody(BuildContext context) {
    final themeData = Theme.of(context);
    final content = Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 8),
          SvgPicture.asset('assets/images/svg/ticket/warning_rounded.svg'),
          Text(
            widget.data.description,
            textAlign: TextAlign.center,
            style: themeData.textTheme.subtitle1?.copyWith(
              color: themeData.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Flexible(
            child: RoundedCard(
              child: Container(
                margin: EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: _buildTextField(),
                    ),
                    SizedBox(height: 8),
                    _buildActions(themeData),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
    return SingleChildScrollView(child: content);
  }

  Widget _buildActions(ThemeData themeData) {
    VoidCallback? onPressed;
    if (picture != null || input.isNotEmpty)
      onPressed = () => controller.sendReply(picture, input);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (picture == null)
          IconTextButton(
            text: 'Fotografar',
            icon: Icons.camera_alt_outlined,
            iconColor: themeData.primaryColor,
            onPressed: _takePicture,
          )
        else
          IconTextButton(
            text: 'Remover foto',
            icon: Icons.close,
            iconColor: themeData.primaryColor,
            onPressed: _clearPicture,
          ),
        ElevatedButton(
          child: Text('Enviar'),
          onPressed: onPressed,
        ),
      ],
    );
  }

  Widget _buildTextField() {
    return Container(
      constraints: BoxConstraints(maxHeight: 200),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Escreva sua resposta',
        ),
        maxLines: null,
        onChanged: (v) {
          setState(() {
            input = v;
          });
        },
      ),
    );
  }

  _takePicture() async {
    final XFile? image = await AppNavigator.pushNamedIfExists('/take_picture');
    setState(() {
      picture = image;
    });
  }

  _clearPicture() {
    picture?.delete();
    setState(() {
      picture = null;
    });
  }
}

class IconTextButton extends TextButton {
  IconTextButton({
    required VoidCallback onPressed,
    required String text,
    required IconData icon,
    Color? iconColor,
  }) : super(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: iconColor,
              ),
              SizedBox(width: 4),
              Text(text),
            ],
          ),
          onPressed: onPressed,
        );
}
