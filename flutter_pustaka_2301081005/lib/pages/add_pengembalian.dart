import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pengembalians.dart';

class AddPengembalian extends StatefulWidget {
  static const routeName = '/add-pengembalian';

  @override
  _AddPengembalianState createState() => _AddPengembalianState();
}

class _AddPengembalianState extends State<AddPengembalian> {
  final TextEditingController kodeanggotaController = TextEditingController();
  final TextEditingController tkembaliController = TextEditingController();
  final TextEditingController dendaController = TextEditingController();
  final TextEditingController kodebukuController = TextEditingController();

  bool isLoading = false;

  void _submitData() {
    final players = Provider.of<Pengembalians>(context, listen: false);
    setState(() {
      isLoading = true;
    });

    players
        .addPengembalian(
         kodeanggotaController.text,
           tkembaliController.text,
          dendaController.text,
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
        title: Text("ADD PENGEMBALIAN"),
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
                autofocus: true,
                decoration: InputDecoration(labelText: "KODE ANGGOTA"),
                textInputAction: TextInputAction.next,
                controller:kodeanggotaController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: "TANGGAL KEMBLAI"),
                textInputAction: TextInputAction.next,
                controller:  tkembaliController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: "DENDA : RP "),
                textInputAction: TextInputAction.next,
                controller: dendaController,
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
