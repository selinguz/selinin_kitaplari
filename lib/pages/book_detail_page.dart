import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selinin_kitaplari/models/book.dart';

import '../consts.dart';

class BookDetailPage extends StatelessWidget {
  final String bookName;
  final String authorName;
  final int sayfaSayisi;
  final String rafBilgisi;

  const BookDetailPage(
      {super.key,
      required this.bookName,
      required this.authorName,
      required this.sayfaSayisi,
      required this.rafBilgisi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kitap Detayı',
          style: GoogleFonts.poppins(
              fontSize: 24, color: ThemeColors.primaryColor),
        ),
        backgroundColor: ThemeColors.thirdColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          40.0,
        ),
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(12.5),
          ),
          child: Column(
            children: [
              Image.asset('assets/images/birguntekbasina.jpeg'),
              const SizedBox(
                height: 25,
              ),
              Text(
                bookName,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.blue,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                authorName,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    color: Colors.blue[900],
                    fontWeight: FontWeight.normal,
                    fontSize: 18),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Sayfa Sayısı : ${sayfaSayisi}',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                    fontSize: 12),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Bulunduğu Raf : ${rafBilgisi}',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                    fontSize: 12),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
