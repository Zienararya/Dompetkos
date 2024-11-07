import 'package:flutter/material.dart';

void main() {
  runApp(KalenderPage());
}

class KalenderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tampilan Bulanan'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView( // Tambahkan SingleChildScrollView di sini
            child: Column(
              children: [
                buildMonthContainer('November'),
                buildMonthContainer('September'),
                buildMonthContainer('Agustus'),
                buildMonthContainer('Juli'),
                buildMonthContainer('Juni'),
                buildMonthContainer('Mei'),
                buildMonthContainer('April'),
                buildMonthContainer('Maret'),
                buildMonthContainer('Febuari'),
                buildMonthContainer('Januari')
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMonthContainer(String month) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(bottom: 8.0),
      color: Colors.blue[800],
      child: Center(
        child: Text(
          month,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}