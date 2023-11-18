import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // backgroundColor: Colors.tealAccent,
        appBar: AppBar(
          // backgroundColor: Colors.tealAccent,
          title: Center(child: Text('Expanded widgets')),
        ),
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                // width: 50,
                  height: 100,
                color: Colors.blue,

              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                // width: 50,
                height: 100,
                color: Colors.orange,

              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                // width: 50,
                height: 100,
                color: Colors.blueGrey,

              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                // width: 50,
                height: 100,
                color: Colors.green,

              ),
            ),

          ],
        )
      ),
    );
  }
}
/*
While designing layouts rows and columns has multiple widgets.
I want these should be divided into ratio but ratio is not uniform.
If uniform i can use listview
 */