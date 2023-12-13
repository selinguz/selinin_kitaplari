import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selinin_kitaplari/models/book.dart';
import 'package:selinin_kitaplari/pages/list_page.dart';
import '../consts.dart';

//TODO Kitaba göre image gelmesi sağlanacak
//TODO Güncelle butonu eklenecek

class BookDetailPage extends StatefulWidget {
  final String bookName;
  final String authorName;
  final int sayfaSayisi;
  final String rafBilgisi;
  final String docId;

  const BookDetailPage(
      {super.key,
      required this.bookName,
      required this.authorName,
      required this.sayfaSayisi,
      required this.rafBilgisi,
      required this.docId});

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
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
                      width: 200,
                      height: 350,
                      child: Image.asset(
                        'assets/images/birguntekbasina.jpeg',
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      widget.bookName,
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
                      widget.authorName,
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
                      'Sayfa Sayısı : ${widget.sayfaSayisi}',
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
                      'Bulunduğu Raf : ${widget.rafBilgisi}',
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
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text(
                              "Uyarı",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                              ),
                            ),
                            content: Text(
                              "Kitap Silinsin mi?",
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                              ),
                            ),
                            actions: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: ThemeColors.thirdColor,
                                      elevation: 22.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Text(
                                      "İptal",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        color: ThemeColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15.0,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: ThemeColors.thirdColor,
                                      elevation: 22.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        Book.deleteBook(widget.docId);
                                      });
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const BooksListPage(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Sil",
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: ThemeColors.primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
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
    );
  }
}
