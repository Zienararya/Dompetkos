import 'package:dompetkos/page/incomeform.dart';
import 'package:flutter/material.dart';
import 'spendform.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
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

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formatedDate = "${now.day}/${now.month}/${now.year}";

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        leading: Icon(
          Icons.calendar_month_outlined,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue[900],
        title: Text(
          formatedDate,
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.bar_chart,
                  color: Colors.white,
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
                    Icons.calendar_month_outlined,
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
                          content: Text("Anda memiliki notifikasi baru."),
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
                            child: Text(
                              '1', // Ganti dengan jumlah notifikasi jika perlu
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                              ),
                              textAlign: TextAlign.center,
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
                      'Rp. 100.000',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 39,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      'Pemasukan : ',
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'Montserrat'),
                    ),
                    Text(
                      'Pengeluaran : ',
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue[900],
                borderRadius: BorderRadius.circular(10),
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SpendForm()),
                  );
                },
                label: const Text(
                  "Pengeluaran",
                  style: TextStyle(color: Colors.white),
                ),
                icon: const Icon(
                  Icons.remove_circle_outline,
                  color: Colors.white,
                ),
                backgroundColor: Colors.blue[900],
              ),
            ),
          ),
          Positioned(
            bottom: 160,
            right: 20,
            child: Visibility(
              visible: isExpanded,
              child: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Incomeform()),
                  );
                },
                label: const Text(
                  "Pemasukan",
                  style: TextStyle(color: Colors.white),
                ),
                icon: const Icon(
                  Icons.add_circle_outline,
                  color: Colors.white,
                ),
                backgroundColor: Colors.blue[900],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              backgroundColor: Colors.blue[900],
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
