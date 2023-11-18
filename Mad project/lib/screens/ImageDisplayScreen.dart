import 'package:flutter/material.dart';
class ImageDisplayScreen extends StatefulWidget {
  final List<String> imageUrls;

  ImageDisplayScreen(this.imageUrls);

  @override
  _ImageDisplayScreenState createState() => _ImageDisplayScreenState();
}

class _ImageDisplayScreenState extends State<ImageDisplayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Extracted Images'),
        backgroundColor: Colors.amber,
      ),
      body: ListView.builder(
        itemCount: widget.imageUrls.length,
        itemBuilder: (context, index) {
          return Image.network(widget.imageUrls[index]);
        },
      ),
    );
  }
}
