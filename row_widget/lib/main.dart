import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // backgroundColor: Colors.pink,
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text('Mobile App Development'),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Mobile App development"),
                  Icon(Icons.ac_unit),
                  Text("Mobile App development"),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                height: 100,
                width: 100,
                color: Colors.pink,
                child: const Center(child: Text("Container 1")),
              ),
              const SizedBox(
                height: 15, // for column
                // width: 15, //for row
              ),
              Container(
                height: 100,
                width: 100,
                color: Colors.blue,
                child: const Center(child: Text("Container 2")),
              ),
              const SizedBox(
                height: 15, // for column
                // width: 15, //for row
              ),
              Container(
                height: 100,
                width: 100,
                color: Colors.teal,
                child: const Center(child: Text("Container 3")),
              )
            ],
          ),
        ),
      ),
    );
  }
}