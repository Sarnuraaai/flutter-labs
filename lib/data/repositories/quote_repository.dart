import '../models/quote.dart';
import '../services/quote_service.dart';

class QuoteRepository {
  final QuoteService _quoteService = QuoteService();

  Future<Quote> getRandomQuote() async {
    return await _quoteService.getRandomQuote();
  }
}