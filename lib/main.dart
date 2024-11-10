import 'package:dompetkos/helpers/db_instance.dart';
import 'package:dompetkos/models/transaksi.dart';
import 'package:flutter/material.dart';
import 'page/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DatabaseInstance databaseInstance = DatabaseInstance();

  @override
  void initState() {
    super.initState();
    // databaseInstance.deleteDatabase().then((_) {
    //   databaseInstance.database();
    // });
    databaseInstance.database();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder<List<TransactionModel>>(
            future: databaseInstance.all(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return MaterialApp(title: 'DompetKos', home: Homepage());
              } else {
                return MaterialApp(title: 'DompetKos', home: Homepage());
                // return Center(
                //   child: CircularProgressIndicator(
                //     color: Colors.blue,
                //   ),
                // );
              }
            }));
  }
}
