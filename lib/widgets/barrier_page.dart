import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BarrierPage extends StatelessWidget {
  final barrierWidth;
  final barrierHeight;
  final barrierX;
  final bool isThisBottomBar;

  BarrierPage({
    this.barrierWidth,
    this.barrierHeight,
    this.barrierX,
    required this.isThisBottomBar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment((2 * barrierX + barrierWidth) / (2 - barrierWidth),
          isThisBottomBar ? 1 : -1),
      child: Container(
        width: MediaQuery.of(context).size.width * barrierWidth / 2,
        height: MediaQuery.of(context).size.height * 3 / 4 * barrierHeight / 2,
        decoration: BoxDecoration(
            color: Colors.green,
            border: Border.all(color: Colors.lightGreen, width: 5),

        ),
      ),
    );
  }
}
