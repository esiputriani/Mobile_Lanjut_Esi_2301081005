import 'package:flutter_pustaka_2301081005/drawer.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  static const routesName = '/setting';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text(""),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 200, // Atur lebar logo
              height: 200, // Atur tinggi logo
            ),
            SizedBox(height: 20), // Menambahkan jarak antara logo dan teks
            Text(
              "SAMPAI JUMPA KEMBALI",
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
