import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../utils/qris_generator.dart';

class QRGeneratorScreen extends StatefulWidget {
  const QRGeneratorScreen({super.key});

  @override
  State<QRGeneratorScreen> createState() => _QRGeneratorScreenState();
}

class _QRGeneratorScreenState extends State<QRGeneratorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _qrisController = TextEditingController();
  final _nominalController = TextEditingController();
  String? _generatedQRCode;

  void _generateQRCode() {
    if (_formKey.currentState!.validate()) {
      final qrisString = makeString(
        _qrisController.text,
        {'nominal': _nominalController.text},
      );
      setState(() {
        _generatedQRCode = qrisString;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QRIS Generator'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _qrisController,
                decoration: const InputDecoration(
                  labelText: 'QRIS ID',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter QRIS ID';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nominalController,
                decoration: const InputDecoration(
                  labelText: 'Nominal Amount',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter nominal amount';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _generateQRCode,
                child: const Text('Generate QR Code'),
              ),
              if (_generatedQRCode != null) ...[
                const SizedBox(height: 24),
                Center(
                  child: QrImageView(
                    data: _generatedQRCode!,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _qrisController.dispose();
    _nominalController.dispose();
    super.dispose();
  }
}