import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pdf_images/theme_provider.dart';

class FilePickerDemo extends StatefulWidget {
  const FilePickerDemo({super.key, required this.title});

  final String title;

  @override
  State<FilePickerDemo> createState() => _FilePickerDemoState();
}

class _FilePickerDemoState extends State<FilePickerDemo> {
  FilePickerResult? result;
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("File picker demo"),
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
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
                      separatorBuilder:
                          (BuildContext context, int index) {
                        return const SizedBox(
                          height: 5,
                        );
                      },
                    )
                  ],
                ),
              ),
            const Spacer(),
            Center(
              // child: ElevatedButton(
              //   onPressed: () async {
              //     result = await FilePicker.platform.pickFiles(allowMultiple: true);
              //     if (result == null) {
              //       print("No file selected");
              //     } else {
              //       setState(() {});
              //       for (var element in result!.files) {
              //         print(element.name);
              //       }
              //     }
              //   },
              //   child: Text(
              //     "File Picker",
              //     style: Theme.of(context).textTheme.button,
              //   ),
              // ),
              child: ElevatedButton(
                onPressed: () async {
                  result = await FilePicker.platform.pickFiles(allowMultiple: true);
                  if (result == null) {
                    print("No file selected");
                  } else {
                    setState(() {});
                    for (var element in result!.files) {
                      print(element.name);
                    }
                  }
                },
                child: Text("File Picker"),
              ),

            ),
          ],
        ),
      ),
    );
  }
}
