import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';

class QRPreviewScreen extends StatelessWidget {
  final String qrData;
  final GlobalKey _qrKey = GlobalKey();  // Key pentru captura imaginii QR

  QRPreviewScreen({super.key, required this.qrData});

  Future<void> _saveQRToGallery(BuildContext context) async {
    try {
      // Capturăm imaginea QR
      RenderRepaintBoundary boundary =
      _qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Salvăm imaginea în galeria telefonului
      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/qr_preview_image.png';
      final file = File(path);
      await file.writeAsBytes(pngBytes);

      // Salvăm în galeria telefonului
      await GallerySaver.saveImage(path);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('QR Code saved to gallery!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving QR Code: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Preview')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center( // Centerază tot conținutul
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centrare pe axa principală
            crossAxisAlignment: CrossAxisAlignment.center, // Centrare pe axa transversală
            children: [
              RepaintBoundary(
                key: _qrKey,
                child: Container(
                  color: Colors.white, // Setăm fundalul alb
                  child: QrImageView(
                    data: qrData,
                    version: QrVersions.auto,
                    size: 250.0,
                    backgroundColor: Colors.white, // Fundal alb pentru QR
                    foregroundColor: Colors.black, // Cod negru
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => _saveQRToGallery(context),
                icon: const Icon(Icons.save_alt),
                label: const Text('Save QR to Gallery'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
