import 'package:flutter/material.dart';
import 'package:round_6_puzzle/pages/records_page.dart';
import 'package:round_6_puzzle/theme.dart';

import '../constants.dart';

class Records extends StatefulWidget {
  const Records({Key? key}) : super(key: key);

  @override
  State<Records> createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  showRecords(Mode modo) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => RecordsPage(mode: modo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Records',
                style: TextStyle(color: Round6Theme.color, fontSize: 22),
              ),
            ),
            ListTile(
              title: const Text('Normal Mode'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => showRecords(Mode.normal),
            ),
            ListTile(
              title: const Text('Round 6 Mode'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => showRecords(Mode.round6),
            ),
          ],
        ),
      ),
    );
  }
}
