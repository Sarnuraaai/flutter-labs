import 'package:flutter/material.dart';

void main() {
  runApp(const LaHabittatApp());
}

class LaHabittatApp extends StatelessWidget {
  const LaHabittatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LaHabittat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HabitsListScreen(),
    );
  }
}

class HabitsListScreen extends StatelessWidget {
  const HabitsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LaHabittat',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: Column(
        children: [
          // Блок с мотивирующей цитатой
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.shade100),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.lightbulb_outline,
                  color: Colors.amber,
                  size: 32,
                ),
                const SizedBox(height: 8),
                Text(
                  '"The secret of getting ahead is getting started."',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[800],
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  '- Mark Twain',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Заголовок списка привычек
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Мои привычки',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                Text(
                  'Неделя',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Список привычек
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: const [
                HabitItem(
                  habitName: 'Пить воду 2л',
                  isCompletedToday: false,
                  weekProgress: [true, true, false, true, false, false, false],
                ),
                HabitItem(
                  habitName: 'Читать 30 минут',
                  isCompletedToday: true,
                  weekProgress: [true, true, true, true, true, false, false],
                ),
                HabitItem(
                  habitName: 'Утренняя зарядка',
                  isCompletedToday: false,
                  weekProgress: [false, true, false, true, false, false, false],
                ),
                HabitItem(
                  habitName: 'Изучать английский',
                  isCompletedToday: false,
                  weekProgress: [true, false, true, false, true, false, false],
                ),
              ],
            ),
          ),
        ],
      ),
      // Кнопка добавления новой привычки
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddHabitScreen()),
          );
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }
}

class HabitItem extends StatelessWidget {
  final String habitName;
  final bool isCompletedToday;
  final List<bool> weekProgress;

  const HabitItem({
    super.key,
    required this.habitName,
    required this.isCompletedToday,
    required this.weekProgress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Чекбокс для отметки выполнения
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isCompletedToday ? Colors.green : Colors.transparent,
                border: Border.all(
                  color: isCompletedToday ? Colors.green : Colors.grey,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: isCompletedToday
                  ? const Icon(
                Icons.check,
                color: Colors.white,
                size: 16,
              )
                  : null,
            ),

            const SizedBox(width: 16),

            // Название привычки
            Expanded(
              child: Text(
                habitName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
              ),
            ),

            // Индикаторы недельного прогресса
            Row(
              children: weekProgress.map((isDone) {
                return Container(
                  margin: const EdgeInsets.only(left: 2),
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: isDone ? Colors.green : Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: isDone
                      ? const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 8,
                  )
                      : null,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class AddHabitScreen extends StatelessWidget {
  const AddHabitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Новая привычка',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),

            // Заголовок поля ввода
            Text(
              'Название привычки',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),

            const SizedBox(height: 8),

            // Поле для ввода названия привычки
            TextField(
              decoration: InputDecoration(
                hintText: 'Например: Бегать по утрам',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
              style: const TextStyle(fontSize: 16),
            ),

            const Spacer(),

            // Кнопки действий
            Row(
              children: [
                // Кнопка "Отменить"
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(color: Colors.grey.shade400),
                    ),
                    child: Text(
                      'Отменить',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // Кнопка "Сохранить"
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      //
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: const Text(
                      'Сохранить',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}