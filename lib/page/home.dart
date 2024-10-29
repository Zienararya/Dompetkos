import 'package:dompetkos/page/incomeform.dart';
import 'package:flutter/material.dart';
import 'spendform.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.calendar_month_outlined,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue[900],
        title: Text(
          'DD/MM/YYYY',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.edit_document,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.notifications,
                    color: Colors.white,
                  )
                ],
              )),
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
              ]),
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
                    MaterialPageRoute(builder: (context) => IncomeForm()),
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
