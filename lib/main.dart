import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:round_6_puzzle/controllers/game_controller.dart';
import 'package:round_6_puzzle/pages/home_page.dart';
import 'package:round_6_puzzle/repository/records_repository.dart';
import 'package:round_6_puzzle/theme.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();

  runApp(MultiProvider(
    providers: [
      Provider<RecordsRepository>(create: (_) => RecordsRepository()),
      ProxyProvider<RecordsRepository, GameController>(
          update: (_, repo, __) => GameController(recordsRepository: repo)),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Round 6 Memory',
      theme: Round6Theme.theme,
      home: const HomePage(),
    );
  }
}
