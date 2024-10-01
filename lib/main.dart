import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DompetKos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.account_circle_outlined),
          actions: [Icon(Icons.notifications)],
          title: Text('DompetKos'),
          centerTitle: true,
          backgroundColor: Colors.green[50],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
        ),
        body: Center(
            child: Scaffold(
          backgroundColor: Colors.green[200],
        )),
      ),
    );
  }
}
