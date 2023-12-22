import 'package:flutter/material.dart';
import 'package:pdf_images/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class ImageDisplayScreen extends StatefulWidget {
  final List<String> imageUrls;

  ImageDisplayScreen(this.imageUrls, {super.key});

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
        title: const Text("Extract Images from pdf file"),
        actions: [
          IconButton(
            icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode_outlined,color: Colors.white,),
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
                  padding: EdgeInsets.all(20),
                  child: Card(
                    shape: Border.all(
                      width: 1,
                    ),
                    elevation: 2,
                    //color: Colors.black,
                    child: Column(
                      children: <Widget>[
                        Image.network(widget.imageUrls[index]),
                        const SizedBox(
                          height: 1,
                        ),
                      ],
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
