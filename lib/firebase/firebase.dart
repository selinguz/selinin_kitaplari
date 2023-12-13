import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:selinin_kitaplari/models/book.dart';

class FirebaseDB {
  static Future<List<String>> getShelfData() async {
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

  static Future<List<Book>> getBookList() async {
    List<Book> tempList = [];
    await FirebaseFirestore.instance
        .collection('library')
        .orderBy('dateTime', descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                var book = Book(
                    bookId: doc.id,
                    authorName: doc['authorName'],
                    bookName: doc['bookName'],
                    shelf: doc['shelf'],
                    pageNumber: doc['pageNumber']);
                tempList.add(book);
              }),
            });

    return tempList;
  }
}
