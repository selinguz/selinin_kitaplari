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
}
