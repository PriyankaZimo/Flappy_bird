import 'dart:async';

import 'package:flappy_bird_clone/widgets/barrier_page.dart';
import 'package:flappy_bird_clone/widgets/cover_screen_page.dart';
import 'package:flappy_bird_clone/widgets/my_bird_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ///bird Variables
  static double birdY = 0;
  double time = 0;
  double height = 0;
  double initialPos = birdY;
  double gravity = -4.9;
  double velocity = 2.5;
  double birdWidth = 0.1;
  double birdHeight = 0.1;

  ///game setting

  bool gameHasStarted = false;

  ///barriers variable

  static List<double> barrierX = [2, 2 + 1.5];
  static double barrierWidth = 0.5;
  List<List<double>> barrierHeight = [
    [0.6, 0.4],
    [0.4, 0.6]
  ];

  ///StartGame  Method

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 20), (timer) {
      height = gravity * time * time + velocity * time;
      setState(() {
        birdY = initialPos - height;
      });

      if (birdIsDead()) {
        timer.cancel();
        _showDialog();
      }
      moveMap();
      time += 0.01;
    });
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      birdY = 0;
      gameHasStarted = false;
      time = 0;
      initialPos = birdY;
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.brown.shade100,
            title: Text(
              'G A M E O V E R',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: Container(
                  height: 30,width: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),


                  child: Center(
                    child: Text(
                      'Play Again',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  ///Jump Bird

  void jump() {
    setState(() {
      time = 0;
      initialPos = birdY;
    });
  }

  bool birdIsDead() {
    if (birdY < -1 || birdY > 1) {
      return true;
    }
    // hits barriers
    for (int i = 0; i < barrierX.length; i++) {
      if (barrierX[i] <= birdWidth &&
          barrierX[i] + barrierWidth >= -birdWidth &&
          (birdY <= -1 + barrierHeight[i][0] ||
              birdY + birdHeight >= 1 - barrierHeight[i][1])) {
        return true;
      }
    }
    return false;
  }

  // static double barrierXOne = 1;
  // double barrierXtwo = barrierXOne * 1.5;

  // void jump() {
  //   setState(() {
  //     time = 0;
  //     initialHeight = birdYaxis;
  //   });
  // }
  //
  // void startGame() {
  //   gameHasStarted = true;
  //   Timer.periodic(Duration(milliseconds: 60), (timer) {
  //     time += 0.05;
  //     height = -4.9 * time * time + 2.8 * time;
  //     setState(() {
  //       birdYaxis = initialHeight - height;
  //     });
  //     setState(() {
  //       if (barrierXOne < -2) {
  //         barrierXOne += 3.5;
  //       } else {
  //         barrierXOne -= 0.05;
  //       }
  //     });
  //     setState(() {
  //       if (barrierXtwo < -2) {
  //         barrierXtwo += 3.5;
  //       } else {
  //         barrierXtwo -= 0.05;
  //       }
  //     });
  //     if (birdYaxis > 1) {
  //       timer.cancel();
  //       gameHasStarted = false;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted ? jump : startGame,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Stack(
                    children: [
                      MyBird(
                        birdY: birdY,
                        birdWidth: birdWidth,
                        birdHeight: birdHeight,
                      ),
                      //tap to play
                      CoverScreen(
                        gameHasStarted: gameHasStarted,
                      ),
                      //top barrier 0
                      BarrierPage(
                          barrierX: barrierX[0],
                          barrierHeight: barrierHeight[0][0],
                          barrierWidth: barrierWidth,
                          isThisBottomBar: false),
                      //bottom barrier 0
                      BarrierPage(
                          barrierX: barrierX[0],
                          barrierHeight: barrierHeight[0][1],
                          barrierWidth: barrierWidth,
                          isThisBottomBar: true),
                      //top barrier 1
                      BarrierPage(
                          barrierX: barrierX[1],
                          barrierHeight: barrierHeight[1][0],
                          barrierWidth: barrierWidth,
                          isThisBottomBar: false),
                      // bottom barrier 1
                      BarrierPage(
                          barrierX: barrierX[1],
                          barrierHeight: barrierHeight[1][1],
                          barrierWidth: barrierWidth,
                          isThisBottomBar: true),
                      Container(
                        alignment: Alignment(0, 0.3),
                        child: Text(
                          gameHasStarted ? '' : 'T A P T O P L A Y',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.only(right: 10, left: 10),
              color: Colors.brown,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Score',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            '0',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Best',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            '10',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '(@Created by Priyanka Puri)',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  // void showMaterialDialog() {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Text(
  //             'Game Over',
  //           ),
  //           content: Text('data'),
  //           actions: [
  //             ElevatedButton(
  //                 onPressed: () {
  //                   showMaterialDialog();
  //                 },
  //                 child: Text(
  //                   "Game Over",
  //                 ))
  //           ],
  //         );
  //       });
  // }

  void moveMap() {
    for (int i = 0; i < barrierX.length; i++) {
      setState(() {
        barrierX[i] -= 0.005;
      });
      if (barrierX[i] < -2.5) {
        barrierX[i] += 3;
      }
    }
  }
}
// Stack(
// children: [
// AnimatedContainer(
// alignment: Alignment(0, birdYaxis),
// color: Colors.blue,
// duration: Duration(milliseconds: 0),
// child: MyBird(),
// ),
// Container(
// alignment: Alignment(0, -0.3),
// child: gameHasStarted
// ? Text(" ")
// : Text(
// "T A P T O P L A Y",
// style:
// TextStyle(color: Colors.white, fontSize: 20),
// ),
// ),
// AnimatedContainer(
// alignment: Alignment(0, 1.1),
// duration: Duration(milliseconds: 0),
// child: BarrierPage(
// size: 200.0, isThisBottomBar: false,
// )),
// AnimatedContainer(
// alignment: Alignment(0, -1.1),
// duration: Duration(milliseconds: 0),
// child: BarrierPage(
// size: 200.0, isThisBottomBar: false,
// )),
// AnimatedContainer(
// alignment: Alignment(0 , 1.1),
// duration: Duration(milliseconds: 0),
// child: BarrierPage(
// size: 150.0, isThisBottomBar: false,
// )),
// AnimatedContainer(
// alignment: Alignment(0, -1.1),
// duration: Duration(milliseconds: 0),
// child: BarrierPage(
// size: 250.0, isThisBottomBar: false,
// ))
// ],
// )),
