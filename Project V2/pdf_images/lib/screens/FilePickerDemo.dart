import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pdf_images/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'ImageDisplayScreen.dart';

class FilePickerDemo extends StatefulWidget {
  const FilePickerDemo({super.key, required this.title});

  final String title;

  @override
  State<FilePickerDemo> createState() => _FilePickerDemoState();
}

class _FilePickerDemoState extends State<FilePickerDemo> {
  FilePickerResult? result;
  bool _isDarkMode = false;
  bool isUploaded = false;
  late Future<void> uploadFuture;
  @override
  void initState() {
    super.initState();
    isUploaded = false; // Initialize isUploaded to false
    uploadFuture = Future.value();
  }

  Future<void> uploadPdf(List<File> files) async {
    print("Function uploadPdf called");
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://10.0.2.2:5000/uploadPdf'));

    for (var file in files) {
      request.files.add(await http.MultipartFile.fromPath('pdf', file.path,
          contentType: MediaType('application', 'pdf')));
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      return response.stream.transform(utf8.decoder).first.then((value) {
        var pdfUrls = List<String>.from(jsonDecode(value)['pdf_urls']);
        print(pdfUrls);
        return extractImages(pdfUrls);
      });
    } else {
      print('Failed to upload PDFs.');
      throw Exception('Failed to upload PDFs.');
    }
  }
  Future<void> extractImages(List<String> pdfUrls) async {
    print("Function extract images called");
    List<Map<String, dynamic>> allImageLinks = []; // List to hold all the image links

    for (var pdfUrl in pdfUrls) {
      var response = await http.get(
        Uri.parse('http://10.0.2.2:5000/extractImagesFromPdf?pdf_url=$pdfUrl'),
      );
      if (response.statusCode == 200) {
        var imageLinks =
        List<String>.from(jsonDecode(response.body)['image_links']);
        for (var imageUrl in imageLinks) {
          final imageResponse = await http.get(Uri.parse(imageUrl));
          allImageLinks.add({
            'url': imageUrl,
            'size': ((int.parse(imageResponse.headers['content-length'] ?? '0')) / 1024).toStringAsFixed(2), // Size in KB
            'format': (imageResponse.headers['content-type']?.split('/') ?? ['',''])[1], // Format as extension
          });
        }
        print(allImageLinks);
      } else {
        print('Failed to extract images.');
        throw Exception('Failed to extract images.');
      }
    }

    // Use pushReplacement to replace the current screen with the new one
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ImageDisplayScreen(allImageLinks),
      ),
    ).then((_) {
      // This block runs when you come back from the ImageDisplayScreen
      setState(() {
        isUploaded = false;
        result = null;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Extract Images from pdf file"),
        actions: [
          IconButton(
            icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode_outlined, color: Colors.white,),
            onPressed: () {
              setState(() {
                _isDarkMode = !_isDarkMode;
                themeProvider.setTheme(_isDarkMode);
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Upload your files',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              'fast and easy way',
                style: Theme.of(context).textTheme.bodySmall
            ),
            SvgPicture.asset(
              'assets/icon.svg', // Replace with the path to your SVG file
              height: 70, // You can adjust the size as needed
              width: 70,
              colorFilter: _isDarkMode ? const ColorFilter.mode(Colors.white, BlendMode.srcIn) : null,
              // color: _isDarkMode ? Colors.white : null,
              // colorBlendMode: BlendMode.srcIn,
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  result =
                      await FilePicker.platform.pickFiles(allowMultiple: true);
                  if (result == null) {
                    print("No file selected");
                  } else {
                    setState(() {});
                    for (var element in result!.files) {
                      print(element.name);
                    }
                  }
                },
                child: const Text("Pick pdf files"),
              ),
            ),
            //const Spacer(),
            const SizedBox(height: 200,),
            if (result != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Selected file:',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: result?.files.length ?? 0,
                      itemBuilder: (context, index) {
                        return Text(
                          result?.files[index].name ?? '',
                          style: Theme.of(context).textTheme.displayLarge,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 5,
                        );
                      },
                    ),
                    const SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: () async {
                        if (result == null || result!.files.isEmpty) {
                          print("No file selected");
                        } else {
                          if (!isUploaded) {
                            setState(() {
                              isUploaded =
                                  true; // Set a flag to indicate that files are being uploaded
                            });

                            // Show a circular progress indicator and a message
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return const AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CircularProgressIndicator(),
                                      SizedBox(height: 16),
                                      Text("Processing files..."),
                                    ],
                                  ),
                                );

                              },
                            );

                            // Convert PlatformFile objects to File objects
                            List<File> files = result!.files
                                .map((platformFile) => File(platformFile.path!))
                                .toList();

                            // Use FutureBuilder to handle the asynchronous operation
                            await FutureBuilder<void>(
                              future: uploadPdf(files),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  // Once the uploadPdf is complete, close the dialog
                                  Navigator.pop(context);

                                  // Handle any errors that occurred during the operation
                                  if (snapshot.hasError) {
                                    print("Error: ${snapshot.error}");
                                  }

                                  // Set the flag back to false
                                  setState(() {
                                    isUploaded = false;
                                  });

                                  // No need to navigate here; it's handled in the extractImages function
                                }

                                // Placeholder widget while waiting for the operation to complete
                                return Container();
                              },
                            );
                          }
                        }
                      },
                      child: const Text("Extract Images"),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
