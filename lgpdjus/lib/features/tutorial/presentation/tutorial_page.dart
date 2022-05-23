import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lgpdjus/features/tutorial/presentation/tutorial_controller.dart';

abstract class TutorialPage extends StatefulWidget {
  TutorialPage(this.pages, {Key? key}) : super(key: key);

  final List<Widget> pages;

  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState
    extends ModularState<TutorialPage, TutorialController> {
  late int _qtyPages = widget.pages.length;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.backgroundColor,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: PageView(
                  physics: ClampingScrollPhysics(),
                  children: widget.pages,
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 24.0,
                  right: 24.0,
                  bottom: 16,
                  top: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: _buildPageIndicator()),
                    Row(children: <Widget>[_buildActionButton()]),
                  ],
                ),
              )
            ],
          ),
          SafeArea(
            child: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(Icons.cancel, color: themeData.buttonColor),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          )
        ],
      ),
    );
  }

  SizedBox _buildActionButton() {
    final bool isLastPage = _currentPage == (_qtyPages - 1);
    return SizedBox(
      height: 40.0,
      width: 145.0,
      child: OutlinedButton(
        onPressed: () {
          isLastPage ? _dispose() : _nextPage();
        },
        child: Text(
          isLastPage ? 'Entendi' : 'Próximo',
        ),
      ),
    );
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void _dispose() {
    Navigator.of(context).pop(true);
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _qtyPages; i++) {
      final isActive = i == _currentPage;
      list.add(_indicator(isActive));
    }

    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 10.0,
      width: isActive ? 24.0 : 10.0,
      decoration: BoxDecoration(
        color: isActive
            ? Theme.of(context).focusColor
            : Theme.of(context).indicatorColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
