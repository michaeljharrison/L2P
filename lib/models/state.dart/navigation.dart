import 'package:mobx/mobx.dart';

// Include generated file
part 'navigation.g.dart';

// This is the class used by rest of your codebase
class Navigation = _Navigation with _$Navigation;

// The store-class
abstract class _Navigation with Store {
  @observable
  String selectedGame;

  @action
  void setGame(String newGame) {
    selectedGame = newGame;
  }
}
