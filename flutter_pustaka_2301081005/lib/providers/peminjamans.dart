import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/peminjaman.dart';


class Peminjamans with ChangeNotifier {
  final List<peminjaman> _peminjaman = [];

  List<peminjaman> get allbuku => _peminjaman;

  int get jumlahpeminjaman => _peminjaman.length;

  peminjaman selectById(String id) =>
      _peminjaman.firstWhere((element) => element.id == id);

  Future<void> addbuku(
    String nama,
    String kode_anggota,
    String tpinjam,
    String tkembali,
    String kodebuku,
  ) async {
    Uri url = Uri.parse("http://localhost/pustaka_2301081005/peminjaman.php");

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            "nama": nama,
            "kode_anggota": kode_anggota,
            "tpinjam": tpinjam,
            "tkembali": tkembali,
            "kodebuku": kodebuku,
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _peminjaman.add(peminjaman( 
          id: responseData["id"].toString(),
          nama: nama,
          kode_anggota: kode_anggota,
          tkembali: tkembali,
          tpinjam: tpinjam,
          kodebuku: kodebuku,
        ));
        notifyListeners();
      } else {
        throw Exception("Failed to add buku");
      }
    } catch (error) {
      print("Error: $error");
      throw error;
    }
  }

  void editpeminjaman(
    String id,
    String nama,
    String kode_anggota,
    String tpinjam,
    String tkembali,
    String kodebuku,
    BuildContext context, // Tambahkan context
  ) {
    final selectedpeminjaman = _peminjaman.firstWhere((peminjaman) => peminjaman.id == id);
    selectedpeminjaman.nama = nama;
    selectedpeminjaman.kode_anggota = kode_anggota;
    selectedpeminjaman.tpinjam = tpinjam;
    selectedpeminjaman.tkembali = tkembali;
    selectedpeminjaman.kodebuku = kodebuku;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Berhasil diubah"),
        duration: Duration(seconds: 2),
      ),
    );

    notifyListeners();
  }

  void deletepeminjaman(String id, BuildContext context) {
    _peminjaman.removeWhere((element) => element.id == id);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Berhasil dihapus"),
        duration: Duration(milliseconds: 500),
      ),
    );

    notifyListeners();
  }

  Future<void> initialData() async {
    Uri url = Uri.parse("http://localhost/pustaka_2301081005/peminjaman.php/peminjamans");

    try {
      final hasilGetData = await http.get(url);

      if (hasilGetData.statusCode == 200) {
        final List<dynamic> dataResponse = json.decode(hasilGetData.body);

        for (var item in dataResponse) {
          _peminjaman.add(peminjaman(
            id: item["id"],
            nama: item["nama"],
            kode_anggota: item["kode_anggota"],
            tpinjam: item["tpinjam"],
            tkembali: item["tkembali"],
            kodebuku: item["kodebuku"],
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

  addPeminjaman(String text, String text2, String text3, String text4, String text5) {}
}
