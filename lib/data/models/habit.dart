class Habit {
  final int? id;
  final String name;
  final bool isCompletedToday;
  final List<bool> weekProgress;
  final DateTime createdAt;

  Habit({
    this.id,
    required this.name,
    required this.isCompletedToday,
    required this.weekProgress,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'isCompletedToday': isCompletedToday ? 1 : 0,
      'weekProgress': weekProgress.map((e) => e ? 1 : 0).toList().join(','),
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      id: map['id'],
      name: map['name'],
      isCompletedToday: map['isCompletedToday'] == 1,
      weekProgress: (map['weekProgress'] as String)
          .split(',')
          .map((e) => e == '1')
          .toList(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
    );
  }
}