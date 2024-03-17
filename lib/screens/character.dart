import 'package:flutter/material.dart';

class Character extends StatelessWidget {
  final double characterY;
  const Character({Key? key, required this.characterY}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, characterY),
      child: Image.asset('lib/images/witch.png', width: 50),
    );
  }
}
