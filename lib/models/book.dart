import 'package:cloud_firestore/cloud_firestore.dart';

//TODO Ekleme, silme, güncelleme metodları buraya alınacak
//TODO Ekrana gelen kayıt sayısının sayfanın en üstünde görünmesi sağlanacak

class Book {
  String? bookId;
  final String bookName;
  final String authorName;
  final int pageNumber;
  final String shelf;

  Book({
    this.bookId,
    required this.bookName,
    required this.authorName,
    required this.pageNumber,
    required this.shelf,
  });

  static void addBook(Book book) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection('library').add({
      'bookName': book.bookName,
      'authorName': book.authorName,
      'pageNumber': book.pageNumber,
      'shelf': book.shelf,
      'dateTime': DateTime.now(),
    });
  }

  static Future<void> deleteBook(String docId) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('library').doc(docId);
    documentReference.delete();
  }
}
