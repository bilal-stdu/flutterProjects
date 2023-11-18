import 'package:extract_images/screens/UploadScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String tit = 'Upload File';
  String sub = 'Browse and choose the files you want to upload.';
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter File upload Demo',
      home: UploadScreen(),
    );
  }
}

