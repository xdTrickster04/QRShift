import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const QRShiftApp());
}

class QRShiftApp extends StatelessWidget {
  const QRShiftApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QRShift',  // Numele aplicației modificat
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.blue[800], // Navy blue
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue[800]!),
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
      },
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final user = snapshot.data;

          if (user != null) {
            // Daca utilizatorul este logat si email-ul este verificat
            if (user.emailVerified) {
              return const HomeScreen();
            } else {
              // Daca email-ul nu e verificat, il delogheaza
              FirebaseAuth.instance.signOut();
              return const LoginScreen();
            }
          }

          return const LoginScreen(); // Daca nu e logat
        },
      ),
    );
  }
}
