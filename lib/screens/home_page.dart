import "dart:async";

import "package:asas/screens/character.dart";
import "package:flutter/material.dart";

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double characterY= 0;
  double initialPos = characterY;
  double height = 0;
  double time = 0;
  double gravity = -4.9;
  double velocity = 3.5;

  bool gameStarted = false;

  void startGame() {
    print('jumpppppp');
    gameStarted = true;
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      height = gravity * time * time + (velocity * time);
      // print(height);
      setState(() {
        characterY = initialPos - height;
      });
      if(characterY < -1 || characterY > 1) {
        timer.cancel();
      }
      // print(characterY);
      time += 0.1;
    });
  }

  void jump() {
    setState(() {
        time = 0;
        initialPos = characterY;
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
                color: Colors.red.shade50,
                child: Center(
                  child: Stack(
                    children: [
                      Character(
                        key: UniqueKey(), // Add this line
                        characterY: characterY,
                      ),
                      Container(
                        alignment: const Alignment(0, -0.5),
                        child: Text(
                          gameStarted ? '' : 'T A P  T O  P L A Y',
                          style: TextStyle(
                            color: Colors.purple.shade100,
                            fontSize: 20,
                            fontFamily: 'Raleway'
                          )
                        ),
                      )
                    ],
                  ), 
                ),
              )
            ),
            Expanded(child: Container(color: Colors.lightGreen.shade200,))
          ],
        ),
      )
    );
  }
}