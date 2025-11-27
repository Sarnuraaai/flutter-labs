import 'package:flutter/foundation.dart';
import 'package:flutter_labs/data/models/quote.dart';
import 'package:flutter_labs/data/repositories/quote_repository.dart';

class QuoteViewModel with ChangeNotifier {
  final QuoteRepository _quoteRepository = QuoteRepository();

  Quote? _quote;
  bool _isLoading = false;
  String? _error;

  Quote? get quote => _quote;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadRandomQuote() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _quote = await _quoteRepository.getRandomQuote();
    } catch (e) {
      _error = 'Не удалось загрузить цитату';
      if (kDebugMode) {
        print('Error loading quote: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}