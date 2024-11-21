import 'package:dompetkos/page/home.dart';
import 'package:dompetkos/helpers/db_instance.dart';
import 'package:dompetkos/style/theme.dart';
import 'package:dompetkos/utils/formatter.dart';
import 'package:flutter/material.dart';

class Incomeform extends StatefulWidget {
  @override
  State<Incomeform> createState() => _IncomeformState();
}

class _IncomeformState extends State<Incomeform> {
  String? selectedKategori;
  DatabaseInstance databaseInstance = DatabaseInstance();
  TextEditingController dateController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  void initState() {
    databaseInstance.database();
    super.initState();
  }

  void _pilihKategori() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: MyThemes.primary,
          child: Wrap(
            children: [
              ListTile(
                leading:
                    Icon(Icons.account_balance_wallet, color: Colors.white),
                title: Text(
                  "Uang Saku",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  setState(() {
                    selectedKategori = "Uang Saku";
                    categoryController.text = selectedKategori.toString();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.work, color: Colors.white),
                title: Text(
                  "Freelance",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  setState(() {
                    selectedKategori = "Freelance";
                    categoryController.text = selectedKategori.toString();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.more_horiz, color: Colors.white),
                title: Text(
                  "Lainnya",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  setState(() {
                    selectedKategori = "Lainnya";
                    categoryController.text = selectedKategori.toString();
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyThemes.lightPrimary,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Homepage()), // Navigasi ke halaman kalender
            );
          },
          child: Icon(
            Icons.add_circle_outline,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Pemasukan",
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: MyThemes.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.datetime,
              controller: dateController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.white),
                labelText: "DD/MM/YYYY",
                prefixIcon: Icon(
                  Icons.calendar_today,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: MyThemes.primary,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
              onTap: () async {
                DateTime now = DateTime.now();
                final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: now,
                    firstDate: DateTime(2015, 8),
                    lastDate: DateTime(2101));
                if (picked != null && picked != now) {
                  setState(() {
                    now = picked;
                    dateController.text = "${now.day}/${now.month}/${now.year}";
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: _pilihKategori,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                decoration: BoxDecoration(
                  color: MyThemes.primary,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedKategori ?? "Kategori",
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              inputFormatters: [Formatter()],
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.white),
                labelText: "Jumlah uang",
                prefixIcon: Icon(
                  Icons.money,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: MyThemes.primary,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.white),
                labelText: "Catatan",
                prefixIcon: Icon(
                  Icons.note,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: MyThemes.primary,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await databaseInstance.insertTransaction({
                      'date': dateController.text,
                      'category': categoryController.text,
                      'amount':
                          int.parse(amountController.text.replaceAll(',', '')),
                      'desc': descController.text,
                      'type': 'pengeluaran',
                    });
                    Navigator.pop(context, true);
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyThemes.primary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  child: const Text(
                    "Simpan",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
