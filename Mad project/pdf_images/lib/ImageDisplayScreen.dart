import 'package:flutter/material.dart';
import 'package:pdf_images/theme_provider.dart';
import 'package:provider/provider.dart';


class ImageDisplayScreen extends StatefulWidget {
  final List<String> imageUrls;

  ImageDisplayScreen(this.imageUrls);

  @override
  _ImageDisplayScreenState createState() => _ImageDisplayScreenState();
}

class _ImageDisplayScreenState extends State<ImageDisplayScreen> {
  bool _isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("File picker demo"),
        actions: [
          IconButton(
            icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              setState(() {
                _isDarkMode = !_isDarkMode;
                themeProvider.setTheme(_isDarkMode);
              });
            },
          ),
        ],
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

