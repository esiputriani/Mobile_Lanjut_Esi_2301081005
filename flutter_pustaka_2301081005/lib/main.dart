import 'package:flutter/material.dart';

import 'package:flutter_pustaka_2301081005/pages/add_buku.dart';
import 'package:flutter_pustaka_2301081005/pages/add_peminjaman.dart';
import 'package:flutter_pustaka_2301081005/pages/detail_buku.dart';
import 'package:flutter_pustaka_2301081005/pages/detail_peminjaman.dart';
import 'package:flutter_pustaka_2301081005/pages/detail_pengembalian.dart';
import 'package:flutter_pustaka_2301081005/pages/home_peminjaman.dart';
import 'package:flutter_pustaka_2301081005/pages/home_pengembalian.dart';
import 'package:flutter_pustaka_2301081005/providers/peminjamans.dart';
import 'package:flutter_pustaka_2301081005/providers/pengembalians.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pustaka_2301081005/pages/add_pengembalian.dart';
import 'package:flutter_pustaka_2301081005/home_page.dart';
import 'package:flutter_pustaka_2301081005/pages/home_anggota.dart';
import 'package:flutter_pustaka_2301081005/pages/home_buku.dart';
import 'package:flutter_pustaka_2301081005/pages/add_anggota.dart';
import 'package:flutter_pustaka_2301081005/pages/detail_anggota.dart';

import 'package:flutter_pustaka_2301081005/setting_page.dart';
import 'package:flutter_pustaka_2301081005/providers/anggotas.dart'; 
import 'package:flutter_pustaka_2301081005/providers/bukus.dart'; 
 
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Anggotas()),
        ChangeNotifierProvider(create: (context) => Bukus()),
        ChangeNotifierProvider(create: (context) => Peminjamans()), 
        ChangeNotifierProvider(create: (context) => Pengembalians()), 
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHome(),
        routes: {
          MyHome.routesName: (context) => MyHome(),
          Anggota.routesName: (context) => Anggota(),
          Buku.routesName: (context) => Buku(),
          Peminjaman.routesName: (context) => Peminjaman(),
          Pengembalian.routesName: (context) => Pengembalian(),
          DetailAnggota.routeName: (context) => DetailAnggota(),
          DetailBuku.routeName: (context) => DetailBuku(),
           DetailPeminjaman.routeName: (context) => DetailPeminjaman(),
           DetailPengembalian.routeName: (context) => DetailPengembalian(),
          AddAnggota.routeName: (context) => AddAnggota(),
          AddBuku.routeName: (context) => AddBuku(),
          AddPeminjaman.routeName: (context) => AddPeminjaman(),
          AddPengembalian.routeName: (context) => AddPengembalian(),
          SettingPage.routesName: (context) => SettingPage(),
        },
      ),
    );
  }
}

