import 'package:flutter/material.dart';
//DisplayData

import 'dart:convert';


import 'package:http/http.dart' as http;

import 'Models/LeaguesData.dart';

class DisplayData extends StatefulWidget {
  const DisplayData({super.key});

  @override
  State<DisplayData> createState() => _DisplayDataState();
}

class _DisplayDataState extends State<DisplayData> {
  LeaguesData? leaguesData;
  Future<LeaguesData?> getLeaguesApi() async {
    final response =
    await http.get(Uri.parse('https://fls.contentprotectforce.com/public/api/leagues'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      leaguesData = LeaguesData.fromJson(data as Map<String, dynamic>);
      return leaguesData;
    } else {
      return null;
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
                    future: getLeaguesApi(),
                    builder: (context, snapshot) {
                      if(!snapshot.hasData){
                        return const CircularProgressIndicator();
                      }
                      if(snapshot.hasData){
                        return ListView.builder(
                            itemCount: leaguesData!.response!.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Name\n'+leaguesData!.response![index].name.toString()),
                                      Text('Icon\n'+leaguesData!.response![index].icon.toString()),
                                      Text('Updated At\n'+leaguesData!.response![index].updatedAt.toString()),
                                      Text('Created At\n'+leaguesData!.response![index].createdAt.toString()),
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

