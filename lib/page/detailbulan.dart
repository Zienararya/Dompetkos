import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class ExpenseDetailPage extends StatelessWidget {
  final String month;

  ExpenseDetailPage({required this.month});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Detail Pengeluaran: $month'),
        actions: [
          Icon(Icons.arrow_forward_ios, color: Colors.white),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Total Pengeluaran - $month',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Gunakan PieChart dari library pie_chart
            PieChart(
              dataMap: {
                "Pendidikan": 30,
                "Tempat Tinggal": 20,
                "Makanan": 10,
                "Transportasi": 10,
                "Belanja": 20,
              },
              colorList: [
                Colors.cyan,
                Colors.blue,
                Colors.lightBlue,
                Colors.indigo,
                Colors.black,
              ],
              chartValuesOptions: ChartValuesOptions(showChartValuesInPercentage: true),
              chartType: ChartType.ring,  // Bisa pilih Pie atau Ring
              ringStrokeWidth: 32, // Lebar lingkaran untuk tipe Ring
              animationDuration: Duration(milliseconds: 1500), // Durasi animasi
            ),
            SizedBox(height: 20),
            // Additional content like ListView
            // ...
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ExpenseDetailPage(month: 'September'),
  ));
}
