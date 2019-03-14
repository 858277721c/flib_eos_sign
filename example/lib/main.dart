import 'dart:convert';

import 'package:flib_eos_sign/flib_eos_sign.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: <Widget>[
            FlatButton(
              onPressed: () {
                onPressed();
              },
              child: Text('click'),
            )
          ],
        ),
      ),
    );
  }

  void onPressed() async {
    final String privateKey = await FlibEosSign.generatePrivateKey();
    print('flib_eos_sign generatePrivateKey:' + privateKey);

    final String publicKey = await FlibEosSign.toPublicKey(privateKey);
    print('flib_eos_sign toPublicKey:' + publicKey);

    final String signData =
        await FlibEosSign.sign(utf8.encode('hello'), privateKey);
    print('flib_eos_sign sign:' + signData);
  }
}
