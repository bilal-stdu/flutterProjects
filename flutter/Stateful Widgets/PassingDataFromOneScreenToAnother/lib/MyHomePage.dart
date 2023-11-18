import 'package:flutter/material.dart';
import 'package:project/Dashboard.dart';
class MyHomePage extends StatelessWidget {
  var nameFromDashboard;
  MyHomePage(this.nameFromDashboard, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home Page Screen 2"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text("Hello world"),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Welcome $nameFromDashboard", style: TextStyle(fontSize: 30, color: Colors.blueGrey),),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Dashboard(),
                          ));
                    },
                    child: Text('Go back')),
              ],
            )
          ],
        ));
  }
}