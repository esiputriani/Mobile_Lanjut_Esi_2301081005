import 'package:flutter_pustaka_2301081005/drawer.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  static const routesName = '/setting';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PERPUSTAKA"),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: Center(
        child: Text(
          "SAMPAI JUMPA KEMBALI",
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}