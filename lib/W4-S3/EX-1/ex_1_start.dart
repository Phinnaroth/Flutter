import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Custom buttons"),
        ),
        body: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(),
            SizedBox(
              height: 5,
            ),
            CustomButton(),
            SizedBox(
              height: 5,
            ),
            CustomButton(),
            SizedBox(
              height: 5,
            ),
            CustomButton(),
          ],
        ),
      ),
    ));

class CustomButton extends StatefulWidget {
  const CustomButton({super.key});

  @override
  CustomButtonState createState() => CustomButtonState();
}

class CustomButtonState extends State<CustomButton> {
  bool isSelected = false;

  String get buttonText => isSelected ? 'Selected' : 'Not Selected';
  Color get textColor => isSelected ? Colors.white : Colors.black;
  Color get bgColor => isSelected ? const Color.fromARGB(255, 8, 134, 237): Colors.lightBlueAccent ;

  void clicked() {
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 400,
        height: 100,
        child: ElevatedButton(
          onPressed: clicked,
          style: ElevatedButton.styleFrom(
            foregroundColor: textColor, 
            backgroundColor: bgColor,
          ),
          child: Center(
            child: Text(buttonText),
          ),
        ),
      ),
    );
  }
}