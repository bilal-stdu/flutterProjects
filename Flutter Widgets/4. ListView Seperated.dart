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
      "David","Alice",
      "Bob",
      "Charlie",
      "David",
      "Charlie",
      "David",
    ];

    return MaterialApp(
        title: 'Flutter Layout Demo',
        home: Scaffold(
            appBar: AppBar(
              title: const Text('ListView demo'),
            ),
            body: ListView.separated (
              itemBuilder: (context, index) {
                return Row(
                  children: [
                  Text(
                  arrNames[index],
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
                )
                  ],
                );
              },
              itemCount: arrNames.length,
              separatorBuilder: (context, index){
                return Divider(height: 100, thickness: 2,);
              },
              // scrollDirection: Axis.horizontal,
            )));
  }
}
