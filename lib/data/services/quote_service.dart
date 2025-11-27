import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/quote.dart';

class QuoteService {
  // Основной API - ZenQuotes (может быть недоступен в некоторых регионах)
  static const String _zenQuotesUrl = 'https://zenquotes.io/api/random';

  // Резервный API - Quotable
  static const String _quotableUrl = 'https://api.quotable.io/random';

  // Локальные цитаты на случай недоступности API
  static final List<Quote> _fallbackQuotes = [
    Quote(text: "The secret of getting ahead is getting started.", author: "Mark Twain"),
    Quote(text: "Your future is created by what you do today, not tomorrow.", author: "Robert Kiyosaki"),
    Quote(text: "Small daily improvements are the key to staggering long-term results.", author: "Robin Sharma"),
    Quote(text: "We are what we repeatedly do. Excellence, then, is not an act, but a habit.", author: "Aristotle"),
    Quote(text: "The only way to do great work is to love what you do.", author: "Steve Jobs"),
  ];

  Future<Quote> getRandomQuote() async {
    try {
      // Пробуем первый API
      final response = await http.get(Uri.parse(_zenQuotesUrl)).timeout(
        const Duration(seconds: 5),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          return Quote.fromJson(data[0]);
        }
      }
    } catch (e) {
      // Если первый API не сработал, пробуем второй
      try {
        final response = await http.get(Uri.parse(_quotableUrl)).timeout(
          const Duration(seconds: 5),
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> data = json.decode(response.body);
          return Quote(
            text: data['content'] ?? 'No quote available',
            author: data['author'] ?? 'Unknown',
          );
        }
      } catch (e) {
        // Если оба API не сработали, используем локальные цитаты
        if (e is! FormatException) {
          print('Quote API error: $e');
        }
      }
    }

    // Возвращаем случайную локальную цитату
    return _fallbackQuotes[_getRandomIndex()];
  }

  int _getRandomIndex() {
    return DateTime.now().millisecondsSinceEpoch % _fallbackQuotes.length;
  }
}