import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selinin_kitaplari/consts.dart';

//TODO Datatable a veriler dinamik olarak gelecek

class DataTablePage extends StatefulWidget {
  const DataTablePage({super.key});

  @override
  State<DataTablePage> createState() => _DataTablePageState();
}

class _DataTablePageState extends State<DataTablePage> {
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
          color: ThemeColors.primaryColor,
        ),
      ),
      backgroundColor: ThemeColors.primaryColor,
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DataTable(
              headingRowColor: MaterialStateProperty.resolveWith(
                  (states) => ThemeColors.secondaryColor),
              headingTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white),
              dividerThickness: 5,
              dataRowMaxHeight: 60,
              showBottomBorder: true,
              columns: <DataColumn>[
                DataColumn(
                  label: Text(
                    'Kitap Adı',
                    style: TextStyle(color: ThemeColors.fourthColor),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Yazar Adı',
                    style: TextStyle(color: ThemeColors.fourthColor),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Detay',
                    style: TextStyle(color: ThemeColors.fourthColor),
                  ),
                ),
              ],
              rows: <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    const DataCell(
                      Text('1984'),
                    ),
                    const DataCell(
                      Text('George Orwell'),
                    ),
                    DataCell(
                      Icon(
                        Icons.arrow_circle_right_rounded,
                        color: ThemeColors.thirdColor,
                      ),
                    ),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    const DataCell(
                      Text('1984'),
                    ),
                    const DataCell(
                      Text('George Orwell'),
                    ),
                    DataCell(
                      Icon(
                        Icons.arrow_circle_right_rounded,
                        color: ThemeColors.thirdColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
