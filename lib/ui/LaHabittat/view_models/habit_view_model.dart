import 'package:flutter/foundation.dart';
import 'package:flutter_labs/data/models/habit.dart';
import 'package:flutter_labs/data/repositories/habit_repository.dart';

class HabitViewModel with ChangeNotifier {
  final HabitRepository _habitRepository = HabitRepository();

  List<Habit> _habits = [];
  bool _isLoading = false;
  String? _error;

  List<Habit> get habits => _habits;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadHabits() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _habits = await _habitRepository.getHabits();
    } catch (e) {
      _error = 'Не удалось загрузить привычки';
      if (kDebugMode) {
        print('Error loading habits: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addHabit(String name) async {
    try {
      await _habitRepository.addHabit(name);
      await loadHabits();
    } catch (e) {
      _error = 'Не удалось добавить привычку';
      if (kDebugMode) {
        print('Error adding habit: $e');
      }
      rethrow;
    }
  }

  Future<void> toggleHabitCompletion(Habit habit) async {
    try {
      await _habitRepository.toggleHabitCompletion(habit);
      await loadHabits();
    } catch (e) {
      _error = 'Не удалось обновить привычку';
      if (kDebugMode) {
        print('Error toggling habit: $e');
      }
    }
  }

  Future<void> deleteHabit(int id) async {
    try {
      await _habitRepository.deleteHabit(id);
      await loadHabits();
    } catch (e) {
      _error = 'Не удалось удалить привычку';
      if (kDebugMode) {
        print('Error deleting habit: $e');
      }
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}