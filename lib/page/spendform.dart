import 'package:flutter/material.dart';

class SpendForm extends StatefulWidget {
  @override
  _SpendFormState createState() => _SpendFormState();
}

class _SpendFormState extends State<SpendForm> {
  String? selectedKategori;

  void _pilihKategori() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.blue[50],
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.school),
                title: Text("Pendidikan"),
                onTap: () {
                  setState(() {
                    selectedKategori = "Pendidikan";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Tempat Tinggal"),
                onTap: () {
                  setState(() {
                    selectedKategori = "Tempat Tinggal";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.fastfood),
                title: Text("Makanan"),
                onTap: () {
                  setState(() {
                    selectedKategori = "Makanan";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.directions_bus),
                title: Text("Transportasi"),
                onTap: () {
                  setState(() {
                    selectedKategori = "Transportasi";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_cart),
                title: Text("Belanja"),
                onTap: () {
                  setState(() {
                    selectedKategori = "Belanja";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.more_horiz),
                title: Text("Lainnya"),
                onTap: () {
                  setState(() {
                    selectedKategori = "Lainnya";
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
      appBar: AppBar(
        title: const Text("Pengeluaran"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "DD/MM/YYYY",
                prefixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.blue[100],
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: _pilihKategori,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedKategori ?? "Kategori",
                      style: TextStyle(color: Colors.black),
                    ),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: "Jumlah uang",
                prefixIcon: Icon(Icons.money),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.blue[100],
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: "Catatan",
                prefixIcon: Icon(Icons.note),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.blue[100],
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
                  child: const Text("Ingatkan"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Tambahkan aksi untuk simpan data
                  },
                  child: const Text("Simpan"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
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
