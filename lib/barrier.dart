import 'package:flappy_bird/barrier.dart';
import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final barrierWidth;
  final barrierHeight;
  final barrierX;
  final bool isThisBottomBarrier;

  MyBarrier({this.barrierHeight,
    this.barrierWidth,
    required this.isThisBottomBarrier,
    this.barrierX});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(( 2 * barrierX + barrierWidth) / (2 - barrierWidth) , isThisBottomBarrier ? 1 : -1),
      child: Container(
        color: Colors.green,
        width: MediaQuery.of(context).size.width * barrierWidth / 2,
        height: MediaQuery.of(context).size.height * 3 / 4 * barrierWidth / 2,
      ),
    );
  }
}