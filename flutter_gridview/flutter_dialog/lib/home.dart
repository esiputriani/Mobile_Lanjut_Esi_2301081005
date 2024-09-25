import 'package:flutter/material.dart';
class MyHomePage extends StatefulWidget{
  @override
  State<MyHomePage> createState() => _MyHomepageState();

}

class _MyHomepageState extends State<MyHomePage>{
  String data ="Belum ada input";
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Dialog"),
      ),
      body: Center(
        child:Text(data,
        style: TextStyle(fontSize: 30),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        print("Telah Di Klik");
        showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: Text("OK"),
              content: Text("Apakah Di Hapus?"),
              actions: [
                ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pop ();
                    setState(() {
                  data = "TRUE";
                  });
                
                },
                child: Text("YES")),
                ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                    setState(() {
                      data = "FALSE";
                    });
                  },
                  child: Text("NO"))
              ],
            );
          },
        ).then((value) => print(value));
      },
      child: Icon(Icons.delete),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

}