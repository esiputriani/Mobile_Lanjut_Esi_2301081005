import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/anggotas.dart';

class DetailAnggota extends StatefulWidget {
  static const routeName = '/detail-anggota'; 

  @override
  _AnggotaState createState() => _AnggotaState();
}

class _AnggotaState extends State<DetailAnggota> {
  @override
  Widget build(BuildContext context) {
    final anggotas = Provider.of<Anggotas>(context, listen: false);
    final anggotaId = ModalRoute.of(context)!.settings.arguments as String;

    // Dapatkan anggota berdasarkan ID
    final selectAnggota = anggotas.selectById(anggotaId);

    // Inisialisasi controller dengan handling null
    final TextEditingController kode_anggotaController = TextEditingController(
      text: selectAnggota?.kode_anggota ?? '',
    );
    final TextEditingController nama_anggotaController = TextEditingController(
      text: selectAnggota?.nama_anggota ?? '',
    );
    final TextEditingController jenis_kelaminController = TextEditingController(
      text: selectAnggota?.jenis_kelamin ?? '',
    );
    final TextEditingController alamatController = TextEditingController(
      text: selectAnggota?.alamat ?? '',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("DETAIL ANGGOTA"),
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
                controller: kode_anggotaController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: 'Nama Anggota'),
                textInputAction: TextInputAction.next,
                controller: nama_anggotaController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: 'Jenis Kelamin'),
                textInputAction: TextInputAction.next,
                controller: jenis_kelaminController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: 'Alamat'),
                textInputAction: TextInputAction.next,
                controller: alamatController,
                onEditingComplete: () {
                  anggotas.editAnggota(
                    anggotaId,
                    kode_anggotaController.text,
                    nama_anggotaController.text,
                    jenis_kelaminController.text,
                    alamatController.text,
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
                    anggotas.editAnggota(
                      anggotaId,
                      kode_anggotaController.text,
                      nama_anggotaController.text,
                      jenis_kelaminController.text,
                      alamatController.text,
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
