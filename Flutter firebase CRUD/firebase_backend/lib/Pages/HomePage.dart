import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_backend/Services/firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //firestore
  final FireStoreService fireStoreService = FireStoreService();

  //textController
  final TextEditingController textEditingController = TextEditingController();

  //open a dialog box to add a note
  void openNoteBox(String? docID) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: textEditingController,
              ),
              actions: [
                //button to save
                ElevatedButton(
                    onPressed: () {
                      //add new note
                      if(docID == null){
                        fireStoreService.addNote(textEditingController.text);
                      }

                      //update an existing note
                      else{
                        fireStoreService.updateNote(docID, textEditingController.text);
                      }

                      //clear the text controller
                      textEditingController.clear();

                      //close the box
                      Navigator.pop(context);
                    },
                    child: Text('Add')),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Crud'),
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
       // onPressed: openNoteBox,
        onPressed: () => openNoteBox(null),
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: fireStoreService.getNotesStream(),
        builder: (context, snapshot) {
          //if we have data, get all docs
          if (snapshot.hasData) {
            List notesList = snapshot.data!.docs;

            //display as a list
            return ListView.builder(
                itemCount: notesList.length,
                itemBuilder: (context, index) {
                  //get each individual doc
                  DocumentSnapshot documentSnapshot = notesList[index];
                  String docID = documentSnapshot.id;

                  //get note from each doc
                  Map<String, dynamic> data =
                      documentSnapshot.data() as Map<String, dynamic>;
                  String noteText = data['note'];

                  //display as tile
                  return ListTile(
                    title: Text(noteText),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () =>openNoteBox(docID),
                          icon: const Icon(Icons.settings),
                        ),
                        IconButton(
                          onPressed: () => fireStoreService.deleteNote(docID),
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    )
                  );
                });
          } else {
            return const Text("No notes....");
          }
        },
      ),
    );
  }
}
