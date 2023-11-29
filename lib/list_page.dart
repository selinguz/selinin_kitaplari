import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selinin_kitaplari/consts.dart';

class BooksListPage extends StatefulWidget {
  const BooksListPage({super.key});

  @override
  State<BooksListPage> createState() => _BooksListPageState();
}

class _BooksListPageState extends State<BooksListPage> {
  List<String> books = [];

  final Stream<QuerySnapshot> _booksStream =
      FirebaseFirestore.instance.collection('library').snapshots();

  /*FirebaseFirestore.instance.collection("library").get().then((value) {
  value.docs.foreach((item) {
  names.add(item.get("name"));
  });
  });*/

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
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      color: ThemeColors.thirdColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
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
                          trailing: CircleAvatar(
                            backgroundColor: ThemeColors.primaryColor,
                            radius: 25,
                            child: Text(
                              data['pageNumber'].toString(),
                            ),
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
