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

class MyHomePage extends StatelessWidget {
  final ApiMahasiswa apiMahasiswa = ApiMahasiswa();
  final ApiMatakuliah apiMatakuliah = ApiMatakuliah();
  final ApiNilai apiNilai = ApiNilai();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tugas '),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MahasiswaScreen(apiMahasiswa),
                  ),
                );
              },
              child: Text('Mahasiswa'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MatakuliahScreen(apiMatakuliah),
                  ),
                );
              },
              child: Text('Matakuliah'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NilaiScreen(apiNilai)),
                );
              },
              child: Text('Nilai'),
            ),
          ],
        ),
      ),
    );
  }
}

class MahasiswaScreen extends StatefulWidget {
  final ApiMahasiswa apiMahasiswa;

  MahasiswaScreen(this.apiMahasiswa);

  @override
  _MahasiswaScreenState createState() => _MahasiswaScreenState();
}

class _MahasiswaScreenState extends State<MahasiswaScreen> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _tgllahirController = TextEditingController();

  Mahasiswa? _selectedMahasiswa;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mahasiswa'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _namaController,
                    decoration: InputDecoration(labelText: 'Nama'),
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  TextFormField(
                    controller: _tgllahirController,
                    decoration: InputDecoration(labelText: 'Tgl Lahir'),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      if (_selectedMahasiswa == null) {
                        Mahasiswa newMahasiswa = Mahasiswa(
                          id: 0,
                          nama: _namaController.text,
                          email: _emailController.text,
                          tgllahir: _tgllahirController.text,
                        );
                        await widget.apiMahasiswa.createMahasiswa(newMahasiswa);
                      } else {
                        Mahasiswa updatedMahasiswa = Mahasiswa(
                          id: _selectedMahasiswa!.id,
                          nama: _namaController.text,
                          email: _emailController.text,
                          tgllahir: _tgllahirController.text,
                        );
                        await widget.apiMahasiswa
                            .updateMahasiswa(updatedMahasiswa);
                        _selectedMahasiswa = null;
                      }

                      _namaController.clear();
                      _emailController.clear();
                      _tgllahirController.clear();

                      setState(() {});
                    },
                    child: Text(_selectedMahasiswa == null
                        ? 'Create Mahasiswa'
                        : 'Update Mahasiswa'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Mahasiswa>>(
              future: widget.apiMahasiswa.getMahasiswa(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<Mahasiswa> mahasiswaList = snapshot.data!;
                  return ListView.builder(
                    itemCount: mahasiswaList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(mahasiswaList[index].nama),
                        subtitle: Text(mahasiswaList[index].email),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.red),
                              ),
                              onPressed: () async {
                                bool confirmDelete = await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Confirm Deletion'),
                                    content: Text(
                                        'Are you sure to delete this item?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, false),
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          Navigator.pop(context, true);

                                          try {
                                            await widget.apiMahasiswa
                                                .deleteMahasiswa(
                                                    mahasiswaList[index].id);

                                            setState(() {
                                              mahasiswaList.removeAt(index);
                                            });
                                          } catch (e) {
                                            print(
                                                'Error deleting Mahasiswa: $e');
                                            print('StackTrace: ${e}');
                                          }
                                        },
                                        child: Text('Delete'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Text("Delete"),
                            ),
                            SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                _selectedMahasiswa = mahasiswaList[index];
                                _namaController.text = _selectedMahasiswa!.nama;
                                _emailController.text =
                                    _selectedMahasiswa!.email;
                                _tgllahirController.text =
                                    _selectedMahasiswa!.tgllahir;

                                setState(() {});
                              },
                              child: Text("Edit"),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MatakuliahScreen extends StatefulWidget {
  final ApiMatakuliah apiMatakuliah;

  MatakuliahScreen(this.apiMatakuliah);

  @override
  _MatakuliahScreenState createState() => _MatakuliahScreenState();
}

class _MatakuliahScreenState extends State<MatakuliahScreen> {
  final TextEditingController _kodeController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _sksController = TextEditingController();

  Matakuliah? _selectedMatakuliah;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Matakuliah'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _kodeController,
                    decoration: InputDecoration(labelText: 'Kode'),
                  ),
                  TextFormField(
                    controller: _namaController,
                    decoration: InputDecoration(labelText: 'Nama'),
                  ),
                  TextFormField(
                    controller: _sksController,
                    decoration: InputDecoration(labelText: 'SKS'),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      if (_selectedMatakuliah == null) {
                        Matakuliah newMatakuliah = Matakuliah(
                          id: 0,
                          kode: _kodeController.text,
                          nama: _namaController.text,
                          sks: int.parse(_sksController.text),
                        );
                        await widget.apiMatakuliah
                            .createMatakuliah(newMatakuliah);
                      } else {
                        Matakuliah updatedMatakuliah = Matakuliah(
                          id: _selectedMatakuliah!.id,
                          kode: _kodeController.text,
                          nama: _namaController.text,
                          sks: int.parse(_sksController.text),
                        );
                        await widget.apiMatakuliah
                            .updateMatakuliah(updatedMatakuliah);
                        _selectedMatakuliah = null;
                      }

                      _kodeController.clear();
                      _namaController.clear();
                      _sksController.clear();

                      setState(() {});
                    },
                    child: Text(_selectedMatakuliah == null
                        ? 'Create Matakuliah'
                        : 'Update Matakuliah'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Matakuliah>>(
              future: widget.apiMatakuliah.getMatakuliah(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<Matakuliah> matakuliahList = snapshot.data!;
                  return ListView.builder(
                    itemCount: matakuliahList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(matakuliahList[index].nama),
                        subtitle: Text(
                            'Kode: ${matakuliahList[index].kode}, SKS: ${matakuliahList[index].sks}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.red),
                              ),
                              onPressed: () async {
                                bool confirmDelete = await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Confirm Deletion'),
                                    content: Text(
                                        'Are you sure to delete this item?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, false),
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, true),
                                        child: Text('Delete'),
                                      ),
                                    ],
                                  ),
                                );

                                if (confirmDelete == true) {
                                  try {
                                    await widget.apiMatakuliah.deleteMatakuliah(
                                        matakuliahList[index].id);

                                    setState(() {
                                      matakuliahList.removeAt(index);
                                    });
                                  } catch (e) {
                                    print('Error deleting Matakuliah: $e');

                                    print('StackTrace: ${e}');
                                  }
                                }
                              },
                              child: Text("Delete"),
                            ),
                            SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                _selectedMatakuliah = matakuliahList[index];
                                _kodeController.text =
                                    _selectedMatakuliah!.kode;
                                _namaController.text =
                                    _selectedMatakuliah!.nama;
                                _sksController.text =
                                    _selectedMatakuliah!.sks.toString();

                                setState(() {});
                              },
                              child: Text("Edit"),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class NilaiScreen extends StatefulWidget {
  final ApiNilai apiNilai;

  NilaiScreen(this.apiNilai);

  @override
  _NilaiScreenState createState() => _NilaiScreenState();
}

class _NilaiScreenState extends State<NilaiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nilai'),
      ),
      body: FutureBuilder<List<Nilai>>(
        future: ApiNilai.getNilaiList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Nilai> nilaiList = snapshot.data!;
            return ListView.builder(
              itemCount: nilaiList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('ID: ${nilaiList[index].id}'),
                  subtitle: Text('Nilai: ${nilaiList[index].nilai}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                        ),
                        onPressed: () async {
                          await ApiNilai.deleteNilai(nilaiList[index].id);
                          setState(() {
                            nilaiList.removeAt(index);
                          });
                        },
                        child: Text("Delete"),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Edit"),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
