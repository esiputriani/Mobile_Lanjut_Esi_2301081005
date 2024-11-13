import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/anggotas.dart';
import '../pages/add_anggota.dart';
import '../pages/detail_anggota.dart';

class Anggota extends StatefulWidget {
  static const routesName = '/anggota';

  @override
  _AnggotaState createState() => _AnggotaState();
}

class _AnggotaState extends State<Anggota> {
  bool isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<Anggotas>(context, listen: false).initialData();
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final allAnggotaProvider = Provider.of<Anggotas>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("ALL ANGGOTA"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, AddAnggota.routeName);
            },
          ),
        ],
      ),
      body: (allAnggotaProvider.jumlahAnggota == 0)
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
                      Navigator.pushNamed(context, AddAnggota.routeName);
                    },
                    child: Text(
                      "Add Anggota",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: allAnggotaProvider.jumlahAnggota,
              itemBuilder: (context, index) {
                var anggota = allAnggotaProvider.allAnggota[index];
                return ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      DetailAnggota.routeName,
                      arguments: anggota.id,
                    );
                  },
                  title: Text(anggota.kode_anggota),
                  trailing: IconButton(
                    onPressed: () {
                      allAnggotaProvider.deleteAnggota(anggota.id, context);
                    },
                    icon: Icon(Icons.delete),
                  ),
                );
              },
            ),
    );
  }
}
