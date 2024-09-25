import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Fitted Box"),
        ),
        body: Center(
          child: Container(
            color: Colors.blue,

            child: FittedBox(
              alignment: Alignment.centerRight,
              child: Image.network("https:/piscum.photos/500/5"),
            ),
          ),
        )
      ),
         );
  }
}

