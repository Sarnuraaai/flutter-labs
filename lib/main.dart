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
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HabitsListScreen(),
    const StatisticsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Привычки',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Статистика',
          ),
        ],
      ),
    );
  }
}

class HabitsListScreen extends StatefulWidget {
  const HabitsListScreen({super.key});

  @override
  State<HabitsListScreen> createState() => _HabitsListScreenState();
}

class _HabitsListScreenState extends State<HabitsListScreen> {
  final List<Habit> _habits = [
    /*Habit(
      name: 'Пить воду 2л',
      isCompletedToday: false,
      weekProgress: [true, true, false, true, false, false, false],
    ),
    Habit(
      name: 'Читать 30 минут',
      isCompletedToday: true,
      weekProgress: [true, true, true, true, true, false, false],
    ),*/
  ];

  void _addHabit(String habitName) {
    if (habitName.trim().isEmpty) return;

    setState(() {
      _habits.add(Habit(
        name: habitName.trim(),
        isCompletedToday: false,
        weekProgress: List.filled(7, false),
      ));
    });
  }

  void _toggleHabitCompletion(int index) {
    setState(() {
      _habits[index].isCompletedToday = !_habits[index].isCompletedToday;

      // Обновляем прогресс за неделю (простая логика)
      final today = DateTime.now().weekday - 1; // 0-6 для понедельника-воскресенья
      if (today < _habits[index].weekProgress.length) {
        _habits[index].weekProgress[today] = _habits[index].isCompletedToday;
      }
    });
  }

  void _navigateToAddHabit() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddHabitScreen(),
      ),
    );

    if (result != null && result is String) {
      _addHabit(result);
    }
  }

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
                  _habits.isEmpty
                      ? '"Начните добавлять привычки для отслеживания прогресса!"'
                      : '"The secret of getting ahead is getting started."',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[800],
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  _habits.isEmpty ? '- LaHabittat' : '- Mark Twain',
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
                  'Мои привычки (${_habits.length})',
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
            child: _habits.isEmpty
                ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.psychology_outlined,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Пока нет привычек',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Нажмите + чтобы добавить первую привычку',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _habits.length,
              itemBuilder: (context, index) {
                return HabitItem(
                  habit: _habits[index],
                  onTap: () => _toggleHabitCompletion(index),
                );
              },
            ),
          ),
        ],
      ),
      // Кнопка добавления новой привычки
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddHabit,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }
}

class Habit {
  String name;
  bool isCompletedToday;
  List<bool> weekProgress;

  Habit({
    required this.name,
    required this.isCompletedToday,
    required this.weekProgress,
  });
}

class HabitItem extends StatelessWidget {
  final Habit habit;
  final VoidCallback onTap;

  const HabitItem({
    super.key,
    required this.habit,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Чекбокс для отметки выполнения
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: habit.isCompletedToday ? Colors.green : Colors.transparent,
                  border: Border.all(
                    color: habit.isCompletedToday ? Colors.green : Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: habit.isCompletedToday
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
                  habit.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800],
                    decoration: habit.isCompletedToday
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ),

              // Индикаторы недельного прогресса
              Row(
                children: habit.weekProgress.map((isDone) {
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
      ),
    );
  }
}

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final TextEditingController _habitController = TextEditingController();

  void _saveHabit() {
    if (_habitController.text.trim().isNotEmpty) {
      Navigator.pop(context, _habitController.text);
    }
  }

  void _cancel() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _habitController.dispose();
    super.dispose();
  }

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
              controller: _habitController,
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
              onSubmitted: (_) => _saveHabit(),
            ),

            const Spacer(),

            // Кнопки действий
            Row(
              children: [
                // Кнопка "Отменить"
                Expanded(
                  child: OutlinedButton(
                    onPressed: _cancel,
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
                    onPressed: _saveHabit,
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

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Статистика',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bar_chart,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'Статистика будет доступна',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'после добавления и отслеживания привычек',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}