import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pengembalians.dart';

class DetailPengembalian extends StatefulWidget {
  static const routeName = '/detail-pengembalian'; 

  @override
  _PengembalianState createState() => _PengembalianState();
}

class _PengembalianState extends State<DetailPengembalian> {
  @override
  Widget build(BuildContext context) {
    final pengembalians = Provider.of<Pengembalians>(context, listen: false);
    final pengembalianId = ModalRoute.of(context)!.settings.arguments as String;

    // Dapatkan anggota berdasarkan ID
    final selectAnggota = pengembalians.selectById(pengembalianId);

    // Inisialisasi controller dengan handling null
    final TextEditingController kodeanggotaController = TextEditingController(
      text: selectAnggota?.kodeanggota ?? '',
    );
    final TextEditingController tkembaliController = TextEditingController(
      text: selectAnggota?.tkembali ?? '',
    );
    final TextEditingController dendaController = TextEditingController(
      text: selectAnggota?.denda ?? '',
    );
    final TextEditingController kodebukuController = TextEditingController(
      text: selectAnggota?.kodebuku?? '',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("DETAIL PENGEMBALIAN"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            children: [
              Image.asset(
              'assets/logo.png',
              width: 100, // Atur lebar logo
              height: 100, // Atur tinggi logo
            ),
            SizedBox(height: 20), // Menambahkan jarak antara logo dan teks
            Text(
              "PUSTAKA KITA",
              style: TextStyle(fontSize: 30),
            ),
              TextFormField(
                autocorrect: false,
                autofocus: true,
                decoration: InputDecoration(labelText: 'Kode Anggota'),
                textInputAction: TextInputAction.next,
                controller: kodeanggotaController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: 'TANGGAL KEMBALI'),
                textInputAction: TextInputAction.next,
                controller: tkembaliController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: 'DENDA'),
                textInputAction: TextInputAction.next,
                controller: dendaController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: 'KODE BUKU'),
                textInputAction: TextInputAction.next,
                controller: kodebukuController,
                onEditingComplete: () {
                  pengembalians.editPengembalian(
                    pengembalianId,
                    kodeanggotaController.text,
                    tkembaliController.text,
                    dendaController.text,
                    kodebukuController.text,
                    context,
                  );
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 50),
              Container(
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: OutlinedButton(
                  onPressed: () {
                    pengembalians.editPengembalian(
                    pengembalianId,
                    kodeanggotaController.text,
                    tkembaliController.text,
                    dendaController.text,
                    kodebukuController.text,
                    context,
                    );
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Edit",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
