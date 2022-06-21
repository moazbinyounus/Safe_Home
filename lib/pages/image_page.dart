import 'package:safe_home/api/firebase_api.dart';
import 'package:safe_home/models/firebase_file.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ImagePage extends StatelessWidget {
  final FirebaseFile file;

  const ImagePage({
    key,
    this.file,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isImage = ['.jpeg', '.jpg', '.png','.avi'].any((file.name).contains);
    return Scaffold(
      appBar: AppBar(
        title: Text(file.name),
        centerTitle: true,
        actions: [
          IconButton(
            color: kThemeColor,
            icon: Icon(Icons.file_download),
            onPressed: () async {
              await FirebaseApi.downloadFile(file.ref);

              final snackBar = SnackBar(
                content: Text('Downloaded ${file.name}'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: isImage
          ? Image.network(
        file.url,
        height: double.infinity,
        fit: BoxFit.cover,
      )
          : Center(
        child: Text(
          'Cannot be displayed',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
