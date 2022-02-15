import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:hive/hive.dart';
import 'package:round_6_puzzle/models/game_play.dart';

import '../constants.dart';

part 'records_repository.g.dart';

class RecordsRepository = RecordsRepositoryBase with _$RecordsRepository;

abstract class RecordsRepositoryBase with Store {
  late final Box _records;
  late final GamePlay gamePlay;
  @observable
  Map recordsRound6 = {};
  @observable
  Map recordsNormal = {};

  RecordsRepositoryBase() {
    _initRepository();
  }

  _initRepository() async {
    await _initDatabase();
    await loadRecords();
  }

  _initDatabase() async {
    _records = await Hive.openBox('gameRecords');
  }

  @action
  loadRecords() {
    recordsNormal = _records.get(Mode.normal.toString()) ?? {};
    recordsRound6 = _records.get(Mode.round6.toString()) ?? {};
  }

  updateRecords({required GamePlay gamePlay, required int score}) {
    final key = gamePlay.mode.toString();

    if (gamePlay.mode == Mode.normal &&
        (recordsNormal[gamePlay.level] == null ||
            score < recordsNormal[gamePlay.level])) {
      recordsNormal[gamePlay.level] = score;
      _records.put(key, recordsNormal);
    } else if (gamePlay.mode == Mode.round6 &&
        (recordsRound6[gamePlay.level] == null ||
            score > recordsRound6[gamePlay.level])) {
      recordsRound6[gamePlay.level] = score;
      _records.put(key, recordsRound6);
    }
  }
}
