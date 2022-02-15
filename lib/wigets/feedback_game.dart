import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:round_6_puzzle/controllers/game_controller.dart';
import 'package:round_6_puzzle/wigets/start_button.dart';

import '../constants.dart';

class FeedbackGame extends StatelessWidget {
  final Result result;
  const FeedbackGame({Key? key, required this.result}) : super(key: key);

  String getResult() {
    return result == Result.approved ? 'approved' : 'eliminated';
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<GameController>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '${getResult().toUpperCase()}!',
            style: const TextStyle(fontSize: 30),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Image.asset('images/${getResult()}.png'),
          ),
          result == Result.eliminated
              ? StartButton(
                  title: 'Try again',
                  color: Colors.white,
                  action: () => controller.restartGame(),
                )
              : StartButton(
                  title: 'Next level',
                  color: Colors.white,
                  action: () => controller.nextLevel(),
                ),
        ],
      ),
    );
  }
}
