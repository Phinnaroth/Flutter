import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      home: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 100,
            ),
            Container(
              height: 200,
              color: Colors.blue,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 100,
                    color: Colors.green,
                  )
                ),
                Container(
                  height: 100,
                  width: 100,
                  color: Colors.pink,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: 100,
                    color: Colors.yellow,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Container(
                    height: 100,
                    color: Colors.yellow,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Container(
                    height: 100,
                    color: Colors.yellow,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                color: Colors.pink,
              )
            )
          ],
        )
      )
    ),
  );
}