import 'package:flutter/material.dart';
import '../widgets/app_button.dart';

class WelcomeScreen extends StatelessWidget {
  final String title;
  final VoidCallback onStart;

  const WelcomeScreen({
    required this.title,
    required this.onStart,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/quiz-logo.png', 
              width: 400,
              height: 400,
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 50),
            AppButton(
              label: "Start Quiz",
              icon: Icons.arrow_forward_rounded,
              onTap: onStart,
            ),
          ],
        ),
      ),
    );
  }
}