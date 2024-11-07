import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

void main() {
  runApp(MaterialApp(
    home: ExpenseDetailPage(),
  ));
}

class ExpenseDetailPage extends StatelessWidget {
  final Map<String, double> dataMap = {
    "Pendidikan": 30,
    "Tempat Tinggal": 20,
    "Makanan": 10,
    "Transportasi": 10,
    "Lainnya": 20,
  };

  final List<Color> colorList = [
    Colors.blue,
    Colors.green,
    Colors.yellow[400]!,
    Colors.red,
    Colors.black,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey, // Mengubah background menjadi abu-abu muda
      appBar: AppBar(
        title: Text('September'),
        backgroundColor: Colors.blue[800],
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              // Tambahkan aksi jika diperlukan
            },
          ),
        ],
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
            // Diagram lingkaran dengan label di samping
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
                      showLegends: false, // Sembunyikan legenda default
                    ),
                    chartValuesOptions: ChartValuesOptions(
                      showChartValues: false, // Sembunyikan persentase di dalam chart
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0), // Menambahkan padding kanan untuk mencegah overflow
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLegendItem("Pendidikan", "30%", Colors.blue),
                        _buildLegendItem("Tempat Tinggal", "20%", Colors.green),
                        _buildLegendItem("Makanan", "10%", Colors.yellow[400]!),
                        _buildLegendItem("Transportasi", "10%", Colors.red),
                        _buildLegendItem("Lainnya", "20%", Colors.black),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  buildExpenseItem(Icons.school, 'Pendidikan', 'Rp.900.000', '30%'),
                  buildExpenseItem(Icons.home, 'Tempat Tinggal', 'Rp.600.000', '20%'),
                  buildExpenseItem(Icons.fastfood, 'Makanan', 'Rp.300.000', '10%'),
                  buildExpenseItem(Icons.directions_car, 'Transportasi', 'Rp.400.000', '10%'),
                  buildExpenseItem(Icons.shopping_bag, 'Lainnya', 'Rp.200.000', '20%'),
                ],
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
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10), // Ukuran font lebih kecil
            ),
          ),
          Text(
            percentage,
            style: TextStyle(fontSize: 10), // Ukuran font persentase lebih kecil
          ),
        ],
      ),
    );
  }

  Widget buildExpenseItem(IconData icon, String title, String amount, String percentage) {
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
}
