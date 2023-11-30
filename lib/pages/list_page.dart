import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selinin_kitaplari/consts.dart';
import 'package:selinin_kitaplari/models/book.dart';
import 'package:selinin_kitaplari/pages/book_detail_page.dart';

class BooksListPage extends StatefulWidget {
  const BooksListPage({super.key});

  @override
  State<BooksListPage> createState() => _BooksListPageState();
}

class _BooksListPageState extends State<BooksListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kitap Listesi',
          style: GoogleFonts.poppins(
              fontSize: 24, color: ThemeColors.primaryColor),
        ),
        backgroundColor: ThemeColors.thirdColor,
      ),
      body: Container(
        child: Book.listBooks(),
      ),
    );
  }
}
