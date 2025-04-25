import 'package:flutter/material.dart';
import '../models/qr_item.dart';
import '../services/qr_storage.dart';
import 'qr_preview_screen.dart';

class QRListScreen extends StatefulWidget {
  const QRListScreen({super.key});

  @override
  State<QRListScreen> createState() => _QRListScreenState();
}

class _QRListScreenState extends State<QRListScreen> {
  List<QRItem> _qrItems = [];

  @override
  void initState() {
    super.initState();
    _loadQRs();
  }

  Future<void> _loadQRs() async {
    final items = await QRStorage.loadQRs();
    setState(() {
      _qrItems = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Code History')),
      body: _qrItems.isEmpty
          ? const Center(child: Text('No QR codes generated yet.'))
          : ListView.builder(
        itemCount: _qrItems.length,
        itemBuilder: (context, index) {
          final item = _qrItems[index];
          return ListTile(
            title: Text(item.link),
            subtitle: Text(item.createdAt.toLocal().toString()),
            trailing: const Icon(Icons.qr_code),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => QRPreviewScreen(qrData: item.link),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
