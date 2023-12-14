import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormFieldWithPadding extends StatelessWidget {
  TextFormFieldWithPadding({
    super.key,
    this.inputType,
    required this.controller,
    required this.text,
  });

  final TextEditingController controller;
  final String text;
  late TextInputType? inputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: TextFormField(
        validator: (text) {
          if (text == null || text.isEmpty) {
            return 'Text is empty';
          }
          return null;
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.book),
          labelText: text,
          labelStyle: GoogleFonts.poppins(fontSize: 16),
        ),
        controller: controller,
      ),
    );
  }
}
