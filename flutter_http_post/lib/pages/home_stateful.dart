
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpProvider with ChangeNotifier {
  Map<String, dynamic> _data = {};

  Map<String, dynamic> get data => _data;

  int get jumlahData => _data.length;

  Future<void> connectAPI(String name, String job) async {
    Uri url = Uri.parse("https://reqres.in/api/users");
    final response = await http.post(url, body: jsonEncode({"name": name, "job": job}));
    final hasilResponse = jsonDecode(response.body);
    _data = hasilResponse;
    notifyListeners();
  }
}