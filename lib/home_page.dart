import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController kitapAdiController = TextEditingController();
  TextEditingController yazarAdiAdiController = TextEditingController();
  TextEditingController sayfaSayisiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Kitap Ekle',
            style: GoogleFonts.poppins(fontSize: 24),
          ),
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
                controller: yazarAdiAdiController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
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
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        'Kaydet',
                        style: GoogleFonts.poppins(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 18.0, left: 10.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        'Listele',
                        style: GoogleFonts.poppins(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
