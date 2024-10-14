import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DompetKos',
      home: Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.calendar_month_outlined,
            color: Colors.white,
          ),
          backgroundColor: Colors.blue.shade900,
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
                              fontSize: 45,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                        Text(
                          'Pemasukan : ',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Pengeluaran : ',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
        ),
        body: Column(children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                    color: Colors.blue.shade900,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: Text("Hello World"),
                  )
                ],
              ))
        ]),
      ),
    );
  }
}
