import 'package:flutter/material.dart';

void main() {
  runApp( MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
      return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
      appBar: AppBar(
        title: Text("My App"), 
      ), // AppBar
      body: Column (
      children: [
        Container(
          width: 200,
          height: 20,
          color: Colors.green, 
        ), // Container
        Container(
          width: 100,
          height: 20,
          color: Colors.yellow, 
          ), // Container
          Container(
          width: 200,
          height: 20,
          color: Colors.green, 
        ), // Container
        Container(
          width: 100,
          height: 20,
          color: Colors.yellow, 
          ), // Container
      ],
      ),
      
      ),
      );
}
}