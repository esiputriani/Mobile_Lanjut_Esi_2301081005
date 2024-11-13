import 'package:flutter_pustaka_2301081005/home_page.dart';
import 'package:flutter_pustaka_2301081005/pages/home_anggota.dart';
import 'package:flutter_pustaka_2301081005/pages/home_buku.dart';
import 'package:flutter_pustaka_2301081005/pages/home_peminjaman.dart';
import 'package:flutter_pustaka_2301081005/setting_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 160,
            color: Colors.green,
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.all(20),
            child: Text(
              "Menu Pustaka",
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 10),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(Anggota.routesName);
            },
            leading: Icon(Icons.home),
            title: Text("ANGGOTA"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(Buku.routesName);
            },
            leading: Icon(Icons.book),
            title: Text("BUKU"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(Peminjaman.routesName);
            },
            leading: Icon(Icons.library_books),
            title: Text("PEMINJAMAN"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(MyHome.routesName);
            },
            leading: Icon(Icons.assignment_return),
            title: Text("PENGEMBALIAN"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(MyHome.routesName);
            },
            leading: Icon(Icons.money_off),
            title: Text("DENDA"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(SettingPage.routesName);
            },
            leading: Icon(Icons.logout),
            title: Text("Keluar"),
          ),
        ],
      ),
    );
  }
}
