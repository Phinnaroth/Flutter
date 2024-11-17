import 'package:flutter/material.dart';

List<String> colors = ["red", "blue", "green"];

List<Widget> getLabels() {
  return colors.map((item) => Text(item)).toList();
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Label("Method 1: Loop in Array", bold: true),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var color in colors) Text(color),
              ],
            ),
            Label("Method 2: Map", bold: true),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               
                ...colors.map((item) => Text(item))
              ],
            ),
            Label("Method 3: Dedicated Function", bold: true),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: getLabels(),
            )
          ],
        ),
      ),
    ),
  ));
}

class Label extends StatelessWidget {
  final bool bold;
  final String text;

  Label(this.text, {super.key, this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal),
    );
  }
}