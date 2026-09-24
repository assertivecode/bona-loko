import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Pre-defined physical activity types.
enum PhysicalActivityType {
  walking('walking'),
  running('running'),
  cycling('cycling'),
  swimming('swimming'),
  pushups('pushups'),
  squats('squats'),
  stretching('stretching'),
  custom('custom');

  final String key;
  const PhysicalActivityType(this.key);

  static PhysicalActivityType fromKey(String key) {
    return PhysicalActivityType.values.firstWhere(
      (e) => e.key == key,
      orElse: () => PhysicalActivityType.custom,
    );
  }

  IconData get icon {
    switch (this) {
      case PhysicalActivityType.walking:
        return Icons.directions_walk_rounded;
      case PhysicalActivityType.running:
        return Icons.directions_run_rounded;
      case PhysicalActivityType.cycling:
        return Icons.directions_bike_rounded;
      case PhysicalActivityType.swimming:
        return Icons.pool_rounded;
      case PhysicalActivityType.pushups:
        return Icons.fitness_center_rounded;
      case PhysicalActivityType.squats:
        return Icons.accessibility_new_rounded;
      case PhysicalActivityType.stretching:
        return Icons.self_improvement_rounded;
      case PhysicalActivityType.custom:
        return Icons.sports_rounded;
    }
  }

  String localizedName(AppLocalizations? l10n) {
    if (l10n == null) return key;
    switch (this) {
      case PhysicalActivityType.walking:
        return l10n.activityTypeWalking;
      case PhysicalActivityType.running:
        return l10n.activityTypeRunning;
      case PhysicalActivityType.cycling:
        return l10n.activityTypeCycling;
      case PhysicalActivityType.swimming:
        return l10n.activityTypeSwimming;
      case PhysicalActivityType.pushups:
        return l10n.activityTypePushups;
      case PhysicalActivityType.squats:
        return l10n.activityTypeSquats;
      case PhysicalActivityType.stretching:
        return l10n.activityTypeStretching;
      case PhysicalActivityType.custom:
        return l10n.activityTypeCustom;
    }
  }
}

/// Target metric type for physical activities (Duration in minutes vs Repetitions count).
enum PhysicalActivityMetric {
  duration('duration'),
  repetitions('repetitions');

  final String key;
  const PhysicalActivityMetric(this.key);

  static PhysicalActivityMetric fromKey(String key) {
    return PhysicalActivityMetric.values.firstWhere(
      (e) => e.key == key,
      orElse: () => PhysicalActivityMetric.duration,
    );
  }

  String localizedName(AppLocalizations? l10n) {
    if (l10n == null) return key;
    switch (this) {
      case PhysicalActivityMetric.duration:
        return l10n.metricDuration;
      case PhysicalActivityMetric.repetitions:
        return l10n.metricRepetitions;
    }
  }

  String unit(AppLocalizations? l10n) {
    switch (this) {
      case PhysicalActivityMetric.duration:
        return l10n?.minutesUnit ?? 'min';
      case PhysicalActivityMetric.repetitions:
        return l10n?.repetitionsUnit ?? 'reps';
    }
  }
}

/// Immutable domain model representing a configured daily physical activity.
class PhysicalActivity {
  final String id;
  final PhysicalActivityType type;
  final String? customName;
  final PhysicalActivityMetric metric;
  final int targetValue;
  final DateTime createdAt;
  final bool isActive;

  const PhysicalActivity({
    required this.id,
    required this.type,
    this.customName,
    required this.metric,
    required this.targetValue,
    required this.createdAt,
    this.isActive = true,
  });

  String displayName(AppLocalizations? l10n) {
    if (type == PhysicalActivityType.custom && customName != null && customName!.trim().isNotEmpty) {
      return customName!.trim();
    }
    return type.localizedName(l10n);
  }

  String formattedTarget(AppLocalizations? l10n) {
    final unitStr = metric.unit(l10n);
    return '$targetValue $unitStr';
  }

  IconData get icon => type.icon;
}

/// Composite model coupling a [PhysicalActivity] with its daily completion state.
class PhysicalActivityWithCompletion {
  final PhysicalActivity activity;
  final bool isCompletedToday;
  final DateTime? completedAt;

  const PhysicalActivityWithCompletion({
    required this.activity,
    required this.isCompletedToday,
    this.completedAt,
  });

  PhysicalActivityWithCompletion copyWith({
    PhysicalActivity? activity,
    bool? isCompletedToday,
    DateTime? completedAt,
  }) {
    return PhysicalActivityWithCompletion(
      activity: activity ?? this.activity,
      isCompletedToday: isCompletedToday ?? this.isCompletedToday,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}
