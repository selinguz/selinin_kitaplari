import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selinin_kitaplari/models/book.dart';
import '../consts.dart';

//TODO Kitaba göre image gelmesi sağlanacak
//TODO Güncelle butonu eklenecek
//TODO Sil butonu eklenecek

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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Kitap Detayı',
            style: GoogleFonts.poppins(
                fontSize: 24, color: ThemeColors.primaryColor),
          ),
          backgroundColor: ThemeColors.thirdColor,
          leading: Icon(
            Icons.arrow_back_ios,
            color: ThemeColors.primaryColor,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(
            10.0,
          ),
          child: Container(
            //width: double.maxFinite,
            padding: const EdgeInsets.all(25.0),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12.5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        width: 150,
                        height: 280,
                        child: Image.asset(
                          'assets/images/birguntekbasina.jpeg',
                        ),
                      ),
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
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 142.0,
                      height: 53.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeColors.thirdColor,
                          elevation: 22.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Güncelle',
                          style: GoogleFonts.poppins(
                              fontSize: 16, color: ThemeColors.primaryColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 142.0,
                      height: 53.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeColors.thirdColor,
                          elevation: 22.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Sil',
                          style: GoogleFonts.poppins(
                              fontSize: 16, color: ThemeColors.primaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
