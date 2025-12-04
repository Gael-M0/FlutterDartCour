import 'package:flutter/material.dart';
import 'frutas_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Frutas Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const FrutasScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}