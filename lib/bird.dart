import 'package:flappy_bird/barrier.dart';
import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  final birdY;
  final double birdWidth;
  final double birdHeight;

  MyBird({this.birdY,required this.birdWidth,required this.birdHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0,(2 * birdY + birdHeight) / (2 - birdWidth)),
      child: Image.asset('lib/images/bird.png',
        width: MediaQuery.of(context).size.height * birdWidth / 2,
        height: MediaQuery.of(context).size.height * 3 / 4 * birdWidth / 2,
        fit: BoxFit.fill,
      ),
    );
  }
}
