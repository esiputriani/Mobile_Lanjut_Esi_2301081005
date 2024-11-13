import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/anggota.dart';

class Anggotas with ChangeNotifier {
  final List<Anggota> _anggotas = [];

  List<Anggota> get allAnggota => _anggotas;

  int get jumlahAnggota => _anggotas.length;

  Anggota selectById(String id) =>
      _anggotas.firstWhere((element) => element.id == id);

  Future<void> addAnggota(
    String kodeAnggota,
    String namaAnggota,
    String jenisKelamin,
    String alamat,
  ) async {
    Uri url = Uri.parse("http://localhost/pustaka_2301081005/anggota.php/anggotas");

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            "kode_anggota": kodeAnggota,
            "nama_anggota": namaAnggota,
            "jenis_kelamin": jenisKelamin,
            "alamat": alamat,
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _anggotas.add(
          Anggota(
            id: responseData["id"].toString(),
            kode_anggota: kodeAnggota,
            nama_anggota: namaAnggota,
            jenis_kelamin: jenisKelamin,
            alamat: alamat,
          ),
        );
        notifyListeners();
      } else {
        throw Exception("Failed to add anggota");
      }
    } catch (error) {
      print("Error: $error");
      throw error;
    }
  }

  void editAnggota(
    String id,
    String kodeAnggota,
    String namaAnggota,
    String jenisKelamin,
    String alamat,
    BuildContext context,
  ) {
    final selectedAnggota = _anggotas.firstWhere((anggota) => anggota.id == id);
    selectedAnggota.kode_anggota = kodeAnggota;
    selectedAnggota.nama_anggota = namaAnggota;
    selectedAnggota.jenis_kelamin = jenisKelamin;
    selectedAnggota.alamat = alamat;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Berhasil diubah"),
        duration: Duration(seconds: 2),
      ),
    );

    notifyListeners();
  }

  void deleteAnggota(String id, BuildContext context) {
    _anggotas.removeWhere((element) => element.id == id);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Berhasil dihapus"),
        duration: Duration(milliseconds: 500),
      ),
    );

    notifyListeners();
  }

  Future<void> initialData() async {
    Uri url = Uri.parse("http://localhost/pustaka_2301081005/anggota.php");
    

    try {
      final hasilGetData = await http.get(url);

      if (hasilGetData.statusCode == 200) {
        final List<dynamic> dataResponse = json.decode(hasilGetData.body);

        for (var item in dataResponse) {
          _anggotas.add(Anggota(
            id: item["id"],
            kode_anggota: item["kode_anggota"],
            nama_anggota: item["nama_anggota"],
            jenis_kelamin: item["jenis_kelamin"],
            alamat: item["alamat"],
          ));
        }
        print("BERHASIL MASUKAN DATA LIST");
        notifyListeners();
      } else {
        throw Exception("Failed to load data");
      }
    } catch (error) {
      print("Error: $error");
      throw error;
    }
  }
}
