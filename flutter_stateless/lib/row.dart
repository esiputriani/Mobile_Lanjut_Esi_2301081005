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
      body:Row (
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 20,
          height: 200,
          color: Colors.green, 
        ), // Container
        Container(
          width: 10,
          height: 100,
          color: Colors.yellow, 
          ), // Container
          Container(
          width: 50,
          height: 500,
          color: Colors.green, 
        ), // Container
        Container(
          width: 10,
          height: 100,
          color: Colors.yellow, 
          ), // Container
      ],
      ),
      
      ),
      );
}
}