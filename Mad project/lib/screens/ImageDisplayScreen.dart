import 'package:flutter/material.dart';
class ImageDisplayScreen extends StatelessWidget {
  final List<String> imageUrls;

  ImageDisplayScreen(this.imageUrls);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Images'),
      ),
      body: ListView.builder(
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Image.network(imageUrls[index]);
        },
      ),
    );
  }
}
