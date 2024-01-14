import 'package:flutter/material.dart';
import 'package:flutter_application_crud/Mahasiswa.dart';
import 'package:flutter_application_crud/MataKuliah.dart';
import 'package:flutter_application_crud/Nilai.dart';
import 'package:flutter_application_crud/api.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ApiMahasiswa _apiMahasiswa = ApiMahasiswa();
  final ApiMatakuliah _apiMatakuliah = ApiMatakuliah();
  final ApiNilai _apiNilai = ApiNilai();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD Example'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              try {
                Mahasiswa newMahasiswa = Mahasiswa(
                  id: 0,
                  nama: 'Dodi',
                  email: 'dedi@gmail.com',
                  tgllahir: '1979-01-01',
                );
                Mahasiswa createdMahasiswa =
                    await _apiMahasiswa.createMahasiswa(newMahasiswa);

                setState(() {});
              } catch (e) {
                print('Error creating Mahasiswa: $e');
              }
            },
            child: Text('Create Mahasiswa'),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                List<Mahasiswa> mahasiswaList =
                    await _apiMahasiswa.getMahasiswa();
                print('Mahasiswa List: $mahasiswaList');  // Source: [1](https://www.udemy.com/course/membuat-aplikasi-crud-mahasiswa-menggunakan-flutter-mysql/)
              } catch (e) {
                print('Error fetching Mahasiswa data: $e');
              }
            },
            child: Text('Fetch Mahasiswa Data'),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                Matakuliah newMatakuliah = Matakuliah(
                  id: 0,
                  kode: 'MK001',
                  nama: 'Matematika',
                  sks: 3,
                );

                Matakuliah createdMatakuliah =
                    await _apiMatakuliah.createMatakuliah(newMatakuliah);

                print('Matakuliah created: $createdMatakuliah');  
                
                setState(() {});
              } catch (e, stackTrace) {
                print('Error creating Matakuliah: $e');
                print('StackTrace: $stackTrace');
              }
            },
            child: Text('Create Matakuliah'),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                List<Matakuliah> matakuliahList =
                    await _apiMatakuliah.getMatakuliah();
                print('Matakuliah List: $matakuliahList');  
              } catch (e) {
                print('Error fetching Matakuliah data: $e');
              }
            },
            child: Text('Fetch Matakuliah Data'),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                Nilai newNilai = Nilai(
                  id: 0,
                  idMahasiswa: 1,
                  idMatakuliah: 1,
                  nilai: 85.5,
                );
                await ApiNilai.createNilai(newNilai);

                setState(() {});
              } catch (e) {
                print('Error creating Nilai: $e');
              }
            },
            child: Text('Create Nilai'),
          ),
        ],
      ),
    );
  }
}
