class Matakuliah {
  int id;
  String kode;
  String nama;
  int sks;

  Matakuliah(
      {required this.id,
      required this.kode,
      required this.nama,
      required this.sks});

  factory Matakuliah.fromJson(Map<String, dynamic> json) {
    return Matakuliah(
      id: json['id'],
      kode: json['kode'],
      nama: json['nama'],
      sks: json['sks'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kode': kode,
      'nama': nama,
      'sks': sks,
    };
  }
}
