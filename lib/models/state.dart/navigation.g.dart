// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Navigation on _Navigation, Store {
  final _$selectedGameAtom = Atom(name: '_Navigation.selectedGame');

  @override
  String get selectedGame {
    _$selectedGameAtom.context.enforceReadPolicy(_$selectedGameAtom);
    _$selectedGameAtom.reportObserved();
    return super.selectedGame;
  }

  @override
  set selectedGame(String value) {
    _$selectedGameAtom.context.conditionallyRunInAction(() {
      super.selectedGame = value;
      _$selectedGameAtom.reportChanged();
    }, _$selectedGameAtom, name: '${_$selectedGameAtom.name}_set');
  }

  final _$_NavigationActionController = ActionController(name: '_Navigation');

  @override
  void setGame(String newGame) {
    final _$actionInfo = _$_NavigationActionController.startAction();
    try {
      return super.setGame(newGame);
    } finally {
      _$_NavigationActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'selectedGame: ${selectedGame.toString()}';
    return '{$string}';
  }
}
