import 'package:flutter/material.dart';


class ImageDetailScreen extends StatelessWidget {
  final String imageUrl;
  final String size;
  final String format;

  const ImageDetailScreen({super.key,
    required this.imageUrl,
    required this.size,
    required this.format,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ExtractImgPDF",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Text(
            //   'Size: $size KB',
            //   style: Theme.of(context).textTheme.titleMedium,
            // ),
            // Text(
            //   'Format: .$format',
            //   style: Theme.of(context).textTheme.titleMedium,
            // ),
            Image.network(imageUrl),
            const SizedBox(height: 20), // Add some spacing
            ElevatedButton.icon(
              icon: Icon(Icons.share_outlined),
              label: Text('Share'),
              onPressed: () {

              },
            ),
          ],
        ),
      ),
    );
  }
}