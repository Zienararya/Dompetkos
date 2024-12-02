import 'package:dompetkos/style/theme.dart';
import 'package:dompetkos/utils/formatter.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:dompetkos/models/transaksi.dart';

class ExpenseDetailPage extends StatelessWidget {
  final String month;
  final List<TransactionModel> transactions;

  ExpenseDetailPage({required this.month, required this.transactions});

  Map<String, double> getCategoryData() {
    Map<String, double> dataMap = {};
    for (var transaction in transactions) {
      if (transaction.category != null) {
        if (dataMap.containsKey(transaction.category)) {
          dataMap[transaction.category!] = dataMap[transaction.category!]! +
              (transaction.amount?.toDouble() ?? 0.0);
        } else {
          dataMap[transaction.category!] =
              transaction.amount?.toDouble() ?? 0.0;
        }
      }
    }
    return dataMap;
  }

  double getTotalAmount() {
    return transactions.fold(0.0,
        (sum, transaction) => sum + (transaction.amount?.toDouble() ?? 0.0));
  }

  @override
  Widget build(BuildContext context) {
    final dataMap = getCategoryData();
    final totalAmount = getTotalAmount();
    final colorList = [
      MyThemes.chart1,
      MyThemes.chart2,
      MyThemes.chart3,
      MyThemes.chart4,
      MyThemes.chart5,
      MyThemes.chart6,
    ];

    return Scaffold(
      backgroundColor: MyThemes.lightPrimary,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
          child: Icon(Icons.feed_outlined, color: Colors.white),
        ),
        title: Text(
          month,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: MyThemes.primary,
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
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: dataMap.keys.map((category) {
                        return _buildLegendItem(category,
                            colorList[dataMap.keys.toList().indexOf(category)]);
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: dataMap.keys.map((category) {
                  final amount = dataMap[category]!;
                  final percentage = (amount / totalAmount) * 100;
                  return buildExpenseItem(
                    _getIconData(category),
                    category,
                    'Rp.${Formatter().formatAmount(amount.toInt())}',
                    '${percentage.toStringAsFixed(1)}%',
                  );
                }).toList(),
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

  Widget _buildLegendItem(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            color: color,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildExpenseItem(
      IconData icon, String title, String amount, String percentage) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(amount),
        trailing: Text(
          percentage,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        onTap: () {
          // Tambahkan aksi jika diperlukan
        },
      ),
    );
  }

  IconData _getIconData(String category) {
    switch (category) {
      case "Pendidikan":
        return Icons.school;
      case "Tempat Tinggal":
        return Icons.home;
      case "Makanan":
        return Icons.fastfood;
      case "Transportasi":
        return Icons.directions_bus;
      case "Belanja":
        return Icons.shopping_cart;
      case "Lainnya":
        return Icons.more_horiz;
      default:
        return Icons.help_outline; // Default icon
    }
  }
}
