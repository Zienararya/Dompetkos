import 'package:dompetkos/style/theme.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:flutter/services.dart' show rootBundle;

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  XFile? _image;
  String _extractedText = '';
  List<String> _textLines = [];

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      setState(() {
        _image = image;
      });
      _extractText(image);
    }
  }

  Future<void> _extractText(XFile image) async {
    final String text = await FlutterTesseractOcr.extractText(
      image.path,
      language: 'ind',
      args: {
        'tessdata': 'assets/tessdata',
      },
    );
    setState(() {
      _extractedText = text;
      _textLines = text.split('\n');
      print(_extractedText);
    });
  }

  void _selectText(String selectedText) {
    Navigator.pop(context, selectedText);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'SCAN',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context); // Kembali ke halaman sebelumnya
            },
          ),
          backgroundColor: MyThemes.primary,
          centerTitle: true,
        ),
        body: Container(
          color: MyThemes.lightPrimary,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (_image != null) Image.file(File(_image!.path)),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(MyThemes.primary)),
                  onPressed: () => _pickImage(ImageSource.camera),
                  child: Text(
                    'Capture Image',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(MyThemes.primary)),
                  onPressed: () => _pickImage(ImageSource.gallery),
                  child: Text(
                    'Select Image from Gallery',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                if (_textLines.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: _textLines.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            _textLines[index],
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () => _selectText(_textLines[index]),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
