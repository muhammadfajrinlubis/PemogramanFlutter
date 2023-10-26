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
          title: Text('Perhitungan Meteran Pelanggan'),
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
  TextEditingController idPelangganController = TextEditingController();
  TextEditingController namaPelangganController = TextEditingController();
  TextEditingController meteranAwalController = TextEditingController();
  TextEditingController meteranAkhirController = TextEditingController();

  double biayaPerMeter = 5000.0;
  double pajakRate = 0.05;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //tempat gambar
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: ClipOval(
                child: Container(
                  width: 100,
                  height: 100,
                  child: Image(
                    image: AssetImage("images/pdam.jpg"), 
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.yellow, // Warna latar belakang kuning
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'PDAM PADANG',
                  style: TextStyle(fontSize: 17, color: Colors.black),
                ),
              ),
            ),
            // Daftar input di bawah gambar
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: idPelangganController,
                    decoration: InputDecoration(labelText: 'ID Pelanggan'),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Masukkan ID Pelanggan';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: namaPelangganController,
                    decoration: InputDecoration(labelText: 'Nama Pelanggan'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Masukkan Nama Pelanggan';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: meteranAwalController,
                    decoration: InputDecoration(labelText: 'Meteran Awal'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Masukkan Meteran Awal';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: meteranAkhirController,
                    decoration: InputDecoration(labelText: 'Meteran Akhir'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Masukkan Meteran Akhir';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  String idPelanggan = idPelangganController.text;
                  String namaPelanggan = namaPelangganController.text;
                  int meteranAwal = int.parse(meteranAwalController.text);
                  int meteranAkhir = int.parse(meteranAkhirController.text);

                  int totalMeteran = meteranAkhir - meteranAwal;
                  double totalBiaya = totalMeteran * biayaPerMeter;
                  double pajak = totalBiaya * pajakRate;
                  double totalPembayaran = totalBiaya + pajak;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NilaiOutput(
                        idPelanggan: idPelanggan,
                        namaPelanggan: namaPelanggan,
                        totalMeteran: totalMeteran,
                        totalBiaya: totalBiaya,
                        pajak: pajak,
                        totalPembayaran: totalPembayaran,
                      ),
                    ),
                  );
                }
              },
              child: Text('Proses'),
            ),
          ],
        ),
      ),
    );
  }
}

class NilaiOutput extends StatelessWidget {
  final String idPelanggan;
  final String namaPelanggan;
  final int totalMeteran;
  final double totalBiaya;
  final double pajak;
  final double totalPembayaran;

  NilaiOutput({
    required this.idPelanggan,
    required this.namaPelanggan,
    required this.totalMeteran,
    required this.totalBiaya,
    required this.pajak,
    required this.totalPembayaran,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hasil Perhitungan'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('ID Pelanggan: $idPelanggan', style: TextStyle(fontSize: 18)),
            Text('Nama Pelanggan: $namaPelanggan', style: TextStyle(fontSize: 18)),
            Text('Total Meteran: $totalMeteran', style: TextStyle(fontSize: 18)),
            Text('Total Biaya: Rp ${totalBiaya.toStringAsFixed(2)}', style: TextStyle(fontSize: 18)),
            Text('Pajak (5%): Rp ${pajak.toStringAsFixed(2)}', style: TextStyle(fontSize: 18)),
            Text('Total Pembayaran: Rp ${totalPembayaran.toStringAsFixed(2)}', style: TextStyle(fontSize: 18)),
            ElevatedButton(
              onPressed: () {
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
