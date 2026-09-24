import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/gratitude_repository.dart';
import '../../domain/models/gratitude_entry.dart';

/// Controller for managing gratitude entries, ordering, and daily completions.
class GratitudeController extends StateNotifier<AsyncValue<void>> {
  final GratitudeRepository _repository;

  GratitudeController(this._repository) : super(const AsyncValue.data(null));

  Future<void> addEntry({
    required String content,
    GratitudePeriod period = GratitudePeriod.anytime,
    DateTime? createdAt,
  }) async {
    if (content.trim().isEmpty) return;
    state = const AsyncValue.loading();
    try {
      await _repository.addEntry(
        content: content,
        period: period,
        createdAt: createdAt,
      );
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> reorderEntries(int oldIndex, int newIndex, List<GratitudeEntry> currentEntries) async {
    state = const AsyncValue.loading();
    try {
      final items = List<GratitudeEntry>.from(currentEntries);
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = items.removeAt(oldIndex);
      items.insert(newIndex, item);

      final orderedIds = items.map((e) => e.id).toList();
      await _repository.reorderEntries(orderedIds);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> toggleMorning(DateTime date) async {
    state = const AsyncValue.loading();
    try {
      await _repository.toggleMorningCompletion(date);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> toggleEvening(DateTime date) async {
    state = const AsyncValue.loading();
    try {
      await _repository.toggleEveningCompletion(date);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteEntry(String id) async {
    state = const AsyncValue.loading();
    try {
      await _repository.deleteEntry(id);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

/// Riverpod StateNotifierProvider for [GratitudeController].
final gratitudeControllerProvider =
    StateNotifierProvider<GratitudeController, AsyncValue<void>>((ref) {
  final repo = ref.watch(gratitudeRepositoryProvider);
  return GratitudeController(repo);
});
