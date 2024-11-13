import 'package:flutter/material.dart';
import 'package:flutter_pustaka_2301081005/pages/add_peminjaman.dart';
import 'package:flutter_pustaka_2301081005/pages/detail_peminjaman.dart';
import 'package:flutter_pustaka_2301081005/providers/peminjamans.dart';
import 'package:provider/provider.dart';


class Peminjaman extends StatefulWidget {
  static const routesName = '/peminjaman';

  @override
  _PeminjamanState createState() => _PeminjamanState();
}

class _PeminjamanState extends State<Peminjaman> {
  bool isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<Peminjamans>(context, listen: false).initialData();
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final allPeminjamanProvider = Provider.of<Peminjamans>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("DAFTAR SEMUA PEMINJAMAN"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, AddPeminjaman.routeName);
            },
          ),
        ],
      ),
      body: (allPeminjamanProvider.jumlahpeminjaman == 0)
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No Data",
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AddPeminjaman.routeName);
                    },
                    child: Text(
                      "Add Peminjaman",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: allPeminjamanProvider.jumlahpeminjaman,
              itemBuilder: (context, index) {
                var peminjaman = allPeminjamanProvider.allbuku[index];
                return ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      DetailPeminjaman.routeName,
                      arguments: peminjaman.id,
                    );
                  },
                  title: Text(peminjaman.nama),
                  trailing: IconButton(
                    onPressed: () {
                      allPeminjamanProvider.deletepeminjaman(peminjaman.id, context);
                    },
                    icon: Icon(Icons.delete),
                  ),
                );
              },
            ),
    );
  }
}
