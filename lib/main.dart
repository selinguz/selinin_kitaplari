import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selinin_kitaplari/consts.dart';

import 'pages/add_book_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AcilisSayfasi(),
    );
  }
}

class AcilisSayfasi extends StatefulWidget {
  const AcilisSayfasi({super.key});

  @override
  State<AcilisSayfasi> createState() => _AcilisSayfasiState();
}

class _AcilisSayfasiState extends State<AcilisSayfasi> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1500), () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => const AddBookPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddBookPage(),
              ),
            );
          },
          child: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/background.png',
                  ),
                  fit: BoxFit.cover,
                  opacity: 0.8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(38.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Selin'in Kitapları",
                  style: GoogleFonts.kalam(
                      fontSize: 40, color: ThemeColors.primaryColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
