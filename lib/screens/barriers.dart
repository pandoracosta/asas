import 'package:flutter/material.dart';

class Barrier extends StatelessWidget {
  final double barrierHeight;
  const Barrier({Key? key, required this.barrierHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: barrierHeight,
      decoration: BoxDecoration(
        color: Colors.red.shade200,
        border: Border.all(color: Colors.red.shade100, width: 7),
        borderRadius: BorderRadius.circular(15)
      ),
    );
  }
}
