import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';

class MyBird extends StatelessWidget {
  final birdY;

  final double birdWidth;
  final double birdHeight;

  const MyBird({this.birdY, required this.birdWidth, required this.birdHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment(
          0,
          (2 * birdY + birdHeight / (2 - birdHeight)),
        ),
        child: Image.network(
          'https://i.dlpng.com/static/png/6781238_preview.png',
          width: MediaQuery.of(context).size.height * birdWidth / 2,
          height: MediaQuery.of(context).size.height * 3 / 4 * birdHeight / 2,
          fit: BoxFit.fill,
        ));
  }
}
