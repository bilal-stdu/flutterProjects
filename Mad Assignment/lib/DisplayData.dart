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
            title: const Text('Leagues Data'),
          ),
          body: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                    future: getLeaguesApi(),
                    builder: (context, snapshot) {
                      if(!snapshot.hasData){
                        return const Center(child:Text('Loading'));
                      }
                      if(snapshot.hasData){
                        return ListView.separated(
                          itemCount: leaguesData!.response!.length,
                          separatorBuilder: (context, index) => Divider(color: Colors.grey),
                          itemBuilder: (context, index) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 10,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        'https://fls.contentprotectforce.com/public/${leaguesData!.response![index].icon}',
                                        height: 120,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    Text(
                                      'Name',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      leaguesData!.response![index].name.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    Text(
                                      'Updated At',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      leaguesData!.response![index].updatedAt.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    Text(
                                      'Created At',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      leaguesData!.response![index].createdAt.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                        ;
                      }
                      else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      return  const Center(child:Text('Loading'));
                    }),
              )
            ],
          )),
    );
  }
}

