// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GameController on GameControllerBase, Store {
  Computed<bool>? _$turnCompleteComputed;

  @override
  bool get turnComplete =>
      (_$turnCompleteComputed ??= Computed<bool>(() => super.turnComplete,
              name: 'GameControllerBase.turnComplete'))
          .value;

  final _$gameCardsAtom = Atom(name: 'GameControllerBase.gameCards');

  @override
  List<GameOption> get gameCards {
    _$gameCardsAtom.reportRead();
    return super.gameCards;
  }

  @override
  set gameCards(List<GameOption> value) {
    _$gameCardsAtom.reportWrite(value, super.gameCards, () {
      super.gameCards = value;
    });
  }

  final _$scoreAtom = Atom(name: 'GameControllerBase.score');

  @override
  int get score {
    _$scoreAtom.reportRead();
    return super.score;
  }

  @override
  set score(int value) {
    _$scoreAtom.reportWrite(value, super.score, () {
      super.score = value;
    });
  }

  final _$winAtom = Atom(name: 'GameControllerBase.win');

  @override
  bool get win {
    _$winAtom.reportRead();
    return super.win;
  }

  @override
  set win(bool value) {
    _$winAtom.reportWrite(value, super.win, () {
      super.win = value;
    });
  }

  final _$loseAtom = Atom(name: 'GameControllerBase.lose');

  @override
  bool get lose {
    _$loseAtom.reportRead();
    return super.lose;
  }

  @override
  set lose(bool value) {
    _$loseAtom.reportWrite(value, super.lose, () {
      super.lose = value;
    });
  }

  @override
  String toString() {
    return '''
gameCards: ${gameCards},
score: ${score},
win: ${win},
lose: ${lose},
turnComplete: ${turnComplete}
    ''';
  }
}
