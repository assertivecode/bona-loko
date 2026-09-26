import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'life_area.dart';

/// Immutable domain model representing a suggested habit with multi-dimensional
/// weighted relations to one or more of the 12 [LifeArea]s.
///
/// Each weight is an integer between 1 and 5 inclusive:
/// - 5: Core Driver (primary transformative impact)
/// - 4: High Impact (direct physiological/psychological boost)
/// - 3: Moderate Synergy (meaningful indirect catalyst)
/// - 2: Gentle Resonance (light positive secondary influence)
/// - 1: Auxiliary Connection (contextual link)
///
/// Matching specs/domain/habit-life-area-weights.spec.md.
class SuggestedHabit {
  final String id;
  final String title;
  final String description;
  final Map<LifeArea, int> areaWeights;

  SuggestedHabit({
    required this.id,
    required this.title,
    required this.description,
    required this.areaWeights,
  }) {
    if (id.trim().isEmpty) {
      throw ArgumentError.value(id, 'id', 'Habit ID cannot be empty.');
    }
    if (title.trim().isEmpty) {
      throw ArgumentError.value(title, 'title', 'Habit title cannot be empty.');
    }
    if (areaWeights.isEmpty) {
      throw ArgumentError.value(
        areaWeights,
        'areaWeights',
        'Habit must relate to at least one LifeArea.',
      );
    }
    for (final entry in areaWeights.entries) {
      final weight = entry.value;
      if (weight < 1 || weight > 5) {
        throw ArgumentError.value(
          weight,
          'weight',
          'Weight for ${entry.key.name} must be an integer between 1 and 5 inclusive.',
        );
      }
    }
  }

  /// Returns the weight for a given [LifeArea], or 0 if unassociated.
  int weightFor(LifeArea area) => areaWeights[area] ?? 0;

  /// Returns true if this habit has a strong connection (weight >= 4) with [area].
  bool hasHighSynergyWith(LifeArea area) => weightFor(area) >= 4;

  /// Returns the localized title of this habit using [AppLocalizations].
  String localizedTitle(AppLocalizations? l10n) {
    if (l10n == null) return title;
    switch (id) {
      case 'habit_regular_exercise_workout':
        return l10n.habitRegularExerciseTitle;
      case 'habit_consistent_sleep_evening_transition':
        return l10n.habitConsistentSleepTitle;
      case 'habit_morning_screen_free_window':
        return l10n.habitMorningScreenFreeTitle;
      case 'habit_nurture_of_gratitude':
        return l10n.habitCultivationGratitudeTitle;
      case 'habit_daily_protected_reading':
        return l10n.habitDailyReadingTitle;
      case 'habit_mindful_daily_expense_tracking':
        return l10n.habitExpenseTrackingTitle;
      case 'habit_daily_family_connection_ritual':
        return l10n.habitFamilyConnectionTitle;
      case 'habit_weekly_personal_outreach':
        return l10n.habitWeeklyOutreachTitle;
      case 'habit_daily_guilt_free_micro_leisure':
        return l10n.habitMicroLeisureTitle;
      default:
        return title;
    }
  }

  /// Returns the localized description of this habit using [AppLocalizations].
  String localizedDescription(AppLocalizations? l10n) {
    if (l10n == null) return description;
    switch (id) {
      case 'habit_regular_exercise_workout':
        return l10n.habitRegularExerciseDesc;
      case 'habit_consistent_sleep_evening_transition':
        return l10n.habitConsistentSleepDesc;
      case 'habit_morning_screen_free_window':
        return l10n.habitMorningScreenFreeDesc;
      case 'habit_nurture_of_gratitude':
        return l10n.habitCultivationGratitudeDesc;
      case 'habit_daily_protected_reading':
        return l10n.habitDailyReadingDesc;
      case 'habit_mindful_daily_expense_tracking':
        return l10n.habitExpenseTrackingDesc;
      case 'habit_daily_family_connection_ritual':
        return l10n.habitFamilyConnectionDesc;
      case 'habit_weekly_personal_outreach':
        return l10n.habitWeeklyOutreachDesc;
      case 'habit_daily_guilt_free_micro_leisure':
        return l10n.habitMicroLeisureDesc;
      default:
        return description;
    }
  }

  /// Returns the standard icon representing this habit.
  IconData get icon {
    switch (id) {
      case 'habit_regular_exercise_workout':
        return Icons.directions_run_rounded;
      case 'habit_consistent_sleep_evening_transition':
        return Icons.bedtime_outlined;
      case 'habit_morning_screen_free_window':
        return Icons.wb_sunny_outlined;
      case 'habit_nurture_of_gratitude':
        return Icons.favorite_rounded;
      case 'habit_daily_protected_reading':
        return Icons.menu_book_rounded;
      case 'habit_mindful_daily_expense_tracking':
        return Icons.account_balance_wallet_rounded;
      case 'habit_daily_family_connection_ritual':
        return Icons.family_restroom_rounded;
      case 'habit_weekly_personal_outreach':
        return Icons.connect_without_contact_rounded;
      case 'habit_daily_guilt_free_micro_leisure':
        return Icons.palette_outlined;
      default:
        return Icons.auto_awesome_rounded;
    }
  }

  /// Whether this habit is conceptually defined and implemented with an interactive
  /// tracking/practice experience in the mobile application.
  bool get isImplemented {
    return id == 'habit_nurture_of_gratitude' ||
        id == 'habit_regular_exercise_workout' ||
        id == 'habit_mindful_daily_expense_tracking';
  }

  SuggestedHabit copyWith({
    String? id,
    String? title,
    String? description,
    Map<LifeArea, int>? areaWeights,
  }) {
    return SuggestedHabit(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      areaWeights: areaWeights ?? this.areaWeights,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SuggestedHabit &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  /// Canonical list of built-in suggested keystone habits matching platform specifications.
  static List<SuggestedHabit> get canonicalHabits => [
        SuggestedHabit(
          id: 'habit_regular_exercise_workout',
          title: 'Daily Physical Exercise & Movement',
          description:
              'Engage in 20–30 minutes of intentional physical movement to energize cellular vitality and mental clarity.',
          areaWeights: {
            LifeArea.healthFitness: 5,
            LifeArea.emotionalWellbeing: 4,
            LifeArea.focusMastery: 3,
            LifeArea.recreationPlay: 2,
          },
        ),
        SuggestedHabit(
          id: 'habit_consistent_sleep_evening_transition',
          title: 'Consistent Sleep & Evening Transition',
          description:
              'Anchor consistent sleep and wake timing with a soothing 20-minute wind-down routine.',
          areaWeights: {
            LifeArea.healthFitness: 5,
            LifeArea.emotionalWellbeing: 4,
            LifeArea.focusMastery: 3,
          },
        ),
        SuggestedHabit(
          id: 'habit_morning_screen_free_window',
          title: 'Morning Screen-Free Window',
          description:
              'Protect the first 30–60 minutes after waking from digital inputs to step into the day with calm sovereignty.',
          areaWeights: {
            LifeArea.focusMastery: 5,
            LifeArea.emotionalWellbeing: 4,
            LifeArea.healthFitness: 3,
          },
        ),
        SuggestedHabit(
          id: 'habit_nurture_of_gratitude',
          title: 'Cultivation of Gratitude',
          description:
              'Anchor the nervous system daily in quiet wonder, noticing goodness and heartfelt appreciation.',
          areaWeights: {
            LifeArea.emotionalWellbeing: 5,
            LifeArea.relationshipsIntimacy: 4,
            LifeArea.personalGrowth: 3,
            LifeArea.familyParenting: 3,
          },
        ),
        SuggestedHabit(
          id: 'habit_daily_protected_reading',
          title: 'Daily Protected Reading',
          description:
              'Dedicate 20 quiet minutes to reading books that expand mental models, craft wisdom, and perspective.',
          areaWeights: {
            LifeArea.personalGrowth: 5,
            LifeArea.focusMastery: 4,
            LifeArea.careerCalling: 3,
          },
        ),
        SuggestedHabit(
          id: 'habit_mindful_daily_expense_tracking',
          title: 'Mindful Daily Expense Tracking',
          description:
              'Spend 2 minutes each evening reviewing daily transactions with calm presence and zero judgment.',
          areaWeights: {
            LifeArea.financesWealth: 5,
            LifeArea.focusMastery: 3,
            LifeArea.emotionalWellbeing: 3,
          },
        ),
        SuggestedHabit(
          id: 'habit_daily_family_connection_ritual',
          title: 'Daily Family Connection Ritual',
          description:
              'Dedicate 15–30 undistracted minutes to meaningful connection with family members or children.',
          areaWeights: {
            LifeArea.familyParenting: 5,
            LifeArea.relationshipsIntimacy: 4,
            LifeArea.emotionalWellbeing: 3,
          },
        ),
        SuggestedHabit(
          id: 'habit_weekly_personal_outreach',
          title: 'Weekly Personal Outreach',
          description:
              'Reach out intentionally to a friend or mentor with a warm, unhurried message or phone call.',
          areaWeights: {
            LifeArea.friendshipsCommunity: 5,
            LifeArea.relationshipsIntimacy: 3,
            LifeArea.contributionLegacy: 3,
          },
        ),
        SuggestedHabit(
          id: 'habit_daily_guilt_free_micro_leisure',
          title: 'Daily Guilt-Free Micro-Leisure',
          description:
              'Enjoy 15 minutes of non-utilitarian play, creative hobbies, or restful joy without guilt.',
          areaWeights: {
            LifeArea.recreationPlay: 5,
            LifeArea.emotionalWellbeing: 4,
            LifeArea.healthFitness: 2,
          },
        ),
      ];
}
