// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Navigation on _Navigation, Store {
  final _$selectedGameAtom = Atom(name: '_Navigation.selectedGame');

  @override
  String get selectedGame {
    _$selectedGameAtom.reportRead();
    return super.selectedGame;
  }

  @override
  set selectedGame(String value) {
    _$selectedGameAtom.reportWrite(value, super.selectedGame, () {
      super.selectedGame = value;
    });
  }

  final _$selectedGuideAtom = Atom(name: '_Navigation.selectedGuide');

  @override
  Guide get selectedGuide {
    _$selectedGuideAtom.reportRead();
    return super.selectedGuide;
  }

  @override
  set selectedGuide(Guide value) {
    _$selectedGuideAtom.reportWrite(value, super.selectedGuide, () {
      super.selectedGuide = value;
    });
  }

  final _$_NavigationActionController = ActionController(name: '_Navigation');

  @override
  void setGame(String newGame) {
    final _$actionInfo =
        _$_NavigationActionController.startAction(name: '_Navigation.setGame');
    try {
      return super.setGame(newGame);
    } finally {
      _$_NavigationActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGuide(Guide newGuide) {
    final _$actionInfo =
        _$_NavigationActionController.startAction(name: '_Navigation.setGuide');
    try {
      return super.setGuide(newGuide);
    } finally {
      _$_NavigationActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedGame: ${selectedGame},
selectedGuide: ${selectedGuide}
    ''';
  }
}
