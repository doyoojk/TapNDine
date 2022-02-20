import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NFCPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      child: Column(children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 300, 0, 0),
          child: Center(
              child: Text("Tap to Check In!", style: TextStyle(fontSize: 50))),
        ),
        Icon(
          Icons.nfc,
          size: 100,
        )
      ]),
    );
  }
}
