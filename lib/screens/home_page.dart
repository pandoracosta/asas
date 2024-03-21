import "dart:async";

import "package:asas/screens/barriers.dart";
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
  double velocity = 2.8;
  static double barrierOneX = 1;
  double barrierTwoX = barrierOneX + 1.5;

  bool gameStarted = false;

  void startGame() {
    print('startttt');
    gameStarted = true;
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      height = gravity * time * time + (velocity * time);
      // print(height);
      setState(() {
        characterY = initialPos - height;
        barrierOneX -= 0.05;
        barrierTwoX -= 0.05;
      });
      if(characterDied()) {
        timer.cancel();
        gameStarted = false;
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

  bool characterDied() {
    if(characterY < -1 || characterY > 1) {
      _showDialog();
        return true;
    }
    return false;
  }

  void resetGame()  {
    Navigator.pop(context);
    setState(() {
      characterY = 0;
      gameStarted = false;
      time = 0;
      initialPos = characterY;
    });
  }

void _showDialog() {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.red.shade100,
        title: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'G A M E  O V E R',
                style: TextStyle(color: Colors.white),
              ),
              GestureDetector(
                onTap: resetGame,
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: Colors.red.shade200,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    'P L A Y  A G A I N',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  );
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
                        key: UniqueKey(),
                        characterY: characterY,
                      ),
                      Container(
                        alignment: const Alignment(0, -0.5),
                        child: Text(
                          gameStarted ? '' : 'T A P  T O  P L A Y',
                          style: TextStyle(
                            color: Colors.purple.shade200,
                            fontSize: 20,
                            fontFamily: 'Raleway'
                          )
                        ),
                      ),
                      AnimatedContainer(
                        alignment: Alignment(barrierOneX, 1.1),
                        duration: const Duration(milliseconds: 0),
                        child: const Barrier(
                          barrierHeight: 200
                        ),
                      ),
                      AnimatedContainer(
                        alignment: Alignment(barrierOneX, -1.1),
                        duration: const Duration(milliseconds: 0),
                        child: const Barrier(
                          barrierHeight: 120
                        ),
                      ),
                      AnimatedContainer(
                        alignment: Alignment(barrierTwoX, 1.1),
                        duration: const Duration(milliseconds: 0),
                        child: const Barrier(
                          barrierHeight: 150
                        ),
                      ),
                      AnimatedContainer(
                        alignment: Alignment(barrierTwoX, -1.1),
                        duration: const Duration(milliseconds: 0),
                        child: const Barrier(
                          barrierHeight: 230
                        ),
                      ),
                    ],
                  ), 
                ),
              )
            ),
              Container(
              color: Colors.red.shade100,
              height: 5,
            ),
            Container(
              color: Colors.purple.shade100,
              height: 15,
            ),
            Expanded(child: Container(
              color: Colors.purple.shade200,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('S C O R E', style: TextStyle(color: Colors.white, fontSize: 20),),
                      SizedBox(height: 20,),
                      Text('0', style: TextStyle(color: Colors.white, fontSize: 20))
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('B E S T', style: TextStyle(color: Colors.white, fontSize: 20),),
                      SizedBox(height: 20,),
                      Text('10', style: TextStyle(color: Colors.white, fontSize: 20))
                    ],
                  ),
              ]),
              )
            )
          ],
        ),
      )
    );
  }
}