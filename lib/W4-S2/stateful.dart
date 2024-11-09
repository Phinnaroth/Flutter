import 'dart:math';

import 'package:flutter/material.dart';

const String diceImage1 = 'assets/dice/dice-1.png';
const String diceImage2 = 'assets/dice/dice-2.png';
const String diceImage3 = 'assets/dice/dice-3.png';
const String diceImage4 = 'assets/dice/dice-4.png';
const String diceImage5 = 'assets/dice/dice-5.png';
const String diceImage6 = 'assets/dice/dice-6.png';   

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller> {
  void rollDice() {
     //  Display the dice 4 !
  setState(() {
      int diceNumber = Random().nextInt(6) + 1;
      switch (diceNumber) {
        case 1:
          activeDiceImage = diceImage1;
          break;
        case 2:
          activeDiceImage = diceImage2;
          break;
        case 3:
          activeDiceImage = diceImage3;
          break;
        case 4:
          activeDiceImage = diceImage4;
          break;
        case 5:
          activeDiceImage = diceImage5;
          break;
        case 6:
          activeDiceImage = diceImage6;
          break;
      }
  });
  }

String activeDiceImage = diceImage1;

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          activeDiceImage,
          width: 200,
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: rollDice,
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 28,
            ),
          ),
          child: const Text('Roll Dice'),
        )
      ],
    );
  }
}

void main() => runApp(const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.deepPurple,
        body: Center(child: DiceRoller()),
      ),
    ));