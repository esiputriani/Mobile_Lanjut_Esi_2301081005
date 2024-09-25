import 'package:flutter/material.dart';

void main() {
  runApp( MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
      return MaterialApp(
     
      home: Scaffold(
      appBar: AppBar(
        title: Text("List tile"), 
      ), // AppBar
      body: ListView(
        children: [
        ListTile(
          title: Text("Sanndikha Rahardi"),
          subtitle: Text("This is subtitle okay.."),
          leading: CircleAvatar(),
          trailing: Text("10:00 pm"),
        )
        ]
      ),
      
      ),
      );
}
}