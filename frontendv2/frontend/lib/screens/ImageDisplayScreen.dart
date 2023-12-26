import 'package:flutter/material.dart';
import 'package:frontend/themes/theme_provider.dart';
import 'package:provider/provider.dart';

import 'ImageDetailScreen.dart';

class ImageDisplayScreen extends StatefulWidget {
  final List<Map<String, dynamic>> imageUrls;

  ImageDisplayScreen(this.imageUrls, {super.key});

  @override
  _ImageDisplayScreenState createState() => _ImageDisplayScreenState();
}

class _ImageDisplayScreenState extends State<ImageDisplayScreen> {
  bool _isDarkMode = false;
  int _selectedImageIndex = -1;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ExtractImgPDF",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isDarkMode ? Icons.light_mode : Icons.dark_mode_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _isDarkMode = !_isDarkMode;
                themeProvider.setTheme(_isDarkMode);
              });
            },
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<Image>>(
        future: _getImages(widget.imageUrls),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Icon(Icons.error);
          } else {
            List<Image> images = snapshot.data ?? [];
            return ListView.builder(
              itemCount: widget.imageUrls.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(20),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    elevation: 2,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImageDetailScreen(
                              imageUrl: widget.imageUrls[index]['url'],
                              size: widget.imageUrls[index]['size'],
                              format: widget.imageUrls[index]['format'],
                            ),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: Image.network(
                          widget.imageUrls[index]['url'],
                          height: 50, // You can adjust the size as needed.
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          // 'Card ${index + 1}',
                          'Image ${index + 1}',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Size: ${widget.imageUrls[index]['size']} KB',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              'Format: .${widget.imageUrls[index]['format']}',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<Image>> _getImages(List<Map<String, dynamic>> imageUrls) async {
    List<Image> images = [];
    for (var imageMap in imageUrls) {
      final image = Image.network(imageMap['url']);
      await precacheImage(image.image, context);
      images.add(image);
    }
    return images;
  }
}
