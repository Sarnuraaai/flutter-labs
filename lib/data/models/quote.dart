// models/quote.dart
class Quote {
  final String text;
  final String author;

  Quote({
    required this.text,
    required this.author,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      text: _cleanText(json['q'] ?? json['content'] ?? 'Без цитаты'),
      author: _cleanAuthor(json['a'] ?? json['author'] ?? 'Неизвестный автор'),
    );
  }

  static String _cleanText(String text) {
    // Убираем лишние пробелы и специальные символы
    return text.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  static String _cleanAuthor(String author) {
    // Убираем "Unknown" и подобные
    if (author.toLowerCase() == 'unknown' ||
        author.isEmpty ||
        author == 'null') {
      return 'Неизвестный автор';
    }
    return author;
  }
}