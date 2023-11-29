import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selinin_kitaplari/consts.dart';
import 'home_page.dart';

void main() {
  runApp(const AcilisSayfasi());
}

class AcilisSayfasi extends StatefulWidget {
  const AcilisSayfasi({super.key});

  @override
  State<AcilisSayfasi> createState() => _AcilisSayfasiState();
}

class _AcilisSayfasiState extends State<AcilisSayfasi> {
  //@override
  /*void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    });
  }*/

  Widget build(BuildContext context) {
    return MaterialApp(

      home: SafeArea(
        child: Scaffold(
          body: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
            child: Container(
              color: ThemeColors.primaryColor,
              child: Center(
                child: Text(
                  "Selin'\in Kitapları",
                  style: GoogleFonts.poppins(fontSize: 24),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
