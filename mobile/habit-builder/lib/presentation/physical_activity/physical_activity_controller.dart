import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/local/app_database.dart';
import '../../data/repositories/physical_activity_repository.dart';
import '../../domain/models/physical_activity.dart';

/// Stream provider for all active physical activities.
final activeActivitiesStreamProvider = StreamProvider<List<PhysicalActivity>>((ref) {
  final repo = ref.watch(physicalActivityRepositoryProvider);
  return repo.watchActiveActivities();
});

/// Stream provider for completion records of the current calendar date.
final todayCompletionsStreamProvider = StreamProvider<Map<String, DailyActivityCompletionData>>((ref) {
  final repo = ref.watch(physicalActivityRepositoryProvider);
  return repo.watchCompletionsForDate(DateTime.now());
});

/// Combined provider exposing physical activities merged with today's completion state.
final physicalActivitiesWithCompletionProvider =
    Provider<AsyncValue<List<PhysicalActivityWithCompletion>>>((ref) {
  final activitiesAsync = ref.watch(activeActivitiesStreamProvider);
  final completionsAsync = ref.watch(todayCompletionsStreamProvider);

  if (activitiesAsync.isLoading || completionsAsync.isLoading) {
    return const AsyncValue.loading();
  }
  if (activitiesAsync.hasError) {
    return AsyncValue.error(activitiesAsync.error!, activitiesAsync.stackTrace!);
  }
  if (completionsAsync.hasError) {
    return AsyncValue.error(completionsAsync.error!, completionsAsync.stackTrace!);
  }

  final activities = activitiesAsync.value ?? [];
  final completions = completionsAsync.value ?? {};

  final list = activities.map((activity) {
    final completion = completions[activity.id];
    return PhysicalActivityWithCompletion(
      activity: activity,
      isCompletedToday: completion?.completed ?? false,
      completedAt: completion?.completedAt,
    );
  }).toList();

  return AsyncValue.data(list);
});

/// Data class holding summary metrics for today's physical activities.
class PhysicalActivitiesSummary {
  final int total;
  final int completed;

  const PhysicalActivitiesSummary({required this.total, required this.completed});

  bool get hasActivities => total > 0;
  bool get allCompleted => total > 0 && completed == total;
}

/// Provider computing today's completion count vs total configured activities.
final todayPhysicalActivitiesSummaryProvider = Provider<PhysicalActivitiesSummary>((ref) {
  final itemsAsync = ref.watch(physicalActivitiesWithCompletionProvider);
  return itemsAsync.maybeWhen(
    data: (items) {
      final total = items.length;
      final completed = items.where((e) => e.isCompletedToday).length;
      return PhysicalActivitiesSummary(total: total, completed: completed);
    },
    orElse: () => const PhysicalActivitiesSummary(total: 0, completed: 0),
  );
});

/// Controller handling user actions (creating activities, toggling completion, deleting).
class PhysicalActivityControllerNotifier extends StateNotifier<AsyncValue<void>> {
  final PhysicalActivityRepository _repository;

  PhysicalActivityControllerNotifier(this._repository) : super(const AsyncValue.data(null));

  Future<void> addActivity({
    required PhysicalActivityType type,
    String? customName,
    required PhysicalActivityMetric metric,
    required int targetValue,
  }) async {
    state = const AsyncValue.loading();
    try {
      await _repository.createActivity(
        type: type,
        customName: customName,
        metric: metric,
        targetValue: targetValue,
      );
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteActivity(String id) async {
    try {
      await _repository.deleteActivity(id);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> toggleTodayCompletion(String activityId, bool completed) async {
    try {
      await _repository.toggleCompletion(
        activityId: activityId,
        date: DateTime.now(),
        completed: completed,
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

/// Riverpod provider for [PhysicalActivityControllerNotifier].
final physicalActivityControllerProvider =
    StateNotifierProvider<PhysicalActivityControllerNotifier, AsyncValue<void>>((ref) {
  final repo = ref.watch(physicalActivityRepositoryProvider);
  return PhysicalActivityControllerNotifier(repo);
});
