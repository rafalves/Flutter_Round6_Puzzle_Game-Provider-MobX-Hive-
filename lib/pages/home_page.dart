import 'package:flutter/material.dart';
import 'package:round_6_puzzle/pages/level_page.dart';
import 'package:round_6_puzzle/theme.dart';
import 'package:round_6_puzzle/wigets/records.dart';
import 'package:round_6_puzzle/wigets/start_button.dart';

import '../constants.dart';
import '../wigets/logo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Logo(),
            StartButton(
              title: 'Normal Mode',
              color: Colors.white,
              action: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const LevelPage(mode: Mode.normal),
                ),
              ),
            ),
            StartButton(
              title: 'Round 6 Mode',
              color: Round6Theme.color,
              action: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const LevelPage(mode: Mode.round6),
                ),
              ),
            ),
            const SizedBox(height: 60),
            const Records(),
          ],
        ),
      ),
    );
  }
}
