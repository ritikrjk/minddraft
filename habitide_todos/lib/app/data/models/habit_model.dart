class Habit {
  final String id;
  String title;
  bool isCompletedToday;
  DateTime createdAt;
  DateTime? lastCompletedAt;
  int streakCount;
  List<DateTime> completedDates;

  Habit({
    required this.id,
    required this.title,
    this.isCompletedToday = false,
    DateTime? createdAt,
    this.lastCompletedAt,
    this.streakCount = 0,
    List<DateTime>? completedDates,
  }) : 
    createdAt = createdAt ?? DateTime.now(),
    completedDates = completedDates ?? [];

  Habit copyWith({
    String? id,
    String? title,
    bool? isCompletedToday,
    DateTime? createdAt,
    DateTime? lastCompletedAt,
    int? streakCount,
    List<DateTime>? completedDates,
  }) {
    return Habit(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompletedToday: isCompletedToday ?? this.isCompletedToday,
      createdAt: createdAt ?? this.createdAt,
      lastCompletedAt: lastCompletedAt ?? this.lastCompletedAt,
      streakCount: streakCount ?? this.streakCount,
      completedDates: completedDates ?? this.completedDates,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompletedToday': isCompletedToday,
      'createdAt': createdAt.toIso8601String(),
      'lastCompletedAt': lastCompletedAt?.toIso8601String(),
      'streakCount': streakCount,
      'completedDates': completedDates.map((date) => date.toIso8601String()).toList(),
    };
  }

  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      id: map['id'],
      title: map['title'],
      isCompletedToday: map['isCompletedToday'] ?? false,
      createdAt: DateTime.parse(map['createdAt']),
      lastCompletedAt: map['lastCompletedAt'] != null ? DateTime.parse(map['lastCompletedAt']) : null,
      streakCount: map['streakCount'] ?? 0,
      completedDates: (map['completedDates'] as List<dynamic>?)
          ?.map((date) => DateTime.parse(date))
          .toList() ?? [],
    );
  }
}
