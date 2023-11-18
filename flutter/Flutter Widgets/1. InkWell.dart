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
            title: const Text('Ink well widget demo'),
          ),
          body: Center(
            child: InkWell(
              onTap: () {
                print('Tab on container');
              },
              onLongPress: () {
                print('Long Press on container');
              },
              onDoubleTap: () {
                print('Double Tab on container');
              },
              child: Container(
                width: 200,
                height: 200,
                color: Colors.yellow,
                child: Center(
                    child: InkWell(
                      onTap: (){
                        print('Tap on Text');
                      },
                        child: const Text(
                  'Click here',
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700),
                ))),
              ),
            ),
          )),
    );
  }
}
