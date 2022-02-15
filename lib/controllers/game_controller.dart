import 'package:mobx/mobx.dart';
import 'package:round_6_puzzle/game_settings.dart';
import 'package:round_6_puzzle/models/game_option.dart';
import 'package:round_6_puzzle/repository/records_repository.dart';

import '../constants.dart';
import '../models/game_play.dart';

part 'game_controller.g.dart';

class GameController = GameControllerBase with _$GameController;

abstract class GameControllerBase with Store {
  @observable
  List<GameOption> gameCards = [];
  @observable
  int score = 0;
  @observable
  bool win = false;
  @observable
  bool lose = false;

  late GamePlay _gamePlay;
  List<GameOption> _chose = [];
  List<Function> _choseCallback = [];
  int _hits = 0;
  int _numPairs = 0;
  RecordsRepository recordsRepository;

  @computed
  bool get turnComplete => (_chose.length == 2);

  GameControllerBase({required this.recordsRepository}) {
    reaction((_) => win == true, (bool win) {
      if (win) {
        recordsRepository.updateRecords(gamePlay: _gamePlay, score: score);
      }
    });
  }

  startGame({required GamePlay gamePlay}) {
    _gamePlay = gamePlay;
    _hits = 0;
    _numPairs = (_gamePlay.level / 2).round();
    win = false;
    lose = false;
    _resetScore();
    _generateCards();
  }

  _resetScore() {
    _gamePlay.mode == Mode.normal ? score = 0 : score = _gamePlay.level;
  }

  _generateCards() {
    List<int> cardOption = GameSettings.cardOptions.sublist(0)..shuffle();
    cardOption = cardOption.sublist(0, _numPairs);
    gameCards = [...cardOption, ...cardOption]
        .map((option) =>
            GameOption(option: option, matched: false, selected: false))
        .toList();
    gameCards.shuffle();
  }

  chose(GameOption option, Function resetCard) async {
    option.selected = true;
    _chose.add(option);
    _choseCallback.add(resetCard);
    await _compareChoices();
  }

  _compareChoices() async {
    if (turnComplete) {
      if (_chose[0].option == _chose[1].option) {
        _hits++;
        _chose[0].matched = true;
        _chose[1].matched = true;
      } else {
        await Future.delayed(const Duration(seconds: 1), () {
          for (var i in [0, 1]) {
            _chose[i].selected = false;
            _choseCallback[i]();
          }
        });
      }

      _resetPlay();
      _updateScore();
      _checkGameResult();
    }
  }

  _checkGameResult() async {
    bool allMatched = _hits == _numPairs;
    if (_gamePlay.mode == Mode.normal) {
      await _checkResultModeNormal(allMatched);
    } else {
      await _checkResultModeRound6(allMatched);
    }
  }

  _checkResultModeNormal(bool allMatched) async {
    await Future.delayed(const Duration(seconds: 1), () => win = allMatched);
  }

  _checkResultModeRound6(bool allMatched) async {
    if (_turnsOver()) {
      await Future.delayed(const Duration(seconds: 1), () => lose = true);
    }
    if (allMatched && score >= 0) {
      await Future.delayed(const Duration(seconds: 1), () => win = allMatched);
    }
  }

  bool _turnsOver() {
    return score < _numPairs - _hits;
  }

  _resetPlay() {
    _chose = [];
    _choseCallback = [];
  }

  _updateScore() {
    _gamePlay.mode == Mode.normal ? score++ : score--;
  }

  restartGame() {
    startGame(gamePlay: _gamePlay);
  }

  nextLevel() {
    int levelIndex = 0;

    if (_gamePlay.level != GameSettings.levels.last) {
      levelIndex = GameSettings.levels.indexOf(_gamePlay.level) + 1;
    }

    _gamePlay.level = GameSettings.levels[levelIndex];
    startGame(gamePlay: _gamePlay);
  }
}
