import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pengembalians.dart';
import '../pages/add_pengembalian.dart';
import '../pages/detail_pengembalian.dart';

class Pengembalian extends StatefulWidget {
  static const routesName = '/Pengembalian';

  get id => null;

  get denda => null;

  get tkembali => null;

  get kode_anggota => null;

  get kodebuku => null;

  @override
  _PengembalianState createState() => _PengembalianState();
}

class _PengembalianState extends State<Pengembalian> {
  bool isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<Pengembalians>(context, listen: false).initialData();
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final allPengembalianProvider = Provider.of<Pengembalians>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("ALL Pengembalian"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, AddPengembalian.routeName);
            },
          ),
        ],
      ),
      body: (allPengembalianProvider.jumlahPengembalian == 0)
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
                      Navigator.pushNamed(context, AddPengembalian.routeName);
                    },
                    child: Text(
                      "Add Pengembalian",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: allPengembalianProvider.jumlahPengembalian,
              itemBuilder: (context, index) {
                var Pengembalian = allPengembalianProvider.allPengembalian[index];
                return ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      DetailPengembalian.routeName,
                      arguments: Pengembalian.id,
                    );
                  },
                  title: Text(Pengembalian.kodeanggota),
                  trailing: IconButton(
                    onPressed: () {
                      allPengembalianProvider.deletePengembalian(Pengembalian.id, context);
                    },
                    icon: Icon(Icons.delete),
                  ),
                );
              },
            ),
    );
  }
}

