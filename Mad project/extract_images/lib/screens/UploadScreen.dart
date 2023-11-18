import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';

import 'ImageDisplayScreen.dart';

class UploadScreen extends StatefulWidget {
  final String title = 'Upload File';
  final String subtitle = 'Browse and choose the files you want to upload.';
  const UploadScreen({super.key});
  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  double progress = 0.0;
  bool isUploaded = false;
  FilePickerResult? result;
  late Future<void> uploadFuture;
  @override
  void initState() {
    super.initState();
    uploadFuture = Future.value();
  }

  Future<void> uploadPdf(File file) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://10.0.2.2:5000/uploadPdf'));
    request.files.add(await http.MultipartFile.fromPath('pdf', file.path,
        contentType: MediaType('application', 'pdf')));
    var response = await request.send();
    if (response.statusCode == 200) {
      return response.stream.transform(utf8.decoder).first.then((value) {
        var pdfUrl = jsonDecode(value)['pdf_url'];
        return extractImages(pdfUrl);
      });
    } else {
      print('Failed to upload PDF.');
      throw Exception('Failed to upload PDF.');
    }
  }

  Future<void> extractImages(String pdfUrl) async {
    var response = await http.get(
        Uri.parse('http://10.0.2.2:5000/extractImagesFromPdf?pdf_url=$pdfUrl'));
    if (response.statusCode == 200) {
      var imageLinks =
          List<String>.from(jsonDecode(response.body)['image_links']);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ImageDisplayScreen(imageLinks)),
      ).then((_) {
        // This block runs when you come back from the ImageDisplayScreen
        setState(() {
          isUploaded = false;
        });
      });
    } else {
      print('Failed to extract images.');
      throw Exception('Failed to extract images.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Extract Images'),
        elevation: 0,
        backgroundColor: Colors.amber,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 60.0,
          ),
          if (!isUploaded)
            Column(
              children: [
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
                    } else {
                      for (var element in result!.files) {
                        print(element.name);
                        if (element.path != null) {
                          setState(() {
                            uploadFuture = uploadPdf(File(element.path!));
                            isUploaded =
                                true; // Set isUploaded to true when file is selected
                          });
                        }
                      }
                    }
                  },
                  backgroundColor: Colors.amber,
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          const SizedBox(
            height: 15.0,
          ),
          FutureBuilder(
            future: uploadFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Display a progress indicator while the file is being processed
                return Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 8),
                      Text(
                        'File is being processed...',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.5,
                        ),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                // Display an error message if the upload fails
                setState(() {
                  isUploaded =
                      false; // Reset isUploaded to false if the upload fails
                });
                return Column(
                  children: [
                    Icon(Icons.error, color: Colors.red),
                    SizedBox(height: 8),
                    Text('Failed to upload file'),
                  ],
                );
              } else {
                // Upload completed successfully, no need to display anything here
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
