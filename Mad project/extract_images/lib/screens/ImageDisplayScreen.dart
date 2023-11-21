import 'package:flutter/material.dart';


class ImageDisplayScreen extends StatefulWidget {
  final List<String> imageUrls;

  ImageDisplayScreen(this.imageUrls);

  @override
  _ImageDisplayScreenState createState() => _ImageDisplayScreenState();
}

// class _ImageDisplayScreenState extends State<ImageDisplayScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Extracted Images'),
//         backgroundColor: Colors.amber,
//       ),
//       body: ListView.builder(
//         itemCount: widget.imageUrls.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: _buildImageWidget(widget.imageUrls[index]),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildImageWidget(String imageUrl) {
//     return FutureBuilder(
//       future: _getImage(imageUrl),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return const Icon(Icons.error);
//         } else {
//           return Image.network(imageUrl);
//         }
//       },
//     );
//   }
//
//   Future<Image> _getImage(String imageUrl) async {
//     final image = Image.network(imageUrl);
//     await precacheImage(image.image, context);
//     return image;
//   }
// }
class _ImageDisplayScreenState extends State<ImageDisplayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Extracted Images'),
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder(
        future: _getImages(widget.imageUrls),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Icon(Icons.error);
          } else {
            return ListView.builder(
              itemCount: widget.imageUrls.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(widget.imageUrls[index]),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<Image>> _getImages(List<String> imageUrls) async {
    List<Image> images = [];
    for (var imageUrl in imageUrls) {
      final image = Image.network(imageUrl);
      await precacheImage(image.image, context);
      images.add(image);
    }
    return images;
  }
}

