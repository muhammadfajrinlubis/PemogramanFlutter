import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hitung Rata-rata Nilai'),
        ),
        body: NilaiInput(),
      ),
    );
  }
}

class NilaiInput extends StatefulWidget {
  @override
  _NilaiInputState createState() => _NilaiInputState();
}

class _NilaiInputState extends State<NilaiInput> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController noBPController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController matematikaController = TextEditingController();
  TextEditingController inggrisController = TextEditingController();
  TextEditingController javaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: noBPController,
              decoration: InputDecoration(labelText: 'NO.BP'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Masukkan No. BP';
                }
                return null;
              },
            ),
            TextFormField(
              controller: namaController,
              decoration: InputDecoration(labelText: 'Nama'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Masukkan Nama';
                }
                return null;
              },
            ),
            TextFormField(
              controller: matematikaController,
              decoration: InputDecoration(labelText: 'Nilai Matematika'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Masukkan Nilai Matematika';
                }
                return null;
              },
            ),
            TextFormField(
              controller: inggrisController,
              decoration: InputDecoration(labelText: 'Nilai Bahasa Inggris'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Masukkan Nilai Bahasa Inggris';
                }
                return null;
              },
            ),
            TextFormField(
              controller: javaController,
              decoration: InputDecoration(labelText: 'Nilai Java'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Masukkan Nilai Java';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Menyusun tombol secara horizontal dengan jarak yang merata
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      double matematika = double.parse(matematikaController.text);
                      double inggris = double.parse(inggrisController.text);
                      double java = double.parse(javaController.text);

                      double total = matematika + inggris + java;
                      double rataRata = total / 3;

                      // Navigasi ke jendela output
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NilaiOutput(
                            noBP: noBPController.text,
                            nama: namaController.text,
                            matematika: matematikaController.text,
                            inggris: inggrisController.text,
                            java: javaController.text,
                            rataRata: rataRata.toString(),
                          ),
                        ),
                      );
                    }
                  },
                  child: Text('OK'),
                ),
                ElevatedButton(
                  onPressed: () {
                    noBPController.clear();
                    namaController.clear();
                    matematikaController.clear();
                    inggrisController.clear();
                    javaController.clear();
                  },
                  child: Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NilaiOutput extends StatelessWidget {
  final String noBP;
  final String nama;
  final String matematika;
  final String inggris;
  final String java;
  final String rataRata;

  NilaiOutput({
    required this.noBP,
    required this.nama,
    required this.matematika,
    required this.inggris,
    required this.java,
    required this.rataRata,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Output Nilai'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('No. BP: $noBP'),
            Text('Nama: $nama'),
            Text('Nilai Matematika: $matematika'),
            Text('Nilai Bahasa Inggris: $inggris'),
            Text('Nilai Java: $java'),
            Text('Rata-rata Nilai: $rataRata'),
            ElevatedButton(
              onPressed: () {
                // Kembali ke jendela input
                Navigator.pop(context);
              },
              child: Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}