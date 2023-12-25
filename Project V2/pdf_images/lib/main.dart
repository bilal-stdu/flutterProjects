import 'package:flutter/material.dart';
import 'package:pdf_images/screens/FilePickerDemo.dart';
import 'package:pdf_images/screens/ImageDisplayScreen.dart';
import 'package:pdf_images/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(false),
      child: Consumer<ThemeProvider>(
        builder: (context, theme, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'File picker demo',
            theme: theme.getTheme(),
            home: const FilePickerDemo(title: 'File picker demo'),
          );
        },
      ),
    );
  }
}



