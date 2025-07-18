import 'package:flutter/material.dart';

class Emptyscreen extends StatelessWidget {
  const Emptyscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // better for vertical centering
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/empty.png'),
            SizedBox(height: 16),
            Text(
              'What do you want to do today?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Tap + to add your tasks',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
