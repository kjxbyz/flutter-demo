import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';

class NfcReadScreen extends StatefulWidget {
  @override
  _NfcReadScreenState createState() => _NfcReadScreenState();
}

class _NfcReadScreenState extends State<NfcReadScreen> {
  StreamSubscription<NDEFMessage> _stream;

  void _startScanning() {
    setState(() {
      _stream = NFC
          .readNDEF(
        alertMessage: "Custom message with readNDEF#alertMessage",
        readerMode: NFCNormalReaderMode(noSounds: true),
      )
          .listen((NDEFMessage message) {
        if (message.isEmpty) {
          print("Read empty NDEF message");
          return;
        }
        print("Read NDEF message with ${message.records.length} records");
        for (NDEFRecord record in message.records) {
          print(
              "Record '${record.id ?? "[NO ID]"}' with TNF '${record.tnf}', type '${record.type}', payload '${record.payload}' and data '${record.data}' and language code '${record.languageCode}'");
        }
      });
    });
  }

  void _stopScanning() {
    _stream?.cancel();
    setState(() {
      _stream = null;
    });
  }

  void _toggleScan() {
    if (_stream == null) {
      _startScanning();
    } else {
      _stopScanning();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _stopScanning();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Read NFC example"),
      ),
      body: Center(
          child: RaisedButton(
        child: const Text("Toggle scan"),
        onPressed: _toggleScan,
      )),
    );
  }
}
