import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class UploadScreen extends StatefulWidget {
  final int index;
  final String title;
  final String subtitle;

  UploadScreen(this.index,this.title, this.subtitle);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  FilePickerResult? result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Extract Images'),
        elevation: 0,
        backgroundColor: Colors.amber,
      ),
      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 60.0,
          ),
          Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40.5,
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: Text(
              widget.subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.5,
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          FloatingActionButton(
            onPressed: () async {
              result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['pdf'],
              );
              if (result == null) {
                print("No file selected");
              } else{
                setState(() {
                  for (var element in result!.files) {
                    print(element.name);
                  }
                });
              }
            },
            backgroundColor: Colors.amber,
            child: Icon(
              Icons.add,
              color: Colors.black,
            ),
          )

        ],
      ),

    );

  }
}
