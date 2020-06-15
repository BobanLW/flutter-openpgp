import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:openpgp/key_pair.dart';
import 'package:openpgp/openpgp.dart';
import 'package:openpgp_example/shared/button_widget.dart';
import 'package:openpgp_example/shared/title_widget.dart';
import 'package:openpgp/key_options.dart';
import 'package:openpgp/options.dart';

class Generate extends StatefulWidget {
  const Generate({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  _GenerateState createState() => _GenerateState();
}

class _GenerateState extends State<Generate> {
  KeyPair _keyPair = KeyPair(publicKey: "", privateKey: "");

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Card(
        child: Column(
          children: [
            TitleWidget(widget.title),
            ButtonWidget(
              title: "Generate",
              key: Key("generate"),
              result: jsonEncode(_keyPair),
              onPressed: () async {
                var keyPair = await OpenPGP.generate(
                  options: Options(
                    name: 'test',
                    email: 'test@test.com',
                    passphrase: 'test',
                    keyOptions: KeyOptions(
                      rsaBits: 2048,
                    ),
                  ),
                );
                setState(() {
                  _keyPair = keyPair;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
