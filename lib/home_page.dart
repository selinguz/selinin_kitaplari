import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selinin_kitaplari/list_page.dart';

import 'consts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController kitapAdiController = TextEditingController();
  TextEditingController yazarAdiController = TextEditingController();
  TextEditingController sayfaSayisiController = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kitap Ekle',
          style: GoogleFonts.poppins(
              fontSize: 24, color: ThemeColors.primaryColor),
        ),
        backgroundColor: ThemeColors.thirdColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.book),
                labelText: 'Kitabın Adı',
                labelStyle: GoogleFonts.poppins(fontSize: 16),
              ),
              controller: kitapAdiController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.person),
                labelText: 'Yazarın Adı',
                labelStyle: GoogleFonts.poppins(fontSize: 16),
              ),
              controller: yazarAdiController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ], // Only numbers can be entered
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.collections_bookmark),
                labelText: 'Sayfa Sayısı',
                labelStyle: GoogleFonts.poppins(fontSize: 16),
              ),
              controller: sayfaSayisiController,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0, right: 10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeColors.thirdColor,
                    elevation: 22.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onPressed: () {
                    final book = <String, dynamic>{
                      "bookName": kitapAdiController.text,
                      "authorName": yazarAdiController.text,
                      "pageNumber": int.parse(sayfaSayisiController.text)
                    };
                    db.collection("library").add(book);
                    setState(() {
                      kitapAdiController.clear();
                      yazarAdiController.clear();
                      sayfaSayisiController.clear();
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Kaydet',
                      style: GoogleFonts.poppins(
                          fontSize: 20, color: ThemeColors.primaryColor),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0, left: 10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeColors.thirdColor,
                    elevation: 22.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => BooksListPage(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Listele',
                      style: GoogleFonts.poppins(
                          fontSize: 20, color: ThemeColors.primaryColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 28.0,
          )
        ],
      ),
    );
  }
}
