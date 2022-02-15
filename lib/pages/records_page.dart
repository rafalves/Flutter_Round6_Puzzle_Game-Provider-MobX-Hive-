import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:round_6_puzzle/repository/records_repository.dart';
import 'package:round_6_puzzle/theme.dart';

import '../constants.dart';

class RecordsPage extends StatelessWidget {
  final Mode mode;

  RecordsPage({
    Key? key,
    required this.mode,
  }) : super(key: key);

  getMode() {
    return mode == Mode.normal ? 'Normal' : 'Round 6';
  }

  List<Widget> getRecordsList(Map records) {
    final List<Widget> widgets = [];

    records.forEach((level, score) {
      widgets.add(ListTile(
        title: Text('Level $level'),
        trailing: Text(score.toString()),
        tileColor: Colors.grey[900],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ));

      widgets.add(const Divider(color: Colors.transparent));
    });

    if (widgets.isEmpty) {
      widgets.add(
        const Center(
          child: Text('No records available'),
        ),
      );
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<RecordsRepository>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Records'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(12),
          child: Observer(
            builder: (context) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 36, bottom: 24),
                  child: Center(
                    child: Text(
                      '${getMode()} Mode',
                      style: const TextStyle(
                          fontSize: 28, color: Round6Theme.color),
                    ),
                  ),
                ),
                ...getRecordsList(mode == Mode.normal
                    ? repository.recordsNormal
                    : repository.recordsRound6),
              ],
            ),
          )),
    );
  }
}
