import 'package:dompetkos/helpers/db_instance.dart';
import 'package:dompetkos/utils/formatter.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:intl/intl.dart';
import 'package:dompetkos/style/theme.dart';
import 'package:dompetkos/models/transaksi.dart';

class CompareMonthPage extends StatefulWidget {
  @override
  _CompareMonthPageState createState() => _CompareMonthPageState();
}

class _CompareMonthPageState extends State<CompareMonthPage> {
  String? selectedMonth1;
  String? selectedMonth2;
  List<TransactionModel> transactions = [];
  Map<String, double> dataMap1 = {};
  Map<String, double> dataMap2 = {};

  @override
  void initState() {
    super.initState();
    loadTransactions();
  }

  void loadTransactions() async {
    final transactionsData = await DatabaseInstance().fetchTransactions();
    setState(() {
      transactions =
          transactionsData.map((e) => TransactionModel.fromJson(e)).toList();
    });
  }

  void filterTransactions() {
    if (selectedMonth1 != null && selectedMonth2 != null) {
      dataMap1 = getCategoryData(selectedMonth1!);
      dataMap2 = getCategoryData(selectedMonth2!);
      setState(() {});
    }
  }

  Map<String, double> getCategoryData(String month) {
    Map<String, double> dataMap = {};
    for (var transaction in transactions) {
      DateTime date = DateFormat('dd/MM/yyyy').parse(transaction.date!);
      String transactionMonth = DateFormat('MMMM yyyy').format(date);
      if (transactionMonth == month && transaction.type == 'pengeluaran') {
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
    }
    return dataMap;
  }

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: MyThemes.primary,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
          child: Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Analisis Pengeluaran',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    hint: Text('Select Month 1'),
                    value: selectedMonth1,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedMonth1 = newValue;
                        filterTransactions();
                      });
                    },
                    items: transactions
                        .map((transaction) {
                          DateTime date =
                              DateFormat('dd/MM/yyyy').parse(transaction.date!);
                          String month = DateFormat('MMMM yyyy').format(date);
                          return month;
                        })
                        .toSet()
                        .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        })
                        .toList(),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: DropdownButton<String>(
                    hint: Text('Select Month 2'),
                    value: selectedMonth2,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedMonth2 = newValue;
                        filterTransactions();
                      });
                    },
                    items: transactions
                        .map((transaction) {
                          DateTime date =
                              DateFormat('dd/MM/yyyy').parse(transaction.date!);
                          String month = DateFormat('MMMM yyyy').format(date);
                          return month;
                        })
                        .toSet()
                        .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        })
                        .toList(),
                  ),
                ),
              ],
            ),
            if (selectedMonth1 != null && selectedMonth2 != null)
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 150, // Adjust the width as needed
                            height: 150, // Adjust the height as needed
                            child: PieChart(
                              dataMap: dataMap1,
                              chartType: ChartType.disc,
                              colorList: colorList,
                              chartValuesOptions: ChartValuesOptions(
                                showChartValuesInPercentage: true,
                              ),
                              legendOptions: LegendOptions(
                                showLegends:
                                    false, // Hide legends from the chart
                              ),
                            ),
                          ),
                          // Legend below the PieChart
                          Wrap(
                            children: dataMap1.keys
                                .toList()
                                .asMap()
                                .entries
                                .map((entry) {
                              int idx = entry.key;
                              String key = entry.value;
                              Color color = colorList[idx %
                                  colorList
                                      .length]; // Ensure the index is within the color list range
                              return Padding(
                                padding: const EdgeInsets.all(
                                    2.0), // Reduced padding
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 10,
                                      height: 10,
                                      color: color,
                                    ),
                                    SizedBox(width: 2), // Reduced spacing
                                    Text(key),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 150, // Adjust the width as needed
                            height: 150, // Adjust the height as needed
                            child: PieChart(
                              dataMap: dataMap2,
                              chartType: ChartType.disc,
                              colorList: colorList,
                              chartValuesOptions: ChartValuesOptions(
                                showChartValuesInPercentage: true,
                              ),
                              legendOptions: LegendOptions(
                                showLegends:
                                    false, // Hide legends from the chart
                              ),
                            ),
                          ),
                          // Legend below the PieChart
                          Wrap(
                            children: dataMap2.keys
                                .toList()
                                .asMap()
                                .entries
                                .map((entry) {
                              int idx = entry.key;
                              String key = entry.value;
                              Color color = colorList[idx %
                                  colorList
                                      .length]; // Ensure the index is within the color list range
                              return Padding(
                                padding: const EdgeInsets.all(
                                    2.0), // Reduced padding
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 10,
                                      height: 10,
                                      color: color,
                                    ),
                                    SizedBox(width: 2), // Reduced spacing
                                    Text(key),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            if (selectedMonth1 != null && selectedMonth2 != null)
              Expanded(
                child: ListView.builder(
                  itemCount: dataMap1.keys.length, // Use the keys from dataMap1
                  itemBuilder: (context, index) {
                    String category = dataMap1.keys.elementAt(index);
                    double totalAmount1 = dataMap1[category] ?? 0.0;
                    double totalAmount2 = dataMap2[category] ?? 0.0;
                    double difference = totalAmount2 - totalAmount1;
                    return ListTile(
                      title: Text(category),
                      subtitle: Text(
                          'Month 1: Rp.${Formatter().formatAmount(totalAmount1.toInt().abs())}, Month 2: Rp.${Formatter().formatAmount(totalAmount2.toInt().abs())}'),
                      trailing: Text(
                        difference >= 0
                            ? '+Rp.${Formatter().formatAmount(difference.toInt())}'
                            : '-Rp.${Formatter().formatAmount(difference.toInt().abs())}',
                        style: TextStyle(
                            color: difference >= 0 ? Colors.green : Colors.red),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Helper method to calculate total amount for a category
double calculateTotalAmountForCategory(
    Map<String, double> dataMap, String category) {
  return dataMap[category] ?? 0.0;
}
