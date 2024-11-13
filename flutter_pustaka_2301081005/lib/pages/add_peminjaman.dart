import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/peminjamans.dart';


class AddPeminjaman extends StatefulWidget {
  static const routeName = '/add-peminjaman';

  @override
  _AddPeminjamanState createState() => _AddPeminjamanState();
}

class _AddPeminjamanState extends State<AddPeminjaman> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController kodeAnggotaController = TextEditingController();
  final TextEditingController tpinjamController = TextEditingController();
  final TextEditingController tkembaliController = TextEditingController();
  final TextEditingController kodebukuController = TextEditingController();

  bool isLoading = false;

  void _submitData() {
    final peminjamansProvider = Provider.of<Peminjamans>(context, listen: false);
    setState(() {
      isLoading = true;
    });

    peminjamansProvider
        .addPeminjaman(
          namaController.text,
          kodeAnggotaController.text,
          tpinjamController.text,
          tkembaliController.text,
          kodebukuController.text,
        )
        .then((response) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Berhasil ditambahkan"),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(context);
    }).catchError((error) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Terjadi kesalahan"),
          duration: Duration(seconds: 2),
        ),
      );
    });
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADD Peminjaman"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _submitData,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            children: [
              Image.asset(
                'assets/logo.png',
                width: 100,
                height: 100,
              ),
              SizedBox(height: 20),
              Text(
                "PUSTAKA KITA",
                style: TextStyle(fontSize: 30),
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: "NAMA PEMINJAMAN"),
                textInputAction: TextInputAction.next,
                controller: namaController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: "KODE ANGGOTA"),
                textInputAction: TextInputAction.next,
                controller: kodeAnggotaController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: "TANGGAL PINJAM"),
                textInputAction: TextInputAction.next,
                controller: tpinjamController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: "TANGGAL KEMBALI"),
                textInputAction: TextInputAction.next,
                controller: tkembaliController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: "KODE BUKU"),
                textInputAction: TextInputAction.done,
                controller: kodebukuController,
                onEditingComplete: _submitData,
              ),
              SizedBox(height: 50),
              isLoading
                  ? CircularProgressIndicator()
                  : Container(
                      width: double.infinity,
                      alignment: Alignment.centerRight,
                      child: OutlinedButton(
                        onPressed: _submitData,
                        child: Text(
                          "Submit",
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

  
