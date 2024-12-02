import 'package:dompetkos/helpers/db_instance.dart';
import 'package:dompetkos/models/transaksi.dart';
import 'package:dompetkos/page/detailbulan.dart';
import 'package:dompetkos/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class KalenderPage extends StatefulWidget {
  @override
  _KalenderPageState createState() => _KalenderPageState();
}

class _KalenderPageState extends State<KalenderPage> {
  Map<String, List<TransactionModel>> groupedTransactions = {};

  @override
  void initState() {
    super.initState();
    loadTransactions();
  }

  void loadTransactions() async {
    final transactionsData = await DatabaseInstance().fetchTransactions();
    final transactions =
        transactionsData.map((e) => TransactionModel.fromJson(e)).toList();
    setState(() {
      groupedTransactions = groupByMonth(transactions);
    });
  }

  Map<String, List<TransactionModel>> groupByMonth(
      List<TransactionModel> transactions) {
    Map<String, List<TransactionModel>> data = {};
    for (var transaction in transactions) {
      if (transaction.type == 'pengeluaran') {
        DateTime date = DateFormat('dd/MM/yyyy').parse(transaction.date!);
        String month = DateFormat('MMMM yyyy').format(date);
        if (!data.containsKey(month)) {
          data[month] = [];
        }
        data[month]!.add(transaction);
      }
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyThemes.lightPrimary,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
          child: Icon(Icons.feed_outlined, color: Colors.white),
        ),
        title: const Text('Tampilan Bulanan',
            style: TextStyle(color: Colors.white)),
        backgroundColor: MyThemes.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: groupedTransactions.keys.map((month) {
              return buildMonthContainer(
                  context, month, groupedTransactions[month]!);
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget buildMonthContainer(
      BuildContext context, String month, List<TransactionModel> transactions) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ExpenseDetailPage(month: month, transactions: transactions),
          ),
        );
      },
      child: Container(
        height: 80,
        margin: EdgeInsets.only(bottom: 8.0),
        color: MyThemes.primary,
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
