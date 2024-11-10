// anggaran_model.dart

class AnggaranModel {
  int? id;
  String kategori;
  int jumlah;
  String periode;

  AnggaranModel({
    this.id,
    required this.kategori,
    required this.jumlah,
    required this.periode,
  });

  // Mengonversi dari Map ke AnggaranModel
  factory AnggaranModel.fromMap(Map<String, dynamic> map) {
    return AnggaranModel(
      id: map['id'],
      kategori: map['kategori'],
      jumlah: map['jumlah'],
      periode: map['periode'],
    );
  }

  // Mengonversi dari AnggaranModel ke Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'kategori': kategori,
      'jumlah': jumlah,
      'periode': periode,
    };
  }
}
