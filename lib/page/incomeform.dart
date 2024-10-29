import 'package:flutter/material.dart';

class IncomeForm extends StatelessWidget {
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
