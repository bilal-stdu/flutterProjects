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
          body: const Center(
            child: Text("Hello world"),
          )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyHomeState();
  }
}

class MyHomeState extends State<MyHomePage> {
  var no1Controller = TextEditingController();
  var no2Controller = TextEditingController();

  var result = '';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Basic Calculations")),
        body: Container(
          color: Colors.blue.shade100,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: no1Controller,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: no2Controller,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {

                              var no1 =
                                  int.parse(no1Controller.text.toString());
                              var no2 = int.parse(no2Controller.text.toString());
                              var sum = no1 + no2;

                              setState(() {
                                result = 'The sum of $no1 and $no2 is $sum';
                              });
                            },
                            child: Text("Add")),
                        ElevatedButton(
                            onPressed: () {
                              var no1 = int.parse(no1Controller.text.toString());
                              var no2 = int.parse(no2Controller.text.toString());
                              var sub = no1-no2;
                              setState(() {
                                result = 'result is $sub';
                              });
                            }, child: Text("Subtract")),
                        ElevatedButton(
                            onPressed: () {
                              var no1 = int.parse(no1Controller.text.toString());
                              var no2 = int.parse(no2Controller.text.toString());
                              var mul = no1*no2;
                              setState(() {
                                result = 'result is $mul';
                              });
                            }, child: Text("Multiplication")),
                        ElevatedButton(
                            onPressed: () {
                              var no1 = int.parse(no1Controller.text.toString());
                              var no2 = int.parse(no2Controller.text.toString());
                              var div = no1/no2;
                              setState(() {
                                result = 'result is $div';
                              });
                            }, child: Text("Division"))
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(21),
                    child: Text(
                      result,
                      style: TextStyle(fontSize: 25),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
