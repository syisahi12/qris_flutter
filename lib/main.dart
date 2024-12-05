import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'screens/qr_generator_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QRIS Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const QRGeneratorScreen(),
    );
  }
}