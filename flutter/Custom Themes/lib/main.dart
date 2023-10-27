import 'package:flutter/material.dart';
import 'package:project/themedata.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Themes'),
        ),
        body: Center(
          child: Column(
            children: [
              Text(
                'Hello, world!',
                style: Theme.of(context).textTheme.headlineLarge,
              )

            ],
          ),
        ),
      ),
    );
  }
}


