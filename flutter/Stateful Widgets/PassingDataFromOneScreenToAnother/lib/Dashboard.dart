import 'package:flutter/material.dart';
import 'package:project/MyHomePage.dart';
import 'package:project/main.dart';

class Dashboard extends StatelessWidget {
  
  var nameController = TextEditingController();
  Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Screen 1'),
      ),
      body: Center(
        child: Container(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Dashboard Screen', style: TextStyle(fontSize: 25,)),
              const SizedBox(height: 11,),
              TextField(
                controller: nameController,
              ),
              const SizedBox(height: 11,),
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(nameController.text.toString()),));
              }, child: Text('Next'))
            ],
          ),
        ),
      ),
    );;
  }
}
