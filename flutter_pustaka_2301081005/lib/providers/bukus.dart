import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/buku.dart';

class Bukus with ChangeNotifier {
  final List<buku> _bukus = [];

  List<buku> get allbuku => _bukus;

  int get jumlahbuku => _bukus.length;

  buku selectById(String id) =>
      _bukus.firstWhere((element) => element.id == id);

  Future<void> addbuku(
    String kodebuku,
    String judulbuku,
    String pengarang,
    String penerbit,
    String tahunterbit,
  ) async {
    Uri url = Uri.parse("http://localhost/pustaka_2301081005/buku.php");

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            "kodebuku": kodebuku,
            "judulbuku": judulbuku,
            "pengarang": pengarang,
            "penerbit": penerbit,
            "tahunterbit": tahunterbit,
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _bukus.add(buku(
            id: responseData["id"].toString(),
            kodebuku: kodebuku,
            judulbuku: judulbuku,
            pengarang: pengarang,
            penerbit: penerbit,
            tahunterbit: tahunterbit
          ),
        );
        notifyListeners();
      } else {
        throw Exception("Failed to add buku");
      }
    } catch (error) {
      print("Error: $error");
      throw error;
    }
  }

  void editbuku(
    String id,
    String kodebuku,
    String judulbuku,
    String pengarang,
    String penerbit,
    String tahunterbit,
    BuildContext context,
  ) {
    final selectedbuku = _bukus.firstWhere((buku) => buku.id == id);
    selectedbuku.kodebuku = kodebuku;
    selectedbuku.judulbuku = judulbuku;
    selectedbuku.pengarang = pengarang;
    selectedbuku.penerbit = penerbit;
    selectedbuku.tahunterbit = tahunterbit;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Berhasil diubah"),
        duration: Duration(seconds: 2),
      ),
    );

    notifyListeners();
  }

  void deletebuku(String id, BuildContext context) {
    _bukus.removeWhere((element) => element.id == id);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Berhasil dihapus"),
        duration: Duration(milliseconds: 500),
      ),
    );

    notifyListeners();
  }

  Future<void> initialData() async {
    Uri url = Uri.parse("http://localhost/pustaka_2301081005/buku.php/bukus");

    try {
      final hasilGetData = await http.get(url);

      if (hasilGetData.statusCode == 200) {
        final List<dynamic> dataResponse = json.decode(hasilGetData.body);

        for (var item in dataResponse) {
          _bukus.add(buku (
            id: item["id"],
            kodebuku: item["kodebuku"],
            judulbuku: item["judulbuku"],
            pengarang: item["pengarang"],
            penerbit: item["penerbit"],
            tahunterbit: item["tahunterbit"]
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
