import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int x =0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Layout Demo',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('My First App'),
          ),
          body: SafeArea(
            child: Center(child: Text(x.toString(), style: TextStyle(fontSize: 50),)),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: (){
              x= x *1000;
              setState(() {

              });
              print(x.toString());
            },
          ),
        ));
  }
}

