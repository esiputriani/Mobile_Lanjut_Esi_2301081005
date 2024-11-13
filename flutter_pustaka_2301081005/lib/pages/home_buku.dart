import 'package:flutter/material.dart';
import 'package:flutter_pustaka_2301081005/pages/add_buku.dart';
import 'package:flutter_pustaka_2301081005/providers/bukus.dart';
import 'package:provider/provider.dart';
import '../providers/bukus.dart';
import '../pages/detail_anggota.dart';

class Buku extends StatefulWidget {
  static const routesName = '/buku';

  @override
  _BukuState createState() => _BukuState();
}

class _BukuState extends State<Buku> {
  bool isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<Bukus>(context, listen: false).initialData();
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final allBukuProvider = Provider.of<Bukus>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("DAFTAR SEMUA BUKU"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, AddBuku.routeName);
            },
          ),
        ],
      ),
      body: (allBukuProvider.jumlahbuku == 0)
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
                      Navigator.pushNamed(context, AddBuku.routeName);
                    },
                    child: Text(
                      "Add Buku",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: allBukuProvider.jumlahbuku,
              itemBuilder: (context, index) {
                var anggota = allBukuProvider.allbuku[index];
                return ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      DetailAnggota.routeName,
                      arguments: anggota.id,
                    );
                  },
                  title: Text(anggota.kodebuku),
                  trailing: IconButton(
                    onPressed: () {
                      allBukuProvider.deletebuku(anggota.id, context);
                    },
                    icon: Icon(Icons.delete),
                  ),
                );
              },
            ),
    );
  }
}
