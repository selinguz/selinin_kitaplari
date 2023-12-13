import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selinin_kitaplari/models/book.dart';
import 'package:selinin_kitaplari/pages/list_page.dart';
import 'package:selinin_kitaplari/pages/page.dart';
import 'package:selinin_kitaplari/widgets.dart/dropdown.dart';
import 'package:selinin_kitaplari/widgets.dart/textFormFieldWithPadding.dart';

import '../consts.dart';

//TODO #5 image ekleme yapılacak

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  late TextEditingController kitapAdiController;
  late TextEditingController yazarAdiController;
  late TextEditingController sayfaSayisiController;
  late TextEditingController rafBilgisiController;

  @override
  void initState() {
    kitapAdiController = TextEditingController();
    yazarAdiController = TextEditingController();
    sayfaSayisiController = TextEditingController();
    rafBilgisiController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    kitapAdiController.dispose();
    yazarAdiController.dispose();
    sayfaSayisiController.dispose();
    rafBilgisiController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

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
              text: 'Kitabın Adı',
            ),
            TextFormFieldWithPadding(
              controller: yazarAdiController,
              text: 'Yazarın Adı',
            ),
            TextFormFieldWithPadding(
              controller: sayfaSayisiController,
              text: 'Sayfa Sayısı',
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
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyPage(),
                      ),
                    );
                  },
                  child: const DropDownField(),
                ),
              ),

              /*TextFormField(
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Text is empty';
                  }
                  return null;
                },
                // Only numbers can be entered
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.night_shelter_outlined),
                  labelText: 'Bulunduğu Raf',
                  labelStyle: GoogleFonts.poppins(fontSize: 16),
                ),
                controller: rafBilgisiController,
              ),*/
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
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          Book.addBook(Book(
                              bookName: kitapAdiController.text,
                              authorName: yazarAdiController.text,
                              pageNumber: int.parse(sayfaSayisiController.text),
                              shelf: rafBilgisiController.text));
                          kitapAdiController.clear();
                          yazarAdiController.clear();
                          sayfaSayisiController.clear();
                          rafBilgisiController.clear();
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: ThemeColors.thirdColor,
                            content: SizedBox(
                              height: 45.0,
                              child: Center(
                                child: Text(
                                  'Kaydedildi!',
                                  style: GoogleFonts.poppins(
                                      fontSize: 24,
                                      color: ThemeColors.primaryColor),
                                ),
                              ),
                            ),
                            duration: const Duration(milliseconds: 2000),
                          ),
                        );
                      }
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
                          builder: (BuildContext context) =>
                              const BooksListPage(),
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
      ),
    );
  }
}
