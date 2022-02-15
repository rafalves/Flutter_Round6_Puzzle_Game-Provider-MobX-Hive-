import 'package:flutter/material.dart';
import 'package:round_6_puzzle/constants.dart';
import 'package:round_6_puzzle/game_settings.dart';
import 'package:round_6_puzzle/models/game_play.dart';

import '../wigets/card_level.dart';

class LevelPage extends StatelessWidget {
  final Mode mode;
  const LevelPage({Key? key, required this.mode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final levels = GameSettings.levels
        .map((level) => CardLevel(gamePlay: GamePlay(mode: mode, level: level)))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game level'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 48),
        child: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          padding: const EdgeInsets.all(24),
          children: levels,
        ),
      ),
    );
  }
}
