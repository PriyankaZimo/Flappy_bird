import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoverScreen extends StatelessWidget {
  const CoverScreen({Key? key, required bool gameHasStarted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,width: 60,
      decoration: BoxDecoration(color: Colors.green),
    );
  }
}
