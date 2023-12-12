import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selinin_kitaplari/consts.dart';

class DropDownField extends StatefulWidget {
  const DropDownField({super.key});

  @override
  State<DropDownField> createState() => _DropDownFieldState();
}

class _DropDownFieldState extends State<DropDownField> {
  List<String> options = <String>['Sağ 1', 'Sağ 2', 'Sağ 3', 'Sol 1'];
  String dropdownValue = 'Sağ 1';
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
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
      icon: const Padding(
        padding: EdgeInsets.only(right: 8.0),
        child: Icon(
          Icons.keyboard_arrow_down,
          color: Colors.grey,
          size: 30.0,
        ),
      ),
      dropdownColor: ThemeColors.primaryColor,
    );
  }
}
