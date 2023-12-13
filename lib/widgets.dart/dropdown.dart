import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selinin_kitaplari/consts.dart';

class DropDownField extends StatefulWidget {
  const DropDownField({super.key});

  @override
  State<DropDownField> createState() => _DropDownFieldState();
}

class _DropDownFieldState extends State<DropDownField> {
  List<String> options = [];
  String dropdownValue = '';
  Future<List<String>> getShelfData() async {
    List<String> tempList = [];
    await FirebaseFirestore.instance
        .collection('library')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                if (!tempList.contains(doc.get('shelf'))) {
                  tempList.add(doc.get('shelf'));
                }
              }),
            });

    return tempList;
  }

  @override
  void initState() {
    getShelfData().then((value) {
      setState(() {
        options = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: DropdownButtonFormField(
        value: dropdownValue,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.shelves),
          labelText: 'Raf Bilgisi',
          labelStyle: GoogleFonts.poppins(fontSize: 20),
        ),
        items: options.map<DropdownMenuItem<String>>((String value) {
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
    );
  }
}
