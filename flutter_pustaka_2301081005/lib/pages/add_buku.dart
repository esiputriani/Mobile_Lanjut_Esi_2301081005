import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/bukus.dart';

class AddBuku extends StatefulWidget {
  static const routeName = '/add-buku';

  @override
  _AddBukuState createState() => _AddBukuState();
}

class _AddBukuState extends State<AddBuku> {
  final TextEditingController kodebukuController = TextEditingController();
  final TextEditingController judulbukuController = TextEditingController();
  final TextEditingController pengarangController = TextEditingController();
  final TextEditingController penerbitController = TextEditingController();
final TextEditingController tahunterbitController = TextEditingController();

  bool isLoading = false;

  void _submitData() {
    final players = Provider.of<Bukus>(context, listen: false);
    setState(() {
      isLoading = true;
    });

    players
        .addbuku(
         kodebukuController.text,
         judulbukuController.text,
          pengarangController.text,
          penerbitController.text,
          tahunterbitController.text,
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
        title: Text("ADD Buku"),
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
                decoration: InputDecoration(labelText: "KODE Buku"),
                textInputAction: TextInputAction.next,
                controller: kodebukuController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: "JUDUL BUKU"),
                textInputAction: TextInputAction.next,
                controller: judulbukuController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: "PENGARANG"),
                textInputAction: TextInputAction.next,
                controller: pengarangController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: "PENERBIT"),
                textInputAction: TextInputAction.done,
                controller: penerbitController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: "TAHUN TERBIT"),
                textInputAction: TextInputAction.done,
                controller:tahunterbitController,
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
