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
        appBar: AppBar(
          title: Text('Margin and Padding'),
        ),
        body: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(top: 11, left: 34),
            //   child: Text('Hello world', style: TextStyle(fontSize: 25),),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(11),
            //   child: Text('Hello world', style: TextStyle(fontSize: 25),),
            // ),
            Container(
              // height: 200,
              //   width: 200,
                color: Colors.blueGrey,
                margin: EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Margin demo',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
