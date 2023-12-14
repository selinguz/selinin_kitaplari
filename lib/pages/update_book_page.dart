import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selinin_kitaplari/firebase/firebase.dart';
import 'package:selinin_kitaplari/models/book.dart';
import 'package:selinin_kitaplari/widgets.dart/text_form_field_with_padding.dart';

import '../consts.dart';

class UpdateBookPage extends StatefulWidget {
  final String bookName;
  final String authorName;
  final int pageNumber;
  final String shelf;
  final String docId;

  const UpdateBookPage(
      {super.key,
      required this.bookName,
      required this.authorName,
      required this.pageNumber,
      required this.shelf,
      required this.docId});

  @override
  State<UpdateBookPage> createState() => _UpdateBookPageState();
}

class _UpdateBookPageState extends State<UpdateBookPage> {
  late TextEditingController kitapAdiController;
  late TextEditingController yazarAdiController;
  late TextEditingController sayfaSayisiController;

  final _formKey = GlobalKey<FormState>();

  List<String> options = [];
  String dropdownValue = '';

  @override
  void initState() {
    kitapAdiController = TextEditingController(text: widget.bookName);
    yazarAdiController = TextEditingController(text: widget.authorName);
    sayfaSayisiController =
        TextEditingController(text: widget.pageNumber.toString());
    FirebaseDB.getShelfData().then((value) {
      setState(() {
        options = value;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    kitapAdiController.dispose();
    yazarAdiController.dispose();
    sayfaSayisiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Güncelle',
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
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextFormFieldWithPadding(
              controller: kitapAdiController,
              text: widget.bookName,
            ),
            TextFormFieldWithPadding(
              controller: yazarAdiController,
              text: widget.authorName,
            ),
            TextFormFieldWithPadding(
              controller: sayfaSayisiController,
              text: widget.pageNumber.toString(),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ThemeColors.fourthColor,
                    style: BorderStyle.solid,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: SizedBox(
                  width: 400,
                  child: DropdownButtonFormField(
                    value: dropdownValue,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.shelves),
                      labelText: 'Raf Bilgisi',
                      labelStyle: GoogleFonts.poppins(fontSize: 20),
                    ),
                    items:
                        options.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = widget.shelf;
                      });
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    dropdownColor: ThemeColors.primaryColor,
                  ),
                ),
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
                      setState(() {
                        FirebaseDB.deleteBook(widget.docId);
                        FirebaseDB.addBook(
                          Book(
                              bookName: kitapAdiController.text,
                              authorName: yazarAdiController.text,
                              pageNumber: int.parse(sayfaSayisiController.text),
                              shelf: dropdownValue),
                        );
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: ThemeColors.thirdColor,
                          content: SizedBox(
                            height: 45.0,
                            child: Center(
                              child: Text(
                                'Güncellendi!',
                                style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    color: ThemeColors.primaryColor),
                              ),
                            ),
                          ),
                          duration: const Duration(milliseconds: 2000),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Güncelle',
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
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'İptal',
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
      ),
    );
  }
}
