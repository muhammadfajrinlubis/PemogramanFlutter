import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Uts(),
  ));
}

class Uts extends StatefulWidget {
  @override
  _UtsState createState() => _UtsState();
}

class _UtsState extends State<Uts> {
  TextEditingController kodeController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  String jenis = 'vip';

  List<String> golonganOptions = ['vip', 'eko'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Salary '),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: kodeController,
              decoration: InputDecoration(labelText: 'Kode'),
            ),
            TextField(
              controller: namaController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            Text('Jenis:'),
            DropdownButton<String>(
              value: jenis,
              items: golonganOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  jenis = newValue!;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SalaryResult(
                      kode: kodeController.text,
                      nama: namaController.text,
                      jenis: jenis,
                    ),
                  ),
                );
              },
              child: Text('Calculate'),
            ),
          ],
        ),
      ),
    );
  }
}

class SalaryResult extends StatelessWidget {
  final String kode;
  final String nama;
  final String jenis;

  SalaryResult({required this.kode, required this.nama, required this.jenis});

  @override
  Widget build(BuildContext context) {
    int salary = 0;

    // Calculate salary based on jenis
    if (jenis == 'vip') {
      salary = 1000000;
    } else if (jenis == 'eko') {
      salary = 500000;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Salary Result'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Kode: $kode'),
            Text('Nama: $nama'),
            Text('Jenis: $jenis'),
            Text('Salary: $salary'),
          ],
        ),
      ),
    );
  }
}
