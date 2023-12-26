import 'package:flutter/material.dart';
import 'package:frontend/screens/FilePickerDemo.dart';
import 'package:frontend/screens/ImageDisplayScreen.dart';
import 'package:frontend/themes/theme_provider.dart';
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
            //home: HomeScreen(),
            home: const FilePickerDemo(title: 'File picker demo'),
          );
        },
      ),
    );
  }
}



