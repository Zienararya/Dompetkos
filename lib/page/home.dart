import 'package:dompetkos/helpers/db_instance.dart';
import 'package:dompetkos/page/comparemonth.dart';
import 'package:dompetkos/page/incomeform.dart';
import 'package:dompetkos/style/theme.dart';
import 'package:dompetkos/utils/showNotification.dart';
import 'package:flutter/material.dart';
import 'package:dompetkos/utils/formatter.dart';
import 'spendform.dart';
import 'kalender.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isExpanded = false;
  bool hasNotification = true; // Penanda apakah ada notifikasi
  List<Map<String, dynamic>> transactions = [];
  int totalAmount = 0;
  int totalIncome = 0;
  int totalExpense = 0;

  @override
  void initState() {
    super.initState();
    loadTransactions();
  }

  void loadTransactions() async {
    final data = await DatabaseInstance().fetchTransactions();
    setState(() {
      transactions = data;
      calculateTotals();
      checkReminders();
    });
  }

  void calculateTotals() {
    totalIncome = transactions
        .where((item) => item['amount'] > 0)
        .fold(0, (sum, item) => sum + (item['amount'] as int));
    totalExpense = transactions
        .where((item) => item['amount'] < 0)
        .fold(0, (sum, item) => sum + (item['amount']) as int);
    totalAmount = totalIncome + totalExpense;
  }

  void checkReminders() {
    DateTime now = DateTime.now();
    String formattedDate = "${now.day}/${now.month}/${now.year}";

    for (var transaction in transactions) {
      if (transaction['isreminder'] == 1 &&
          transaction['date'] == formattedDate) {
        setState(() {
          hasNotification = true;
        });
        ShowNotification().showNotification('Reminder',
            'You have a transaction reminder for ${transaction['desc']}');
        return;
      }
    }

    setState(() {
      hasNotification = false;
    });
  }

  Future<void> refreshTransactions() async {
    final data = await DatabaseInstance().fetchTransactions();
    setState(() {
      transactions = data;
      calculateTotals();
      checkReminders();
    });
  }

  Future<void> deleteTransaction(int id) async {
    bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: MyThemes.lightPrimary,
          title: Text("Konfirmasi"),
          content: Text("Apakah Anda yakin ingin menghapus transaksi ini?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Return false
              },
              child: Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Return true
              },
              child: Text("Hapus"),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      await DatabaseInstance().deleteTransaction(id);
      refreshTransactions();
    }
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

      case "Uang Saku":
        return Icons.account_balance_wallet;

      case "Freelance":
        return Icons.work;

      default:
        return Icons.help_outline; // Default icon
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyThemes.lightPrimary,
      appBar: AppBar(
        leadingWidth: 50.0,
        leading: Icon(
          Icons.account_balance_wallet,
          color: Colors.white,
        ),
        backgroundColor: MyThemes.primary,
        title: Text(
          "DompetKos",
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CompareMonthPage()), // Navigasi ke halaman kalender
                    );
                  },
                  child: Icon(
                    Icons.bar_chart,
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              KalenderPage()), // Navigasi ke halaman kalender
                    );
                  },
                  child: Icon(
                    Icons.feed_outlined,
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Tampilkan pop-up pemberitahuan
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Notifikasi"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: transactions
                                .where((transaction) =>
                                    transaction['isreminder'] == 1 &&
                                    transaction['date'] ==
                                        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}")
                                .map((transaction) => ListTile(
                                      title: Text(transaction['desc']),
                                      subtitle: Text(transaction['date']),
                                    ))
                                .toList(),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Menutup pop-up
                              },
                              child: Text("Tutup"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Stack(
                    children: [
                      Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ),
                      if (hasNotification) // Jika ada notifikasi, tampilkan lingkaran merah
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            constraints: BoxConstraints(
                              minWidth: 12,
                              minHeight: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(95.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Rp. ${Formatter().formatAmount(totalAmount)}',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 39,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      'Pemasukan : Rp. ${Formatter().formatAmount(totalIncome)}',
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'Montserrat'),
                    ),
                    Text(
                      'Pengeluaran : Rp. ${Formatter().formatAmount(totalExpense.abs())}',
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'Montserrat'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            top: 16.0, left: 16.0, right: 16.0, bottom: 100.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return Card(
                    color: MyThemes.primary,
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: ListTile(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: MyThemes.lightPrimary,
                              title: Text("Details"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Jumlah: ${Formatter().formatAmount(transaction['amount'])}"),
                                  Text("Tanggal: ${transaction['date']}"),
                                  Text("Kategori: ${transaction['category']}"),
                                  Text("Deskripsi: ${transaction['desc']}"),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Menutup pop-up
                                  },
                                  child: Text("Tutup"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      leading: Icon(
                        _getIconData(transaction['category']),
                        color: Colors.white,
                      ),
                      title: Text(
                        Formatter().formatAmount(transaction['amount']),
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        transaction['date'],
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: GestureDetector(
                        onTap: () async {
                          await deleteTransaction(transaction['id']);
                        },
                        child: Icon(
                          Icons.delete_forever_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 100,
            right: 20,
            child: Visibility(
              visible: isExpanded,
              child: FloatingActionButton.extended(
                heroTag: 'spendForm', // Unique heroTag
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SpendForm()),
                  );
                  if (result == true) {
                    refreshTransactions(); // Refresh the transactions after returning
                  }
                },
                label: const Text(
                  "Pengeluaran",
                  style: TextStyle(color: Colors.white),
                ),
                icon: const Icon(
                  Icons.remove_circle_outline,
                  color: Colors.white,
                ),
                backgroundColor: MyThemes.primary,
              ),
            ),
          ),
          Positioned(
            bottom: 160,
            right: 20,
            child: Visibility(
              visible: isExpanded,
              child: FloatingActionButton.extended(
                heroTag: 'incomeForm', // Unique heroTag
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Incomeform()),
                  );
                  if (result == true) {
                    refreshTransactions(); // Refresh the transactions after returning
                  }
                },
                label: const Text(
                  "Pemasukan",
                  style: TextStyle(color: Colors.white),
                ),
                icon: const Icon(
                  Icons.add_circle_outline,
                  color: Colors.white,
                ),
                backgroundColor: MyThemes.primary,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              heroTag: 'mainFab', // Unique heroTag
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              backgroundColor: MyThemes.primary,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
