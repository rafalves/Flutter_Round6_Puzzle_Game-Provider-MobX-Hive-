import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:round_6_puzzle/constants.dart';
import 'package:round_6_puzzle/controllers/game_controller.dart';
import 'package:round_6_puzzle/game_settings.dart';
import 'package:round_6_puzzle/models/game_option.dart';
import 'package:round_6_puzzle/models/game_play.dart';
import 'package:round_6_puzzle/wigets/feedback_game.dart';
import 'package:round_6_puzzle/wigets/game_score.dart';

import '../wigets/card_game.dart';

class GamePage extends StatelessWidget {
  final GamePlay gamePlay;
  const GamePage({
    Key? key,
    required this.gamePlay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GameController>(context);
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: GameScore(
              mode: gamePlay.mode,
            )),
        body: Observer(builder: (_) {
          if (controller.win) {
            return const FeedbackGame(result: Result.approved);
          } else if (controller.lose) {
            return const FeedbackGame(result: Result.eliminated);
          } else {
            return Center(
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: GameSettings.gameBoardAxisCount(gamePlay.level),
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                padding: const EdgeInsets.all(24),
                children: controller.gameCards
                    .map(
                      (GameOption go) =>
                          CardGame(mode: gamePlay.mode, gameOption: go),
                    )
                    .toList(),
              ),
            );
          }
        }));
  }
}
