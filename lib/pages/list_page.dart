import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selinin_kitaplari/consts.dart';
import 'package:selinin_kitaplari/firebase/firebase.dart';
import 'package:selinin_kitaplari/widgets.dart/bottom_nav_bar.dart';
import 'package:selinin_kitaplari/widgets.dart/search_input.dart';
import '../models/book.dart';
import 'book_detail_page.dart';

/// ! Bottom nav bar refactor edilecek
///

class BooksListPage extends StatefulWidget {
  const BooksListPage({super.key});

  @override
  State<BooksListPage> createState() => _BooksListPageState();
}

class _BooksListPageState extends State<BooksListPage> {
  List<Book> books = [];
  TextEditingController kitapAdiController = TextEditingController();

  @override
  void initState() {
    FirebaseDB.getBookList().then((value) {
      setState(() {
        books = value;
      });
    });
    super.initState();
  }

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(17.0),
            child: SearchInput(
                textController: kitapAdiController,
                hintText: 'Kitap '
                    'Ara...'),
          ),
          Flexible(
              child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
              color: Colors.blue,
              thickness: 0.2,
              indent: 5.0,
              endIndent: 5.0,
            ),
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: books.length,
            itemBuilder: (context, index) {
              var book = books[index];
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, right: 12.0, bottom: 5.0),
                    child: Card(
                      color: ThemeColors.thirdColor,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ListTile(
                          title: Text(
                            book.bookName,
                            style: GoogleFonts.poppins(
                                fontSize: 20, color: ThemeColors.primaryColor),
                          ),
                          subtitle: Text(
                            book.authorName,
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
                              Navigator.pushReplacement<void, void>(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      BookDetailPage(
                                    bookName: book.bookName,
                                    authorName: book.authorName,
                                    pageNumber: book.pageNumber,
                                    shelf: book.shelf,
                                    docId: book.bookId!,
                                  ),
                                ),
                              );
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (BuildContext context) =>
                              //         BookDetailPage(
                              //       bookName: book.bookName,
                              //       authorName: book.authorName,
                              //       pageNumber: book.pageNumber,
                              //       shelf: book.shelf,
                              //       docId: book.bookId!,
                              //     ),
                              //   ),
                              // );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          )),
        ],
      ),
      bottomNavigationBar: const SpecBottomNavBar(),
    );
  }
}
