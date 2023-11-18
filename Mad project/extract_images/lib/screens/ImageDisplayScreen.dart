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
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildImageWidget(widget.imageUrls[index]),
          );
        },
      ),
    );
  }

  Widget _buildImageWidget(String imageUrl) {
    return FutureBuilder(
      future: _getImage(imageUrl),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Icon(Icons.error);
        } else {
          return Image.network(imageUrl);
        }
      },
    );
  }

  Future<Image> _getImage(String imageUrl) async {
    final image = Image.network(imageUrl);
    await precacheImage(image.image, context);
    return image;
  }
}
