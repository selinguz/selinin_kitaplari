import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selinin_kitaplari/consts.dart';

class StaticElevatedButton extends StatefulWidget {
  final String buttonText;
  final double fontSize;
  final Function onPressed;
  const StaticElevatedButton(
      {super.key,
      required this.buttonText,
      required this.fontSize,
      required this.onPressed});

  @override
  State<StaticElevatedButton> createState() => _StaticElevatedButtonState();
}

class _StaticElevatedButtonState extends State<StaticElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ThemeColors.thirdColor,
        elevation: 22.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      onPressed: widget.onPressed(),
      child: Text(
        widget.buttonText,
        style: GoogleFonts.poppins(
          fontSize: widget.fontSize,
          color: ThemeColors.primaryColor,
        ),
      ),
    );
  }
}
