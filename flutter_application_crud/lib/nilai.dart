class Nilai {
  int id;
  int idMahasiswa;
  int idMatakuliah;
  double nilai;

  Nilai(
      {required this.id,
      required this.idMahasiswa,
      required this.idMatakuliah,
      required this.nilai});

  factory Nilai.fromJson(Map<String, dynamic> json) {
    return Nilai(
      id: json['id'],
      idMahasiswa: json['id_mahasiswa'],
      idMatakuliah: json['id_matakuliah'],
      nilai: json['nilai'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_mahasiswa': idMahasiswa,
      'id_matakuliah': idMatakuliah,
      'nilai': nilai,
    };
  }
}
