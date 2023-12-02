import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selinin_kitaplari/consts.dart';
import 'package:selinin_kitaplari/models/book.dart';

import 'book_detail_page.dart';

class BooksListPage extends StatefulWidget {
  const BooksListPage({super.key});

  @override
  State<BooksListPage> createState() => _BooksListPageState();
}

class _BooksListPageState extends State<BooksListPage> {
  final Stream<QuerySnapshot> booksStream = FirebaseFirestore.instance
      .collection('library')
      .orderBy('dateTime', descending: true)
      .snapshots();

  late String docId;

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
          color: ThemeColors.primaryColor,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: booksStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                color: Colors.blue,
                thickness: 2.0,
                indent: 5.0,
                endIndent: 5.0,
              ),
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Text(snapshot.data!.docs.length.toString()),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, right: 12.0, bottom: 5.0),
                      child: Card(
                        color: ThemeColors.thirdColor,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ListTile(
                            title: Text(
                              snapshot.data!.docs[index]['bookName'],
                              style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  color: ThemeColors.primaryColor),
                            ),
                            subtitle: Text(
                              snapshot.data!.docs[index]['authorName'],
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
                                docId = snapshot.data!.docs[index].id;

                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        BookDetailPage(
                                      bookName: snapshot.data!.docs[index]
                                          ['bookName'],
                                      authorName: snapshot.data!.docs[index]
                                          ['authorName'],
                                      sayfaSayisi: snapshot.data!.docs[index]
                                          ['pageNumber'.toString()],
                                      rafBilgisi: snapshot.data!.docs[index]
                                          ['shelf'],
                                      docId: docId,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
