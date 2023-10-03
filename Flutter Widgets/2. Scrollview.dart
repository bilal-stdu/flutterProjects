import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Layout Demo',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Scrollview demo'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 11),
                          height: 200,
                          width: 200,
                          color: Colors.lightGreen,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 11),
                          height: 200,
                          width: 200,
                          color: Colors.black,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 11),
                          height: 200,
                          width: 200,
                          color: Colors.yellow,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 11),
                          height: 200,
                          width: 200,
                          color: Colors.lightGreen,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 11),
                          height: 200,
                          width: 200,
                          color: Colors.black,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 11),
                          height: 200,
                          width: 200,
                          color: Colors.yellow,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 11),
                    height: 200,
                    // width: 200,
                    color: Colors.teal,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 11),
                    height: 200,
                    // width: 200,
                    color: Colors.purple,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 11),
                    height: 200,
                    // width: 200,
                    color: Colors.orange,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 11),
                    height: 200,
                    // width: 200,
                    color: Colors.lightGreen,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 11),
                    height: 200,
                    // width: 200,
                    color: Colors.teal,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 11),
                    height: 200,
                    // width: 200,
                    color: Colors.purple,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 11),
                    height: 200,
                    // width: 200,
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
