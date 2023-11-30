import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import '../consts.dart';
import '../pages/book_detail_page.dart';

//TODO Ekleme, silme, güncelleme metodları buraya alınacak

class Book {
  final String bookName;
  final String authorName;
  final int pageNumber;
  final String shelf;

  Book(
      {required this.bookName,
      required this.authorName,
      required this.pageNumber,
      required this.shelf});

  static void addBook(Book book) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection('library').add({
      'bookName': book.bookName,
      'authorName': book.authorName,
      'pageNumber': book.pageNumber,
      'shelf': book.shelf,
    });
  }

  static StreamBuilder listBooks() {
    final Stream<QuerySnapshot> _booksStream =
        FirebaseFirestore.instance.collection('library').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _booksStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map(
            (DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Padding(
                padding:
                    const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0),
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
                              builder: (BuildContext context) => BookDetailPage(
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
            },
          ).toList(),
        );
      },
    );
  }
}
