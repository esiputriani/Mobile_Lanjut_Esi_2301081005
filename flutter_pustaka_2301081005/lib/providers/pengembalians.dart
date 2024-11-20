import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/pengembalian.dart';

class Pengembalians with ChangeNotifier {
  final List<pengembalian> _pengembalians = []; // Perbaikan: Variabel dideklarasikan dengan benar.

  List<pengembalian> get allPengembalian => _pengembalians;

  int get jumlahPengembalian => _pengembalians.length;

  pengembalian selectById(String id) =>
      _pengembalians.firstWhere((element) => element.id == id);

  Future<void> addPengembalian(
    String kodeanggota,
    String tkembali,
    String denda,
    String kodebuku,
  ) async {
    Uri url = Uri.parse(
        "http://localhost/pustaka_2301081005/pengembalian.php/pengembalians");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"}, // Tambahkan header.
        body: json.encode(
          {
            "kode_anggota": kodeanggota,
            "tkembali": tkembali,
            "denda": denda,
            "kodebuku": kodebuku,
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _pengembalians.add(
          pengembalian(
            id: responseData["id"].toString(),
            kodeanggota: kodeanggota,
            tkembali: tkembali,
            denda: denda,
            kodebuku: kodebuku,
          ),
        );
        notifyListeners();
      } else {
        throw Exception("Failed to add pengembalian. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error adding pengembalian: $error");
      throw error;
    }
  }

  void editPengembalian(
    String id,
    String kodeanggota,
    String tkembali,
    String denda,
    String kodebuku,
    BuildContext context,
  ) {
    final selectedPengembalian =
        _pengembalians.firstWhere((pengembalian) => pengembalian.id == id);

    selectedPengembalian.kodeanggota = kodeanggota;
    selectedPengembalian.tkembali = tkembali;
    selectedPengembalian.denda = denda;
    selectedPengembalian.kodebuku = kodebuku;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Berhasil diubah"),
        duration: Duration(seconds: 2),
      ),
    );

    notifyListeners();
  }

  void deletePengembalian(String id, BuildContext context) {
    _pengembalians.removeWhere((element) => element.id == id);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Berhasil dihapus"),
        duration: Duration(milliseconds: 500),
      ),
    );

    notifyListeners();
  }

  Future<void> initialData() async {
    Uri url = Uri.parse("http://localhost/pustaka_2301081005/pengembalian.php");

    try {
      final hasilGetData = await http.get(url);

      if (hasilGetData.statusCode == 200) {
        final List<dynamic> dataResponse = json.decode(hasilGetData.body);

        _pengembalians.clear(); // Bersihkan data lama sebelum menambahkan data baru.
        for (var item in dataResponse) {
          _pengembalians.add(pengembalian(
            id: item["id"],
            kodeanggota: item["kode_anggota"],
            tkembali: item["tkembali"],
            denda: item["denda"],
            kodebuku: item["kodebuku"],
          ));
        }
        print("BERHASIL MASUKKAN DATA LIST");
        notifyListeners();
      } else {
        throw Exception("Failed to load data. Status code: ${hasilGetData.statusCode}");
      }
    } catch (error) {
      print("Error loading data: $error");
      throw error;
    }
  }
}
