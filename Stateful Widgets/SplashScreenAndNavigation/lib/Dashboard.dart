import 'package:flutter/material.dart';
import 'package:project/MyHomePage.dart';
import 'package:project/main.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Screen 1'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text('Welcome', style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
            ),
          ),
          const SizedBox(height: 12,),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(),));
          }, child: Text('Next')
          )
        ],
      ),
    );;
  }
}
