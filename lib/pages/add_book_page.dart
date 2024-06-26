import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selinin_kitaplari/firebase/firebase.dart';
import 'package:selinin_kitaplari/models/book.dart';
import 'package:selinin_kitaplari/pages/data_table_page.dart';
import 'package:selinin_kitaplari/pages/list_page.dart';
import 'package:selinin_kitaplari/widgets.dart/text_form_field_with_padding.dart';

import '../consts.dart';

//TODO #5 image ekleme yapılacak
//TODO sayfasayısı alanında harf yazılmasına izin veriyor, kayıt aşamasında hata alınıyor, textInputNumber yapıldı ama çalışmıyor

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  late TextEditingController kitapAdiController;
  late TextEditingController yazarAdiController;
  late TextEditingController sayfaSayisiController;

  final _formKey = GlobalKey<FormState>();

  List<String> options = [];
  String dropdownValue = '';

  @override
  void initState() {
    kitapAdiController = TextEditingController();
    yazarAdiController = TextEditingController();
    sayfaSayisiController = TextEditingController();
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
              inputType: TextInputType.number,
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
                        dropdownValue = value!;
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
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (builder) => const DataTablePage(),
                  ),
                );
              },
              child: const Text('DataTable'),
            ),
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
                          FirebaseDB.addBook(
                            Book(
                                bookName: kitapAdiController.text,
                                authorName: yazarAdiController.text,
                                pageNumber:
                                    int.parse(sayfaSayisiController.text),
                                shelf: dropdownValue),
                          );
                          kitapAdiController.clear();
                          yazarAdiController.clear();
                          sayfaSayisiController.clear();
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
