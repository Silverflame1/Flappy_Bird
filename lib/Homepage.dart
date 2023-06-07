import 'dart:async';
import 'dart:ffi';

import 'package:flappy_bird/barrier.dart';
import 'package:flappy_bird/barrier.dart';
import 'package:flutter/material.dart';

import 'bird.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String name = "Flappy Bird";

  static double birdY = 0;
  double initialPos = birdY;
  double height = 0;
  double time = 0;
  double gravity = -4.9;
  double velocity = 2;
  double birdWidth = 0.1;
  static double birdHeight = 0.1;

  bool gameStarted = false;

  static List<double> barrierX = [1, 2 + 1.5];
  static double barrierWidth = 0.5;
  List<List<double>> barrierHeight = [
    [0.6, 0.4],
    [0.4, 0.6],
  ];

  void startGame() {
    gameStarted = true;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      height = (gravity * time * time) + (velocity * time);

      setState(() {
        birdY = initialPos - height;
      });

      if (birdDead()) {
        timer.cancel();
        gameStarted = false;
        gameOver();
      }

      moveMap();

      time += 0.01;
    });
  }

  void moveMap(){
    for(int i = 0; i < barrierX.length; i++){
      setState((){
        barrierX[i] -= 0.005;
      });
      if(barrierX[i] < -1.5){
        barrierX[i] +=3;
      }
    }
  }

  void jump() {
    setState(() {
      time = 0;
      initialPos = birdY;
    });
  }

  bool birdDead() {
    if (birdY < -1 || birdY > 1) {
      return true;
    }
    for (int i = 0; i < barrierX.length; i++) {
      if (barrierX[i] <= birdWidth &&
          barrierX[i] + barrierWidth >= -birdWidth &&
          (birdY <= -1 + barrierHeight[i][0] ||
              birdY + birdHeight >= 1 - barrierHeight[i][0])) {
        return true;
      }
    }
    return false;
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      birdY = 0;
      gameStarted = false;
      time = 0;
      initialPos = birdY;
      barrierX = [1, 2 + 1.5];
    });
  }

  void gameOver() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Game Over"),
            actions: [
              FlatButton(onPressed: resetGame, child: const Text("Play Again"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameStarted ? jump : startGame,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 3,
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

                        MyBarrier(
                          barrierX: barrierX[0],
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight[0][0],
                          isThisBottomBarrier: false,
                        ),
                        MyBarrier(
                          barrierX: barrierX[0],
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight[0][1],
                          isThisBottomBarrier: true,
                        ),
                        MyBarrier(
                          barrierX: barrierX[1],
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight[1][0],
                          isThisBottomBarrier: false,
                        ),
                        MyBarrier(
                          barrierX: barrierX[1],
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight[1][1],
                          isThisBottomBarrier: false,
                        ),

                        Container(
                          alignment: const Alignment(0, -0.5),
                          child: Text(gameStarted ? "" : "Tap To Play",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              )),
                        )
                      ],
                    ),
                  ),
                )),
            Expanded(
                child: Container(
                  color: Colors.brown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Score",style: TextStyle(color: Colors.white,fontSize: 20),),
                          SizedBox(height: 20),
                          Text("0",style: TextStyle(color: Colors.white,fontSize: 35),),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Best Score",style: TextStyle(color: Colors.white,fontSize: 20),),
                          SizedBox(height: 20,),
                          Text("0",style: TextStyle(color: Colors.white,fontSize: 35),),
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
