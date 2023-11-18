import 'package:flutter/material.dart';

void main() {
  runApp(MyHomePage());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text("Flutter Stateful widgets"),
          ),
        ),
        body: const Center(child: Text("Hello world"),)
      ),
    );
  }
}

class MyHomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyHomeState();
  }
}

class MyHomeState extends State<MyHomePage>{
  var count =0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
              title: Text("Stateful")
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Count: $count', style: TextStyle(fontSize: 34),),
                ElevatedButton(onPressed: (){
                  setState(() {
                    count++;
                  });
                }, child: Text("Increment counter")),
                ElevatedButton(onPressed: (){
                  setState(() {
                    count--;
                  });
                }, child: Text('Decrement counter'))
              ],
            ),
          ),
        ),
    );
  }

}



