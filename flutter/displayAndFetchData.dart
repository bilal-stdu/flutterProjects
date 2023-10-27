import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/PostsModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<PostsModel> postList = [];
  Future<List<PostsModel>> getPostApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        postList.add(PostsModel.fromJson(i as Map<String, dynamic>));
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('HTTP Calls'),
          ),
          body: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                    future: getPostApi(),
                    builder: (context, snapshot) {
                      if(!snapshot.hasData){
                        return const CircularProgressIndicator();
                      }
                      if(snapshot.hasData){
                       return ListView.builder(
                            itemCount: postList.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Title\n'+postList[index].title.toString()),
                                      Text('description\n'+postList[index].body.toString()),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                      else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return Text("Hello world");
                      //return const CircularProgressIndicator();
                    }),
              )
            ],
          )),
    );
  }
}
