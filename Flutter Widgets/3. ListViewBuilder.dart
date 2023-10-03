import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var arrNames = [
      "Alice",
      "Bob",
      "Charlie",
      "David",
      "Eve",
      "Frank",
      "Grace",
      "Hannah",
      "Ivan",
      "Judy",
      "Kevin",
      "Laura",
      "Mike",
      "Nancy",
      "Oscar"
    ];

    return MaterialApp(
        title: 'Flutter Layout Demo',
        home: Scaffold(
            appBar: AppBar(
              title: const Text('ListView demo'),
            ),
            body: ListView.builder(
              itemBuilder: (context, index) {
                return Text(
                  arrNames[index],
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
                );
              },
              itemCount: arrNames.length,
              itemExtent: 100,
              // scrollDirection: Axis.horizontal,
            )));
  }
}
