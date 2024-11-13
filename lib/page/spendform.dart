import 'package:dompetkos/helpers/db_instance.dart';
import 'package:dompetkos/page/home.dart';
import 'package:flutter/material.dart';
import 'package:dompetkos/page/scan.dart'; // Pastikan path ini benar

class SpendForm extends StatefulWidget {
  @override
  _SpendFormState createState() => _SpendFormState();
}

class _SpendFormState extends State<SpendForm> {
  String? selectedKategori;
  DatabaseInstance databaseInstance = DatabaseInstance();
  TextEditingController dateController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController budget = TextEditingController();

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
          color: Colors.blue[900],
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.school, color: Colors.white),
                title: Text("Pendidikan", style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() {
                    selectedKategori = "Pendidikan";
                    categoryController.text = selectedKategori.toString();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.school, color: Colors.white),
                title: Text("Tempat Tinggal", style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() {
                    selectedKategori = "Tempat Tinggal";
                    categoryController.text = selectedKategori.toString();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.school, color: Colors.white),
                title: Text("Makanan", style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() {
                    selectedKategori = "Makanan";
                    categoryController.text = selectedKategori.toString();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.school, color: Colors.white),
                title: Text("Transportasi", style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() {
                    selectedKategori = "Transportasi";
                    categoryController.text = selectedKategori.toString();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.school, color: Colors.white),
                title: Text("Belanja", style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() {
                    selectedKategori = "Belanja";
                    categoryController.text = selectedKategori.toString();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.school, color: Colors.white),
                title: Text("Lainnya", style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() {
                    selectedKategori = "Lainnya";
                    categoryController.text = selectedKategori.toString();
                  });
                  Navigator.pop(context);
                },
              ),
              // Tambahkan ListTile lain untuk kategori lain...
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Homepage()),
            );
          },
          child: Icon(Icons.feed_outlined, color: Colors.white),
        ),
        title: const Text("Pengeluaran", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[900],
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
                prefixIcon: Icon(Icons.calendar_today, color: Colors.white),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.blue[900],
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
                  lastDate: DateTime(2101),
                );
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
                  color: Colors.blue[900],
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
                    Icon(Icons.arrow_drop_down, color: Colors.white),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Stack(
              alignment: Alignment.centerRight,
              children: [
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: "Jumlah uang",
                    prefixIcon: Icon(Icons.money, color: Colors.white),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.blue[900],
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                ),
                Positioned(
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      // Navigasi ke halaman ScanPage saat ikon scan ditekan
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ScanPage()),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2), // Latar belakang transparan
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.qr_code_scanner, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.white),
                labelText: "Catatan",
                prefixIcon: Icon(Icons.note, color: Colors.white),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.blue[900],
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Tambahkan aksi untuk mengingatkan
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text("Ingatkan", style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () async {
                    int amount = int.parse(amountController.text);
                    await databaseInstance.insertTransaction({
                      'date': dateController.text,
                      'category': categoryController.text,
                      'amount': -amount,
                      'desc': descController.text,
                      'type': 'pengeluaran',
                    });
                    Navigator.pop(context, true);
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text("Simpan", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
