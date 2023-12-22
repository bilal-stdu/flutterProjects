import 'package:flutter/material.dart';
class _FilePickerDemoState extends State<FilePickerDemo> {
  FilePickerResult? result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File picker demo"),
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
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Add your image extraction logic here
                      },
                      child: Text("Extract Images"),
                    ),
                  ],
                ),
              ),
            const Spacer(),
            Center(
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
