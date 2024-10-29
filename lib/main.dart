import 'package:flutter/material.dart';

void main() {
  runApp(AplikasiSaya());
}

class AplikasiSaya extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HalamanUtama(),
    );
  }
}

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  _HalamanUtamaState createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("1 / 10 / 2024"),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.receipt),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rp. 100.000",
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Pemasukan : 100.000",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Pengeluaran : 0",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue[800],
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
                    MaterialPageRoute(builder: (context) => FormPengeluaran()),
                  );
                },
                label: const Text("Pengeluaran"),
                icon: const Icon(Icons.remove_circle_outline),
                backgroundColor: Colors.blue,
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
                    MaterialPageRoute(builder: (context) => FormPemasukan()),
                  );
                },
                label: const Text("Pemasukan"),
                icon: const Icon(Icons.add_circle_outline),
                backgroundColor: Colors.blue,
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
              backgroundColor: Colors.blue,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}

class FormPemasukan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pemasukan"),
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
            TextField(
              decoration: InputDecoration(
                labelText: "Kategori",
                prefixIcon: Icon(Icons.category),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.blue[100],
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
            ElevatedButton(
              onPressed: () {
                // Tambahkan aksi untuk simpan data
              },
              child: const Text("Simpan"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class FormPengeluaran extends StatefulWidget {
  @override
  _FormPengeluaranState createState() => _FormPengeluaranState();
}

class _FormPengeluaranState extends State<FormPengeluaran> {
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
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Tambahkan aksi untuk simpan data
                  },
                  child: const Text("Simpan"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
