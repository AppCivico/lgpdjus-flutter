import 'package:mobx/mobx.dart';

part 'tutorial_controller.g.dart';

class TutorialController extends _TutorialControllerBase
    with _$TutorialController {
  TutorialController() : super();
}

abstract class _TutorialControllerBase with Store {
  _TutorialControllerBase();
}
