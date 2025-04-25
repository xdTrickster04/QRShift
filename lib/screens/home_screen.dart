import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'qr_generator_screen.dart';
import 'qr_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QRShift Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => FirebaseAuth.instance.signOut(),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.qr_code),
              label: const Text('Generate QR Code'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const QRGeneratorScreen()));
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.history),
              label: const Text('QR Code History'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const QRListScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
