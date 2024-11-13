import 'package:flutter/material.dart';
import 'package:flutter_pustaka_2301081005/models/peminjaman.dart';
import 'package:provider/provider.dart';
import '../providers/peminjamans.dart';

class DetailPeminjaman extends StatefulWidget {
  static const routeName = '/detail-peminjaman'; 

  @override
  _PeminjamanState createState() => _PeminjamanState();
}

class _PeminjamanState extends State<DetailPeminjaman> {
  @override
  Widget build(BuildContext context) {
    final peminjamans = Provider.of<Peminjamans>(context, listen: false);
    final peminjamanId = ModalRoute.of(context)!.settings.arguments as String;

    // Dapatkan anggota berdasarkan ID
    final selectBuku =peminjamans.selectById(peminjamanId );

    // Inisialisasi controller dengan handling null
    final TextEditingController namaController= TextEditingController(
      text: selectBuku?.nama?? '',
    );
    final TextEditingController kode_AnggotaController = TextEditingController(
      text: selectBuku?.kode_anggota?? '',
    );
    final TextEditingController tpinjamController = TextEditingController(
      text: selectBuku?.tpinjam?? '',
    );
    final TextEditingController tkembaliController = TextEditingController(
      text: selectBuku?.tkembali ?? '',
    );
    final TextEditingController kodebukuController = TextEditingController(
      text: selectBuku?.kodebuku ?? '',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("DETAIL PEMINJAMAN"),
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
                decoration: InputDecoration(labelText: 'NAMA PEMINJAMAN'),
                textInputAction: TextInputAction.next,
                controller: namaController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: 'KODE ANGGOTA'),
                textInputAction: TextInputAction.next,
                controller: kode_AnggotaController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: 'TANGGAL PINJAM'),
                textInputAction: TextInputAction.next,
                controller: tpinjamController,
              ),
               TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: 'TANGGAL KEMBALI'),
                textInputAction: TextInputAction.next,
                controller: tkembaliController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: 'KODE BUKU'),
                textInputAction: TextInputAction.next,
                controller:kodebukuController,
                onEditingComplete: () {
                  peminjamans.editpeminjaman(
                    peminjamanId,
                   
                    namaController.text,
                    kode_AnggotaController.text,
                    tpinjamController.text,
                    tkembaliController.text,
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
                   peminjamans.editpeminjaman(
                      peminjamanId,
                    namaController.text,
                    kode_AnggotaController.text,
                    tpinjamController.text,
                    tkembaliController.text,
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
