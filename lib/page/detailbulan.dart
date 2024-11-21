import 'package:dompetkos/page/kalender.dart';
import 'package:dompetkos/style/theme.dart';
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
      if (dataMap.containsKey(transaction.category)) {
        if (transaction.category != null) {
          dataMap[transaction.category!] = dataMap[transaction.category!]! +
              (transaction.amount?.toDouble() ?? 0.0);
        }
      } else {
        if (transaction.category != null) {
          dataMap[transaction.category!] =
              transaction.amount?.toDouble() ?? 0.0;
        }
      }
    }
    return dataMap;
  }

  @override
  Widget build(BuildContext context) {
    final dataMap = getCategoryData();
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
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      KalenderPage()), // Navigasi ke halaman kalender
            );
          },
          child: Icon(Icons.feed_outlined, color: Colors.white),
        ),
        title: Text(
          month,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: MyThemes.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Total Pengeluaran',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: PieChart(
                    dataMap: dataMap,
                    colorList: colorList,
                    chartType: ChartType.disc,
                    chartRadius: MediaQuery.of(context).size.width / 3,
                    legendOptions: LegendOptions(
                      showLegends: false,
                    ),
                    chartValuesOptions: ChartValuesOptions(
                      showChartValues: false,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: dataMap.keys.map((category) {
                        return _buildLegendItem(
                            category,
                            '${dataMap[category]!.toStringAsFixed(2)}%',
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
                children: transactions.map((transaction) {
                  return buildExpenseItem(
                    _getIconData(transaction.category ?? 'Lainnya'),
                    transaction.category ?? 'Lainnya',
                    'Rp.${transaction.amount}',
                    '${((transaction.amount ?? 0) / dataMap[transaction.category]! * 100).toStringAsFixed(2)}%',
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String title, String percentage, Color color) {
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
          Text(
            percentage,
            style: TextStyle(fontSize: 10),
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
