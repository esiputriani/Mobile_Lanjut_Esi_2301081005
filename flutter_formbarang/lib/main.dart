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
          title: Text('Form Barang'),
        ),
        body: FormBarang(),
      ),
    );
  }
}

class FormBarang extends StatefulWidget {
  @override
  _FormBarangState createState() => _FormBarangState();
}

class _FormBarangState extends State<FormBarang> {
  // Controller untuk mengambil data inputan
  final TextEditingController kodeController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController jumlahController = TextEditingController();
  final TextEditingController diskonController = TextEditingController();
  final TextEditingController totalController = TextEditingController();
  final TextEditingController bayarController = TextEditingController();

  // Fungsi untuk proses hitung total dan diskon
  void proses() {
    double harga = double.tryParse(hargaController.text) ?? 0;
    int jumlah = int.tryParse(jumlahController.text) ?? 0;
    double diskon = double.tryParse(diskonController.text) ?? 0;

    // Hitung total harga
    double total = harga * jumlah;

    // Hitung diskon
    double diskonNominal = total * (diskon / 100);

    // Total setelah diskon
    double totalSetelahDiskon = total - diskonNominal;

    // Masukkan hasil ke controller
    totalController.text = totalSetelahDiskon.toStringAsFixed(2);
    bayarController.text = totalSetelahDiskon.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Kode Barang
          Text('Kode Barang'),
          TextField(controller: kodeController),
          SizedBox(height: 10),

          // Nama Barang
          Text('Nama Barang'),
          TextField(controller: namaController),
          SizedBox(height: 10),

          // Harga
          Text('Harga'),
          TextField(controller: hargaController, keyboardType: TextInputType.number),
          SizedBox(height: 10),

          // Jumlah
          Text('Jumlah'),
          TextField(controller: jumlahController, keyboardType: TextInputType.number),
          SizedBox(height: 10),

          // Diskon
          Text('Diskon (%)'),
          TextField(controller: diskonController, keyboardType: TextInputType.number),
          SizedBox(height: 20),

          // Tombol Proses
          ElevatedButton(
            onPressed: proses,
            child: Text('Proses'),
          ),
          SizedBox(height: 20),

          // Total
          Text('Total'),
          TextField(controller: totalController, readOnly: true),
          SizedBox(height: 10),

          // Bayar
          Text('Bayar'),
          TextField(controller: bayarController, readOnly: true),
        ],
      ),
    );
  }
}
