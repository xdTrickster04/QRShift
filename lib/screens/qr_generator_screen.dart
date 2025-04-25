import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../services/qr_storage.dart';
import '../models/qr_item.dart';

class QRGeneratorScreen extends StatefulWidget {
  const QRGeneratorScreen({super.key});

  @override
  State<QRGeneratorScreen> createState() => _QRGeneratorScreenState();
}

class _QRGeneratorScreenState extends State<QRGeneratorScreen> {
  final TextEditingController _controller = TextEditingController();
  String? _qrData;

  Future<void> _generateQR() async {
    final input = _controller.text.trim();
    if (input.isEmpty) return;

    setState(() {
      _qrData = input;
    });

    await QRStorage.saveQR(QRItem(link: input, createdAt: DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Generate QR Code')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Enter text to encode'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateQR,
              child: const Text('Generate QR'),
            ),
            const SizedBox(height: 20),
            if (_qrData != null)
              QrImageView(
                data: _qrData!,
                version: QrVersions.auto,
                size: 200.0,
              ),
          ],
        ),
      ),
    );
  }
}
