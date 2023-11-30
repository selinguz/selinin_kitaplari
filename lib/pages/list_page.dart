import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selinin_kitaplari/consts.dart';
import 'package:selinin_kitaplari/pages/book_detail_page.dart';

class BooksListPage extends StatefulWidget {
  const BooksListPage({super.key});

  @override
  State<BooksListPage> createState() => _BooksListPageState();
}

class _BooksListPageState extends State<BooksListPage> {
  final Stream<QuerySnapshot> _booksStream =
      FirebaseFirestore.instance.collection('library').snapshots();

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
      body: StreamBuilder<QuerySnapshot>(
        stream: _booksStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, right: 12.0, bottom: 5.0),
                    child: Card(
                      color: ThemeColors.thirdColor,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ListTile(
                          title: Text(
                            data['bookName'],
                            style: GoogleFonts.poppins(
                                fontSize: 20, color: ThemeColors.primaryColor),
                          ),
                          subtitle: Text(
                            data['authorName'],
                            style: GoogleFonts.poppins(
                                fontSize: 16, color: Colors.lightGreen[200]),
                          ),
                          leading: Icon(
                            Icons.menu_book,
                            color: ThemeColors.primaryColor,
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.arrow_circle_right_outlined,
                              size: 30.0,
                            ),
                            color: Colors.lightGreen[200],
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      BookDetailPage(
                                    bookName: data['bookName'],
                                    authorName: data['authorName'],
                                    sayfaSayisi: data['pageNumber'.toString()],
                                    rafBilgisi: data['shelf'],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                })
                .toList()
                .cast(),
          );
        },
      ),
    );
  }
}
