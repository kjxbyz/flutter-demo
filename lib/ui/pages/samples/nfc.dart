import 'package:flutter/material.dart';

import 'package:flutter_demo/common/utils/navigator_util.dart';
import 'package:flutter_demo/ui/pages/samples/nfc_read_screen.dart';
import 'package:flutter_demo/ui/pages/samples/nfc_write_screen.dart';

class Nfc extends StatefulWidget {
  final String headerTitle;

  const Nfc({Key key, this.headerTitle}) : super(key: key);

  @override
  _NfcState createState() => _NfcState();
}

class _NfcState extends State<Nfc> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.headerTitle ?? "Nfc"),
      ),
      body: Builder(builder: (context) {
        return ListView(
          children: <Widget>[
            ListTile(
              title: const Text("Read NFC"),
              onTap: () {
                NavigatorUtil.push(context, NfcReadScreen());
              },
            ),
            Divider(),
            ListTile(
              title: const Text("Write NFC"),
              onTap: () {
                NavigatorUtil.push(context, NfcWriteScreen());
              },
            ),
          ],
        );
      }),
    );
  }

}
