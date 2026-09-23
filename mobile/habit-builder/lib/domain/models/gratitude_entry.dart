/// The period of the day for a gratitude reflection.
enum GratitudePeriod {
  morning,
  evening,
  anytime;

  static GratitudePeriod fromString(String? val) {
    if (val == 'morning') return GratitudePeriod.morning;
    if (val == 'evening') return GratitudePeriod.evening;
    return GratitudePeriod.anytime;
  }

  String toDbString() => name;
}

/// Immutable domain model representing a single recorded reason for gratitude.
class GratitudeEntry {
  final String id;
  final String content;
  final DateTime createdAt;
  final GratitudePeriod period;
  final int orderIndex;

  const GratitudeEntry({
    required this.id,
    required this.content,
    required this.createdAt,
    this.period = GratitudePeriod.anytime,
    this.orderIndex = 0,
  });

  GratitudeEntry copyWith({
    String? id,
    String? content,
    DateTime? createdAt,
    GratitudePeriod? period,
    int? orderIndex,
  }) {
    return GratitudeEntry(
      id: id ?? this.id,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      period: period ?? this.period,
      orderIndex: orderIndex ?? this.orderIndex,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GratitudeEntry &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          content == other.content &&
          createdAt == other.createdAt &&
          period == other.period &&
          orderIndex == other.orderIndex;

  @override
  int get hashCode => Object.hash(id, content, createdAt, period, orderIndex);

  @override
  String toString() =>
      'GratitudeEntry(id: $id, content: $content, createdAt: $createdAt, period: $period, orderIndex: $orderIndex)';
}

/// Immutable domain model representing daily completion of gratitude grounding (morning) and reflection (evening).
class DailyGratitudeCompletion {
  final String id;
  final DateTime date;
  final bool morningCompleted;
  final DateTime? morningCompletedAt;
  final bool eveningCompleted;
  final DateTime? eveningCompletedAt;

  const DailyGratitudeCompletion({
    required this.id,
    required this.date,
    this.morningCompleted = false,
    this.morningCompletedAt,
    this.eveningCompleted = false,
    this.eveningCompletedAt,
  });

  DailyGratitudeCompletion copyWith({
    String? id,
    DateTime? date,
    bool? morningCompleted,
    DateTime? morningCompletedAt,
    bool? eveningCompleted,
    DateTime? eveningCompletedAt,
  }) {
    return DailyGratitudeCompletion(
      id: id ?? this.id,
      date: date ?? this.date,
      morningCompleted: morningCompleted ?? this.morningCompleted,
      morningCompletedAt: morningCompletedAt ?? this.morningCompletedAt,
      eveningCompleted: eveningCompleted ?? this.eveningCompleted,
      eveningCompletedAt: eveningCompletedAt ?? this.eveningCompletedAt,
    );
  }

  bool get isFullyCompleted => morningCompleted && eveningCompleted;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyGratitudeCompletion &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          date == other.date &&
          morningCompleted == other.morningCompleted &&
          morningCompletedAt == other.morningCompletedAt &&
          eveningCompleted == other.eveningCompleted &&
          eveningCompletedAt == other.eveningCompletedAt;

  @override
  int get hashCode => Object.hash(
        id,
        date,
        morningCompleted,
        morningCompletedAt,
        eveningCompleted,
        eveningCompletedAt,
      );

  @override
  String toString() =>
      'DailyGratitudeCompletion(id: $id, date: $date, morning: $morningCompleted, evening: $eveningCompleted)';
}
