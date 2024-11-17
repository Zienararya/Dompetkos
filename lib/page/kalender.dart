import 'package:dompetkos/page/detailbulan.dart';
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
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Kembali ke halaman sebelumnya
            },
          ),
          backgroundColor: Colors.blue[900],
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildMonthContainer(context, 'November'),
                buildMonthContainer(context, 'September'),
                buildMonthContainer(context, 'Agustus'),
                buildMonthContainer(context, 'Juli'),
                buildMonthContainer(context, 'Juni'),
                buildMonthContainer(context, 'Mei'),
                buildMonthContainer(context, 'April'),
                buildMonthContainer(context, 'Maret'),
                buildMonthContainer(context, 'Febuari'),
                buildMonthContainer(context, 'Januari')
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMonthContainer(BuildContext context, String month) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman ExpenseDetailPage saat bulan ditekan
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ExpenseDetailPage(month: month)),
        );
      },
      child: Container(
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
      ),
    );
  }
}
