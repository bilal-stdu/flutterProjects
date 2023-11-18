import 'package:flutter/material.dart';
import 'package:mad_assignment/app_theme.dart';
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
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Add your navigation logic here based on the selected tab index
    });
  }
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
      theme: appThemeData,
      title: 'Flutter',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Leagues Data'),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    'Football Leagues',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Home'),
                  leading: Icon(Icons.home),
                  onTap: () {
                    // Add your navigation logic here
                    Navigator.pop(context);
                  },
                ),
                Divider(),
                ListTile(
                  title: Text('Leagues data'),
                  leading: Icon(Icons.list),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                // Add more ListTiles as needed with Dividers
              ],
            ),
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
                                    Center(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(60),
                                        child: Image.network(
                                          'https://fls.contentprotectforce.com/public/${leaguesData!.response![index].icon}',
                                          height: 120,
                                          width: 120,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),


                                    SizedBox(height: 12),
                                    Text(
                                      leaguesData!.response![index].name.toString(),
                                      style: Theme.of(context).textTheme.displayLarge,
                                    ),
                                    SizedBox(height: 12),
                                    Text(
                                      leaguesData!.response![index].updatedAt.toString(),
                                      style: Theme.of(context).textTheme.displayLarge,
                                    ),
                                    SizedBox(height: 12),
                                    Text(
                                      leaguesData!.response![index].createdAt.toString(),
                                      style: Theme.of(context).textTheme.displayLarge,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );

                      }
                      else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      return  const Center(child:Text('Loading'));
                    }),
              )
            ],
          ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Leagues Data',
            ),

          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
        ),
      ),
    );

  }
}

