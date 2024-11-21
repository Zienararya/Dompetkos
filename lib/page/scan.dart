import 'package:dompetkos/style/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ScanPage());
}

class ScanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'SCAN',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Kembali ke halaman sebelumnya
            },
          ),
          backgroundColor: MyThemes.primary,
          centerTitle: true,
        ),
        body: Container(
          color: Colors.blue[100], // Latar belakang biru muda
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                child: Stack(
                  children: [
                    // Sudut kiri atas
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(width: 5, color: Colors.black),
                            left: BorderSide(width: 5, color: Colors.black),
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    // Sudut kanan atas
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(width: 5, color: Colors.black),
                            right: BorderSide(width: 5, color: Colors.black),
                          ),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    // Sudut kiri bawah
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 5, color: Colors.black),
                            left: BorderSide(width: 5, color: Colors.black),
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    // Sudut kanan bawah
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 5, color: Colors.black),
                            right: BorderSide(width: 5, color: Colors.black),
                          ),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.flash_on, color: Colors.black, size: 30),
                    onPressed: () {
                      // Tambahkan aksi untuk tombol flash
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.image, color: Colors.black, size: 30),
                    onPressed: () {
                      // Tambahkan aksi untuk tombol gambar
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
