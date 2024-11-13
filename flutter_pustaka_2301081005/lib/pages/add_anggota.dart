import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/anggotas.dart';

class AddAnggota extends StatefulWidget {
  static const routeName = '/add-anggota';

  @override
  _AddAnggotaState createState() => _AddAnggotaState();
}

class _AddAnggotaState extends State<AddAnggota> {
  final TextEditingController kodeAnggotaController = TextEditingController();
  final TextEditingController namaAnggotaController = TextEditingController();
  final TextEditingController jenisKelaminController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();

  bool isLoading = false;

  void _submitData() {
    final players = Provider.of<Anggotas>(context, listen: false);
    setState(() {
      isLoading = true;
    });

    players
        .addAnggota(
          kodeAnggotaController.text,
          namaAnggotaController.text,
          jenisKelaminController.text,
          alamatController.text,
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
        title: Text("ADD Anggota"),
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
                controller: kodeAnggotaController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: "NAMA ANGGOTA"),
                textInputAction: TextInputAction.next,
                controller: namaAnggotaController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: "JENIS KELAMIN"),
                textInputAction: TextInputAction.next,
                controller: jenisKelaminController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: "ALAMAT"),
                textInputAction: TextInputAction.done,
                controller: alamatController,
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
