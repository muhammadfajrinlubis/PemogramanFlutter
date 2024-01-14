import 'dart:convert';
import 'package:flutter_application_crud/Mahasiswa.dart';
import 'package:flutter_application_crud/MataKuliah.dart';
import 'package:flutter_application_crud/Nilai.dart';
import 'package:http/http.dart' as http;

class ApiMahasiswa {
  static const String baseUrl = 'http://192.168.18.14:9001/api/v1/mahasiswa';

  Future<Mahasiswa> getMahasiswaById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      return Mahasiswa.fromJson(data);
    } else {
      throw Exception('Failed to load mahasiswa by ID');
    }
  }

  Future<List<Mahasiswa>> getMahasiswa() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      Iterable<dynamic> data = json.decode(response.body);
      return data.map((json) => Mahasiswa.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load mahasiswa');
    }
  }

  Future<Mahasiswa> createMahasiswa(Mahasiswa mahasiswa) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(mahasiswa.toJson()),
    );

    if (response.statusCode == 200) {
      return Mahasiswa(
        id: 0,
        nama: mahasiswa.nama,
        email: mahasiswa.email,
        tgllahir: mahasiswa.tgllahir,
      );
    } else {
      throw Exception('Failed to create mahasiswa');
    }
  }

  Future<Mahasiswa> updateMahasiswa(Mahasiswa mahasiswa) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${mahasiswa.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(mahasiswa.toJson()),
    );

    if (response.statusCode == 200) {
      return Mahasiswa.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update mahasiswa');
    }
  }

  Future<Mahasiswa> editMahasiswa(Mahasiswa mahasiswa) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${mahasiswa.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(mahasiswa.toJson()),
    );

    if (response.statusCode == 200) {
      return Mahasiswa.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to edit mahasiswa');
    }
  }

  Future<void> deleteMahasiswa(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete mahasiswa');
    }
  }
}

class ApiMatakuliah {
  final String baseUrl = 'http://192.168.18.14:9002/api/v1/matakuliah';
  Future<List<Matakuliah>> getMatakuliah() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      Iterable<dynamic> data = json.decode(response.body);
      return data.map((json) => Matakuliah.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load matakuliah");
    }
  }

  Future<Matakuliah> createMatakuliah(Matakuliah matakuliah) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(matakuliah.toJson()),
      );

      if (response.statusCode == 201) {
        return Matakuliah.fromJson(json.decode(response.body));
      } else {
        print('Failed to create matakuliah. Response: ${response.body}');
        throw Exception(
            "Failed to create matakuliah. Status code: ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      print('Exception during createMatakuliah: $e');
      print('StackTrace: $stackTrace');
      rethrow;
    }
  }

  Future<Matakuliah> updateMatakuliah(Matakuliah matakuliah) async {
    final response = await http.put(
      Uri.parse('$baseUrl/matakuliah/${matakuliah.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(matakuliah.toJson()),
    );

    if (response.statusCode == 200) {
      return Matakuliah.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to update matakuliah");
    }
  }

  Future<void> deleteMatakuliah(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/matakuliah/$id'));

      if (response.statusCode == 204) {
        print('Matakuliah deleted successfully');
      } else {
        print(
            'Failed to delete Matakuliah. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to delete Matakuliah');
      }
    } catch (e) {
      print('Exception during deleteMatakuliah: $e');
      throw Exception('Failed to delete Matakuliah');
    }
  }
}

class ApiNilai {
  static const String baseUrl = 'http://192.168.129.141:9003/api/v1/nilai';

  static Future<List<Nilai>> getNilaiList() async {
    final response = await http.get(Uri.parse('$baseUrl/nilai'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Nilai> nilaiList = data.map((e) => Nilai.fromJson(e)).toList();
      return nilaiList;
    } else {
      throw Exception('Failed to load nilai list');
    }
  }

  static Future<Nilai> getNilaiById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/nilai/$id'));
    if (response.statusCode == 200) {
      return Nilai.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load nilai by ID');
    }
  }

  static Future<void> createNilai(Nilai nilai) async {
    final response = await http.post(
      Uri.parse('$baseUrl/nilai'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(nilai.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create nilai');
    }
  }

  static Future<void> updateNilai(int id, Nilai nilai) async {
    final response = await http.put(
      Uri.parse('$baseUrl/nilai/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(nilai.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update nilai');
    }
  }

  static Future<void> deleteNilai(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/nilai/$id'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete nilai');
    }
  }
}
