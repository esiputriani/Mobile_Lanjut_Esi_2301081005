import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/bukus.dart';

class DetailBuku extends StatefulWidget {
  static const routeName = '/detail-buku'; 

  @override
  _BukuState createState() => _BukuState();
}

class _BukuState extends State<DetailBuku> {
  @override
  Widget build(BuildContext context) {
    final bukus = Provider.of<Bukus>(context, listen: false);
    final bukuId = ModalRoute.of(context)!.settings.arguments as String;

    // Dapatkan anggota berdasarkan ID
    final selectBuku = bukus.selectById(bukuId);

    // Inisialisasi controller dengan handling null
    final TextEditingController kodebukuController= TextEditingController(
      text: selectBuku?.kodebuku ?? '',
    );
    final TextEditingController judulbukuController = TextEditingController(
      text: selectBuku?.judulbuku?? '',
    );
    final TextEditingController pengarangController = TextEditingController(
      text: selectBuku?.pengarang ?? '',
    );
    final TextEditingController penerbitController = TextEditingController(
      text: selectBuku?.penerbit ?? '',
    );
    final TextEditingController tahunterbitController = TextEditingController(
      text: selectBuku?.tahunterbit ?? '',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("DETAIL BUKU"),
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
                decoration: InputDecoration(labelText: 'KODE BUKU'),
                textInputAction: TextInputAction.next,
                controller: kodebukuController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: 'JUDUL BUKU'),
                textInputAction: TextInputAction.next,
                controller: judulbukuController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: 'PENGARANG'),
                textInputAction: TextInputAction.next,
                controller: pengarangController,
              ),
               TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: 'PENERBIT'),
                textInputAction: TextInputAction.next,
                controller: penerbitController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: 'TAHUN TERBIT'),
                textInputAction: TextInputAction.next,
                controller: tahunterbitController,
                onEditingComplete: () {
                  bukus.editbuku(
                    bukuId,
                   kodebukuController.text,
                    judulbukuController.text,
                    pengarangController.text,
                    penerbitController.text,
                     tahunterbitController.text,
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
                    bukus.editbuku(
                      bukuId,
                   kodebukuController.text,
                    judulbukuController.text,
                    pengarangController.text,
                    penerbitController.text,
                     tahunterbitController.text,
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
