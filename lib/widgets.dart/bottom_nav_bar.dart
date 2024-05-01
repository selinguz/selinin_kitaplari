import 'package:flutter/material.dart';
import 'package:selinin_kitaplari/pages/add_book_page.dart';
import 'package:selinin_kitaplari/pages/list_page.dart';
import 'package:selinin_kitaplari/pages/profile_page.dart';

class SpecBottomNavBar extends StatefulWidget {
  const SpecBottomNavBar({super.key});

  @override
  State<SpecBottomNavBar> createState() => _SpecBottomNavBarState();
}

class _SpecBottomNavBarState extends State<SpecBottomNavBar> {
  int selectedTab = 0;

  void changeTab(int index) {
    setState(() {
      selectedTab = index;
    });
  }

  Widget showPage(int selectedTab) {
    switch (selectedTab) {
      case 0:
        return const AddBookPage();
      case 1:
        return const BooksListPage();
      case 2:
        return const ProfilePage();
      default:
        return const SnackBar(
          content: Text('Sayfa Bulunamadı'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedTab,
      onTap: changeTab,
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Kitap Ekle',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Listele',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_sharp),
          label: 'Profil',
        ),
      ],
    );
  }
}
