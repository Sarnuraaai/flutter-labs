import '../models/habit.dart';
import '../services/database_service.dart';

class HabitRepository {
  final DatabaseService _databaseService = DatabaseService();

  Future<List<Habit>> getHabits() async {
    return await _databaseService.getHabits();
  }

  Future<void> addHabit(String name) async {
    final habit = Habit(
      name: name,
      isCompletedToday: false,
      weekProgress: List.filled(7, false),
      createdAt: DateTime.now(),
    );
    await _databaseService.insertHabit(habit);
  }

  Future<void> toggleHabitCompletion(Habit habit) async {
    final today = DateTime.now().weekday - 1;
    final updatedWeekProgress = List<bool>.from(habit.weekProgress);

    if (today < updatedWeekProgress.length) {
      updatedWeekProgress[today] = !habit.isCompletedToday;
    }

    final updatedHabit = Habit(
      id: habit.id,
      name: habit.name,
      isCompletedToday: !habit.isCompletedToday,
      weekProgress: updatedWeekProgress,
      createdAt: habit.createdAt,
    );
    await _databaseService.updateHabit(updatedHabit);
  }

  Future<void> deleteHabit(int id) async {
    await _databaseService.deleteHabit(id);
  }
}