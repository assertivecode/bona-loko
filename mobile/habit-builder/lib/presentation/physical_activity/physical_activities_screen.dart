import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/training_repository.dart';
import '../../domain/models/training.dart';
import 'training_controller.dart';

/// Screen for managing workout groups, routines inside groups, individual exercises with sets,
/// and executing daily training sessions.
class PhysicalActivitiesScreen extends ConsumerStatefulWidget {
  const PhysicalActivitiesScreen({super.key});

  @override
  ConsumerState<PhysicalActivitiesScreen> createState() => _PhysicalActivitiesScreenState();
}

class _PhysicalActivitiesScreenState extends ConsumerState<PhysicalActivitiesScreen> {
  String? _selectedGroupId;
  String? _selectedRoutineId;

  String _localizeExerciseName(String name, AppLocalizations? l10n) {
    if (l10n == null) return name;
    final normalized = name.trim().toLowerCase();
    switch (normalized) {
      case 'squats':
      case 'squads':
      case 'agachamentos':
      case 'agachamento':
      case 'genufleksoj':
      case 'surgeniĝoj':
        return l10n.exerciseSquats;
      case 'push-ups':
      case 'pushups':
      case 'push ups':
      case 'flexões':
      case 'flexoes':
      case 'flexão':
      case 'flexao':
      case 'brakpuŝoj':
        return l10n.exercisePushUps;
      case 'walking':
      case 'caminhada':
      case 'promenado':
        return l10n.exerciseWalking;
      case 'running':
      case 'corrida':
      case 'kurado':
        return l10n.exerciseRunning;
      case 'cycling':
      case 'ciclismo':
      case 'biciklado':
        return l10n.exerciseCycling;
      case 'swimming':
      case 'natação':
      case 'natacao':
      case 'naĝado':
        return l10n.exerciseSwimming;
      case 'stretching':
      case 'alongamento':
      case 'alongamento & mobilidade':
      case 'streĉado':
      case 'streĉado & movebleco':
        return l10n.exerciseStretching;
      case 'custom':
      case 'personalizado':
      case 'propra':
        return l10n.exerciseCustom;
      default:
        return name;
    }
  }

  IconData _getExerciseIcon(String name, String activityType) {
    final normalized = name.trim().toLowerCase();
    switch (normalized) {
      case 'squats':
      case 'squads':
      case 'agachamentos':
      case 'agachamento':
      case 'genufleksoj':
      case 'surgeniĝoj':
        return Icons.sports_martial_arts_rounded;
      case 'push-ups':
      case 'pushups':
      case 'push ups':
      case 'flexões':
      case 'flexoes':
      case 'flexão':
      case 'flexao':
      case 'brakpuŝoj':
        return Icons.sports_gymnastics_rounded;
      case 'walking':
      case 'caminhada':
      case 'promenado':
        return Icons.directions_walk_rounded;
      case 'running':
      case 'corrida':
      case 'kurado':
        return Icons.directions_run_rounded;
      case 'cycling':
      case 'ciclismo':
      case 'biciklado':
        return Icons.directions_bike_rounded;
      case 'swimming':
      case 'natação':
      case 'natacao':
      case 'naĝado':
        return Icons.pool_rounded;
      case 'stretching':
      case 'alongamento':
      case 'alongamento & mobilidade':
      case 'streĉado':
      case 'streĉado & movebleco':
        return Icons.self_improvement_rounded;
      default:
        return activityType == 'duration'
            ? Icons.directions_run_rounded
            : Icons.fitness_center_rounded;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final l10n = AppLocalizations.of(context);
      ref.read(trainingRepositoryProvider).getOrCreateDefaultGroupAndRoutine(
            defaultGroupName: l10n?.defaultGroupName ?? 'Default Group',
            defaultRoutineName: l10n?.defaultRoutineName ?? 'Sample Workout',
          );
    });
  }

  void _showAddGroupDialog(BuildContext context) {
    final nameController = TextEditingController();
    final l10n = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            l10n?.newGroupDialogTitle ?? 'New Workout Group',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: TextField(
            key: const Key('group_name_input'),
            controller: nameController,
            autofocus: true,
            decoration: InputDecoration(
              labelText: l10n?.groupNameLabel ?? 'Group Name',
              hintText: 'e.g. Hipertrofia ABC',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(l10n?.gratitudeCancel ?? 'Cancel'),
            ),
            FilledButton(
              key: const Key('save_group_button'),
              onPressed: () async {
                final name = nameController.text.trim();
                if (name.isNotEmpty) {
                  final newGroup =
                      await ref.read(trainingControllerProvider.notifier).createGroup(name);
                  if (newGroup != null && mounted) {
                    setState(() {
                      _selectedGroupId = newGroup.id;
                      _selectedRoutineId = null;
                    });
                  }
                  if (dialogContext.mounted) {
                    Navigator.of(dialogContext).pop();
                  }
                }
              },
              child: Text(l10n?.gratitudeSave ?? 'Save'),
            ),
          ],
        );
      },
    );
  }

  void _showEditGroupDialog(BuildContext context, WorkoutGroup group) {
    final nameController = TextEditingController(text: group.name);
    final l10n = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            l10n?.editGroupNameTitle ?? 'Edit Group Name',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: TextField(
            key: const Key('edit_group_name_input'),
            controller: nameController,
            autofocus: true,
            decoration: InputDecoration(
              labelText: l10n?.groupNameLabel ?? 'Group Name',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(l10n?.gratitudeCancel ?? 'Cancel'),
            ),
            FilledButton(
              key: const Key('confirm_edit_group_button'),
              onPressed: () async {
                final name = nameController.text.trim();
                if (name.isNotEmpty) {
                  await ref
                      .read(trainingControllerProvider.notifier)
                      .updateGroupName(group.id, name);
                  if (dialogContext.mounted) {
                    Navigator.of(dialogContext).pop();
                  }
                }
              },
              child: Text(l10n?.gratitudeSave ?? 'Save'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteGroupDialog(BuildContext context, WorkoutGroup group) {
    final l10n = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            l10n?.deleteGroupDialogTitle ?? 'Delete Group',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
            l10n?.deleteGroupConfirmation ??
                'Are you sure you want to delete this group and all its routines?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(l10n?.gratitudeCancel ?? 'Cancel'),
            ),
            FilledButton(
              key: const Key('confirm_delete_group_button'),
              style: FilledButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
              onPressed: () async {
                await ref.read(trainingControllerProvider.notifier).deleteGroup(group.id);
                if (mounted) {
                  setState(() {
                    _selectedGroupId = null;
                    _selectedRoutineId = null;
                  });
                }
                if (dialogContext.mounted) {
                  Navigator.of(dialogContext).pop();
                }
              },
              child: Text(l10n?.deleteButton ?? 'Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showAddRoutineDialog(BuildContext context, WorkoutGroup group) {
    final nameController = TextEditingController();
    final l10n = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            l10n?.newRoutineDialogTitle ?? 'New Workout Routine',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: TextField(
            key: const Key('routine_name_input'),
            controller: nameController,
            autofocus: true,
            decoration: InputDecoration(
              labelText: l10n?.routineNameLabel ?? 'Routine Name',
              hintText: 'e.g. Treino A - Peito',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(l10n?.gratitudeCancel ?? 'Cancel'),
            ),
            FilledButton(
              key: const Key('save_routine_button'),
              onPressed: () async {
                final name = nameController.text.trim();
                if (name.isNotEmpty) {
                  final newRoutine =
                      await ref.read(trainingControllerProvider.notifier).createRoutine(
                            groupId: group.id,
                            name: name,
                          );
                  if (newRoutine != null && mounted) {
                    setState(() {
                      _selectedRoutineId = newRoutine.id;
                    });
                  }
                  if (dialogContext.mounted) {
                    Navigator.of(dialogContext).pop();
                  }
                }
              },
              child: Text(l10n?.gratitudeSave ?? 'Save'),
            ),
          ],
        );
      },
    );
  }

  void _showEditRoutineDialog(BuildContext context, WorkoutRoutine routine) {
    final nameController = TextEditingController(text: routine.name);
    final l10n = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            l10n?.editRoutineNameTitle ?? 'Edit Routine Name',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: TextField(
            key: const Key('edit_routine_name_input'),
            controller: nameController,
            autofocus: true,
            decoration: InputDecoration(
              labelText: l10n?.routineNameLabel ?? 'Routine Name',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(l10n?.gratitudeCancel ?? 'Cancel'),
            ),
            FilledButton(
              key: const Key('confirm_edit_routine_button'),
              onPressed: () async {
                final name = nameController.text.trim();
                if (name.isNotEmpty) {
                  await ref
                      .read(trainingControllerProvider.notifier)
                      .updateRoutineName(routine.id, name);
                  if (dialogContext.mounted) {
                    Navigator.of(dialogContext).pop();
                  }
                }
              },
              child: Text(l10n?.gratitudeSave ?? 'Save'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteRoutineDialog(BuildContext context, WorkoutRoutine routine) {
    final l10n = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            l10n?.deleteRoutineDialogTitle ?? 'Delete Routine',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
            l10n?.deleteRoutineConfirmation ?? 'Are you sure you want to delete this routine?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(l10n?.gratitudeCancel ?? 'Cancel'),
            ),
            FilledButton(
              key: const Key('confirm_delete_routine_button'),
              style: FilledButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
              onPressed: () async {
                await ref.read(trainingControllerProvider.notifier).deleteRoutine(routine.id);
                if (mounted) {
                  setState(() {
                    _selectedRoutineId = null;
                  });
                }
                if (dialogContext.mounted) {
                  Navigator.of(dialogContext).pop();
                }
              },
              child: Text(l10n?.deleteButton ?? 'Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteSessionDialog(BuildContext context, DailyTrainingSession session) {
    final l10n = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            l10n?.deleteSessionDialogTitle ?? 'Delete Workout Session',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
            l10n?.deleteSessionConfirmation ??
                "Are you sure you want to delete today's workout session? Your progress for today will be cleared.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(l10n?.gratitudeCancel ?? 'Cancel'),
            ),
            FilledButton(
              key: const Key('confirm_delete_session_button'),
              style: FilledButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
              onPressed: () async {
                await ref.read(trainingControllerProvider.notifier).deleteDailySession(session.id);
                if (dialogContext.mounted) {
                  Navigator.of(dialogContext).pop();
                }
              },
              child: Text(l10n?.deleteButton ?? 'Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showAddExerciseDialog(BuildContext context, WorkoutRoutine routine) {
    String selectedName = 'Walking';
    String activityType = 'duration';
    int targetSets = 1;
    int targetValue = 30;
    double? targetWeight;
    final customNameController = TextEditingController();
    final setsController = TextEditingController(text: '1');
    final targetController = TextEditingController(text: '30');
    final weightController = TextEditingController();

    final commonExercises = [
      {'name': 'Walking', 'type': 'duration', 'val': 30, 'icon': Icons.directions_walk_rounded},
      {'name': 'Running', 'type': 'duration', 'val': 20, 'icon': Icons.directions_run_rounded},
      {'name': 'Cycling', 'type': 'duration', 'val': 30, 'icon': Icons.directions_bike_rounded},
      {'name': 'Swimming', 'type': 'duration', 'val': 30, 'icon': Icons.pool_rounded},
      {'name': 'Squats', 'type': 'repetition', 'val': 25, 'icon': Icons.sports_martial_arts_rounded},
      {'name': 'Push-ups', 'type': 'repetition', 'val': 20, 'icon': Icons.sports_gymnastics_rounded},
      {'name': 'Stretching', 'type': 'duration', 'val': 15, 'icon': Icons.self_improvement_rounded},
      {'name': 'Custom', 'type': 'repetition', 'val': 10, 'icon': Icons.add_circle_outline_rounded},
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) {
        final theme = Theme.of(bottomSheetContext);
        final l10n = AppLocalizations.of(bottomSheetContext);

        return StatefulBuilder(
          builder: (context, setModalState) {
            final isCustom = selectedName == 'Custom';

            return Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24.0)),
              ),
              padding: EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 20.0,
                bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom + 24.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.outlineVariant,
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n?.addExerciseTitle ?? 'Add Exercise',
                      key: const Key('activity_dialog_title'),
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),

                    // EXERCISE SELECTION CHIPS
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: commonExercises.map((item) {
                        final name = item['name'] as String;
                        final isSelected = selectedName == name;
                        final chipKeyName =
                            name.toLowerCase().replaceAll('-', '').replaceAll(' ', '_');

                        return ChoiceChip(
                          key: Key('activity_chip_$chipKeyName'),
                          avatar: Icon(item['icon'] as IconData, size: 18),
                          label: Text(_localizeExerciseName(name, l10n)),
                          selected: isSelected,
                          onSelected: (selected) {
                            if (selected) {
                              setModalState(() {
                                selectedName = name;
                                activityType = item['type'] as String;
                                targetValue = item['val'] as int;
                                targetController.text = targetValue.toString();
                              });
                            }
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),

                    // CUSTOM NAME INPUT (IF CUSTOM SELECTED)
                    if (isCustom) ...[
                      TextField(
                        key: const Key('custom_activity_name_input'),
                        controller: customNameController,
                        decoration: InputDecoration(
                          labelText: l10n?.exerciseNameLabel ?? 'Exercise Name',
                          hintText: l10n?.customExercisePlaceholder ?? 'e.g., Pull-ups, Plank, Lunges',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // SETS CONFIGURATION
                    Text(
                      l10n?.targetSetsLabel ?? 'Number of Sets',
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextField(
                            key: const Key('target_sets_input'),
                            controller: setsController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: l10n?.setsLabel ?? 'Sets',
                              suffixText: l10n?.setsUnit ?? 'sets',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            ),
                            onChanged: (val) {
                              final parsed = int.tryParse(val.trim());
                              if (parsed != null && parsed > 0) {
                                targetSets = parsed;
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Wrap(
                          spacing: 6.0,
                          children: [1, 2, 3, 4, 5].map((s) {
                            return ChoiceChip(
                              key: Key('sets_chip_$s'),
                              label: Text('$s'),
                              selected: targetSets == s,
                              onSelected: (selected) {
                                if (selected) {
                                  setModalState(() {
                                    targetSets = s;
                                    setsController.text = s.toString();
                                  });
                                }
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // METRIC TYPE SELECTOR (DURATION VS REPETITION)
                    Text(
                      l10n?.metricTypeLabel ?? 'Target Metric',
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: [
                        ChoiceChip(
                          key: const Key('metric_chip_duration'),
                          avatar: const Icon(Icons.timer_outlined, size: 16),
                          label: Text(l10n?.metricDuration ?? 'Duration (minutes)'),
                          selected: activityType == 'duration',
                          onSelected: (selected) {
                            if (selected) {
                              setModalState(() {
                                activityType = 'duration';
                                targetValue = 30;
                                targetController.text = '30';
                              });
                            }
                          },
                        ),
                        ChoiceChip(
                          key: const Key('metric_chip_repetitions'),
                          avatar: const Icon(Icons.repeat_rounded, size: 16),
                          label: Text(l10n?.metricRepetitions ?? 'Repetitions'),
                          selected: activityType == 'repetition',
                          onSelected: (selected) {
                            if (selected) {
                              setModalState(() {
                                activityType = 'repetition';
                                targetValue = 25;
                                targetController.text = '25';
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // TARGET VALUE INPUT & WEIGHT INPUT
                    Row(
                      children: [
                        // TARGET MINUTES OR REPETITIONS
                        Expanded(
                          flex: 3,
                          child: TextField(
                            key: const Key('target_value_input'),
                            controller: targetController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: activityType == 'duration'
                                  ? (l10n?.metricDuration ?? 'Minutes')
                                  : (l10n?.metricRepetitions ?? 'Reps'),
                              suffixText: activityType == 'duration'
                                  ? (l10n?.minutesUnit ?? 'min')
                                  : (l10n?.repetitionsUnit ?? 'reps'),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            ),
                            onChanged: (val) {
                              final parsed = int.tryParse(val.trim());
                              if (parsed != null && parsed > 0) {
                                targetValue = parsed;
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        // OPTIONAL WEIGHT (KG)
                        Expanded(
                          flex: 2,
                          child: TextField(
                            key: const Key('weight_input'),
                            controller: weightController,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              labelText: l10n?.exerciseWeightLabel ?? 'Weight (kg)',
                              suffixText: l10n?.weightUnit ?? 'kg',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            ),
                            onChanged: (val) {
                              targetWeight = double.tryParse(val.trim());
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // PRESET QUICK CHIPS
                    Wrap(
                      spacing: 8.0,
                      children: (activityType == 'duration'
                              ? [15, 20, 30, 45, 60]
                              : [10, 15, 20, 25, 30, 50])
                          .map((val) {
                        return ActionChip(
                          key: Key('preset_target_$val'),
                          label: Text(
                              '$val ${activityType == 'duration' ? (l10n?.minutesUnit ?? "min") : (l10n?.repetitionsUnit ?? "reps")}'),
                          onPressed: () {
                            setModalState(() {
                              targetValue = val;
                              targetController.text = val.toString();
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),

                    // ACTION BUTTONS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(bottomSheetContext).pop(),
                          child: Text(l10n?.gratitudeCancel ?? 'Cancel'),
                        ),
                        const SizedBox(width: 8),
                        FilledButton.icon(
                          key: const Key('save_physical_activity_button'),
                          onPressed: () async {
                            final finalName = isCustom
                                ? (customNameController.text.trim().isNotEmpty
                                    ? customNameController.text.trim()
                                    : (l10n?.exerciseCustom ?? 'Custom'))
                                : selectedName;

                            await ref.read(trainingControllerProvider.notifier).addExercise(
                                  routineId: routine.id,
                                  name: finalName,
                                  activityType: activityType,
                                  targetSets: targetSets,
                                  targetDurationSeconds:
                                      activityType == 'duration' ? targetValue * 60 : null,
                                  targetRepetitions:
                                      activityType == 'repetition' ? targetValue : null,
                                  targetWeightKg: targetWeight,
                                );

                            if (bottomSheetContext.mounted) {
                              Navigator.of(bottomSheetContext).pop();
                            }
                          },
                          icon: const Icon(Icons.check, size: 18),
                          label: Text(l10n?.saveActivityButton ?? 'Save Activity'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final groupsAsync = ref.watch(workoutGroupsStreamProvider);
    final sessionAsync = ref.watch(todayTrainingSessionStreamProvider);

    final groups = groupsAsync.valueOrNull ?? [];
    final session = sessionAsync.valueOrNull;

    // Resolve active selected Group
    WorkoutGroup? selectedGroup;
    if (groups.isNotEmpty) {
      if (_selectedGroupId != null) {
        selectedGroup = groups.where((g) => g.id == _selectedGroupId).firstOrNull;
      }
      selectedGroup ??= groups.first;
    }

    // Resolve active selected Routine within the group
    WorkoutRoutine? selectedRoutine;
    if (selectedGroup != null && selectedGroup.routines.isNotEmpty) {
      if (_selectedRoutineId != null) {
        selectedRoutine =
            selectedGroup.routines.where((r) => r.id == _selectedRoutineId).firstOrNull;
      }
      selectedRoutine ??= selectedGroup.routines.first;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n?.physicalActivitiesScreenTitle ?? 'Daily Physical Activities',
          key: const Key('physical_activities_screen_title'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          children: [
            // STATUS / GROUNDING BANNER
            _buildHeaderBanner(context, session),
            const SizedBox(height: 20),

            // TODAY'S ACTIVE SESSION EXECUTION (IF SESSION EXISTS)
            if (session != null) ...[
              _buildDailySessionCard(context, session),
              const SizedBox(height: 24),
            ],

            // 1. GROUPS SELECTION & MANAGEMENT
            _buildGroupsSection(context, groups, selectedGroup),
            const SizedBox(height: 24),

            // 2. WORKOUT ROUTINES IN THE SELECTED GROUP
            if (selectedGroup != null) ...[
              _buildRoutinesSection(context, selectedGroup, selectedRoutine, session),
              const SizedBox(height: 24),
            ],

            // 3. INDIVIDUAL EXERCISES IN THE SELECTED ROUTINE
            if (selectedGroup != null && selectedRoutine != null) ...[
              _buildExercisesSection(context, selectedGroup, selectedRoutine, session),
              const SizedBox(height: 32),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderBanner(BuildContext context, DailyTrainingSession? session) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    final isInProgress = session != null && !session.isCompleted;
    final isCompleted = session != null && session.isCompleted;

    return Container(
      key: const Key('physical_activities_summary_card'),
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isCompleted
              ? [Colors.green.shade100.withOpacity(0.8), Colors.green.shade50.withOpacity(0.5)]
              : (isInProgress
                  ? [
                      theme.colorScheme.primaryContainer.withOpacity(0.9),
                      theme.colorScheme.secondaryContainer.withOpacity(0.6)
                    ]
                  : [
                      theme.colorScheme.primaryContainer.withOpacity(0.7),
                      theme.colorScheme.secondaryContainer.withOpacity(0.4)
                    ]),
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(
          color: isCompleted
              ? Colors.green.withOpacity(0.4)
              : theme.colorScheme.outlineVariant.withOpacity(0.4),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: isCompleted
                  ? Colors.green.withOpacity(0.2)
                  : theme.colorScheme.primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Icon(
              isCompleted
                  ? Icons.check_circle_rounded
                  : (isInProgress ? Icons.fitness_center_rounded : Icons.directions_run_rounded),
              size: 26,
              color: isCompleted ? Colors.green.shade800 : theme.colorScheme.primary,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isCompleted
                      ? (l10n?.trainingCompletedToday ?? 'Workout Completed Today')
                      : (isInProgress
                          ? (l10n?.trainingInProgress ?? 'Workout in Progress')
                          : (l10n?.physicalActivitiesScreenTitle ?? 'Daily Physical Activities')),
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 3),
                Text(
                  isCompleted
                      ? (l10n?.exercisesCompletedBanner(
                              session.records.where((r) => r.isCompleted).length,
                              session.records.length) ??
                          '${session.records.where((r) => r.isCompleted).length} of ${session.records.length} exercises completed.')
                      : (isInProgress
                          ? (session.routineName.isNotEmpty
                              ? '${session.routineName} • ${l10n?.exercisesCompletedCount(session.records.where((r) => r.isCompleted).length, session.records.length) ?? "${session.records.where((r) => r.isCompleted).length}/${session.records.length} completed"}'
                              : (l10n?.buildTrainingSubtitle ??
                                  'Adjust times, repetitions, and weights for today.'))
                          : (l10n?.physicalActivitiesSubtitle ??
                              'Cultivate somatic vitality through sustainable daily movement')),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailySessionCard(BuildContext context, DailyTrainingSession session) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final completedCount = session.records.where((r) => r.isCompleted).length;
    final totalCount = session.records.length;

    return Container(
      key: const Key('today_session_card'),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: theme.colorScheme.outlineVariant.withOpacity(0.6)),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n?.dailyTrainingTitle ?? 'Daily Workout Session',
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    if (session.routineName.isNotEmpty)
                      Text(
                        session.groupName != null
                            ? '${session.groupName} • ${session.routineName}'
                            : session.routineName,
                        style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.primary),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: session.isCompleted
                      ? Colors.green.withOpacity(0.15)
                      : theme.colorScheme.primaryContainer.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  l10n?.exercisesCompletedCount(completedCount, totalCount) ??
                      '$completedCount of $totalCount completed',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: session.isCompleted ? Colors.green.shade800 : theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              IconButton(
                key: const Key('delete_today_session_button'),
                icon: Icon(Icons.delete_outline_rounded, size: 20, color: theme.colorScheme.error),
                tooltip: l10n?.deleteSessionTooltip ?? 'Delete Session',
                onPressed: () => _showDeleteSessionDialog(context, session),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // LIST OF DAILY TRAINING RECORDS WITH ADJUSTMENTS
          ...session.records.map((record) {
            final isCompleted = record.isCompleted;
            final isDuration = record.activityType == 'duration';
            final setsCount = record.sets ?? 3;
            final targetLabel = isDuration
                ? '$setsCount ${l10n?.setsUnit ?? "sets"} × ${record.durationSeconds != null ? (record.durationSeconds! ~/ 60) : 30} ${l10n?.minutesUnit ?? "min"}'
                : '$setsCount ${l10n?.setsUnit ?? "sets"} × ${record.repetitions ?? 25} ${l10n?.repetitionsUnit ?? "reps"}';

            return Container(
              key: Key('physical_activity_card_${record.id}'),
              margin: const EdgeInsets.only(bottom: 12.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: isCompleted
                    ? theme.colorScheme.primaryContainer.withOpacity(0.15)
                    : theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(
                  color: isCompleted
                      ? theme.colorScheme.primary.withOpacity(0.5)
                      : theme.colorScheme.outlineVariant.withOpacity(0.4),
                  width: isCompleted ? 1.5 : 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // COMPLETION TOGGLE
                      IconButton(
                        key: Key('toggle_activity_completion_${record.id}'),
                        icon: Icon(
                          isCompleted
                              ? Icons.check_circle_rounded
                              : Icons.radio_button_unchecked_rounded,
                          color: isCompleted ? theme.colorScheme.primary : theme.colorScheme.outline,
                          size: 26,
                        ),
                        onPressed: () {
                          ref.read(trainingControllerProvider.notifier).updateDailyRecord(
                                recordId: record.id,
                                isCompleted: !isCompleted,
                              );
                        },
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          _localizeExerciseName(record.exerciseName, l10n),
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            decoration: isCompleted ? TextDecoration.lineThrough : null,
                          ),
                        ),
                      ),
                      // ACTIVITY BADGE
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondaryContainer.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Text(
                          targetLabel,
                          style: theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 12),

                  // DAILY PERFORMANCE SETTINGS (SETS, TIMES/REPS, WEIGHTS)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Wrap(
                      spacing: 12.0,
                      runSpacing: 8.0,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        // SETS STEPPER
                        _buildRecordSettingItem(
                          label: l10n?.setsLabel ?? 'Sets',
                          value: '${record.sets ?? 3}',
                          onDecrement: () {
                            final current = record.sets ?? 3;
                            if (current > 1) {
                              ref.read(trainingControllerProvider.notifier).updateDailyRecord(
                                    recordId: record.id,
                                    sets: current - 1,
                                  );
                            }
                          },
                          onIncrement: () {
                            final current = record.sets ?? 3;
                            ref.read(trainingControllerProvider.notifier).updateDailyRecord(
                                  recordId: record.id,
                                  sets: current + 1,
                                );
                          },
                        ),
                        if (record.activityType == 'duration')
                          _buildRecordSettingItem(
                            label: l10n?.metricDuration ?? 'Duration',
                            value:
                                '${record.durationSeconds != null ? (record.durationSeconds! ~/ 60) : 30} min',
                            onDecrement: () {
                              final current = (record.durationSeconds ?? 1800) ~/ 60;
                              if (current > 5) {
                                ref.read(trainingControllerProvider.notifier).updateDailyRecord(
                                      recordId: record.id,
                                      durationSeconds: (current - 5) * 60,
                                    );
                              }
                            },
                            onIncrement: () {
                              final current = (record.durationSeconds ?? 1800) ~/ 60;
                              ref.read(trainingControllerProvider.notifier).updateDailyRecord(
                                    recordId: record.id,
                                    durationSeconds: (current + 5) * 60,
                                  );
                            },
                          ),
                        if (record.activityType == 'repetition')
                          _buildRecordSettingItem(
                            label: l10n?.metricRepetitions ?? 'Reps',
                            value: '${record.repetitions ?? 25}',
                            onDecrement: () {
                              final current = record.repetitions ?? 25;
                              if (current > 1) {
                                ref.read(trainingControllerProvider.notifier).updateDailyRecord(
                                      recordId: record.id,
                                      repetitions: current - 1,
                                    );
                              }
                            },
                            onIncrement: () {
                              final current = record.repetitions ?? 25;
                              ref.read(trainingControllerProvider.notifier).updateDailyRecord(
                                    recordId: record.id,
                                    repetitions: current + 1,
                                  );
                            },
                          ),
                        _buildRecordSettingItem(
                          label: l10n?.exerciseWeightLabel ?? 'Weight',
                          value:
                              '${record.weightKg != null ? record.weightKg!.toStringAsFixed(1) : "0.0"} kg',
                          onDecrement: () {
                            final current = record.weightKg ?? 0.0;
                            if (current >= 1.0) {
                              ref.read(trainingControllerProvider.notifier).updateDailyRecord(
                                    recordId: record.id,
                                    weightKg: current - 1.0,
                                  );
                            }
                          },
                          onIncrement: () {
                            final current = record.weightKg ?? 0.0;
                            ref.read(trainingControllerProvider.notifier).updateDailyRecord(
                                  recordId: record.id,
                                  weightKg: current + 1.0,
                                );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 12),

          // CONCLUDE OR RESUME WORKOUT BUTTON
          SizedBox(
            width: double.infinity,
            child: session.isCompleted
                ? OutlinedButton.icon(
                    key: const Key('resume_training_button'),
                    onPressed: () {
                      ref.read(trainingControllerProvider.notifier).resumeTraining(session.id);
                    },
                    icon: const Icon(Icons.refresh_rounded, size: 18),
                    label: Text(l10n?.resumeTrainingButton ?? 'Resume Workout'),
                    style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12.0)),
                  )
                : FilledButton.icon(
                    key: const Key('conclude_training_button'),
                    onPressed: () {
                      ref.read(trainingControllerProvider.notifier).concludeTraining(session.id);
                    },
                    icon: const Icon(Icons.flag_rounded, size: 18),
                    label: Text(l10n?.concludeTrainingButton ?? 'Conclude Workout'),
                    style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12.0)),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordSettingItem({
    required String label,
    required String value,
    required VoidCallback onDecrement,
    required VoidCallback onIncrement,
  }) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: theme.colorScheme.outlineVariant.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label: ',
            style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
          InkWell(
            onTap: onDecrement,
            borderRadius: BorderRadius.circular(4.0),
            child: const Padding(
              padding: EdgeInsets.all(2.0),
              child: Icon(Icons.remove, size: 14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Text(
              value,
              style: theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          InkWell(
            onTap: onIncrement,
            borderRadius: BorderRadius.circular(4.0),
            child: const Padding(
              padding: EdgeInsets.all(2.0),
              child: Icon(Icons.add, size: 14),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // LEVEL 1: GROUPS SECTION
  // ==========================================
  Widget _buildGroupsSection(
    BuildContext context,
    List<WorkoutGroup> groups,
    WorkoutGroup? selectedGroup,
  ) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        l10n?.workoutGroupsTitle ?? 'Workout Groups',
                        key: const Key('workout_groups_title'),
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${groups.length}',
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    l10n?.workoutGroupsSubtitle ??
                        'Select an exercise group to view its workout routines',
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            IconButton.filledTonal(
              key: const Key('add_group_button'),
              tooltip: l10n?.addGroupButton ?? 'Add Group',
              icon: const Icon(Icons.add_rounded, size: 20),
              onPressed: () => _showAddGroupDialog(context),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // HORIZONTAL LIST OF GROUPS
        if (groups.isEmpty)
          const Center(child: CircularProgressIndicator())
        else
          SizedBox(
            height: 72,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: groups.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final group = groups[index];
                final isSelected = selectedGroup?.id == group.id;

                return InkWell(
                  key: Key('group_card_${group.id}'),
                  onTap: () {
                    setState(() {
                      _selectedGroupId = group.id;
                      _selectedRoutineId =
                          group.routines.isNotEmpty ? group.routines.first.id : null;
                    });
                  },
                  borderRadius: BorderRadius.circular(14.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? theme.colorScheme.primaryContainer.withOpacity(0.5)
                          : theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(14.0),
                      border: Border.all(
                        color: isSelected
                            ? theme.colorScheme.primary
                            : theme.colorScheme.outlineVariant.withOpacity(0.5),
                        width: isSelected ? 1.8 : 1.0,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isSelected ? Icons.folder_special_rounded : Icons.folder_outlined,
                          size: 22,
                          color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outline,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              group.name,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                                color: isSelected ? theme.colorScheme.onPrimaryContainer : null,
                              ),
                            ),
                            Text(
                              '${group.routines.length} ${group.routines.length == 1 ? "routine" : "routines"}',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                        if (isSelected) ...[
                          const SizedBox(width: 6),
                          PopupMenuButton<String>(
                            key: Key('group_menu_button_${group.id}'),
                            icon: Icon(Icons.more_vert_rounded,
                                size: 18, color: theme.colorScheme.primary),
                            padding: EdgeInsets.zero,
                            onSelected: (val) {
                              if (val == 'edit') {
                                _showEditGroupDialog(context, group);
                              } else if (val == 'delete') {
                                _showDeleteGroupDialog(context, group);
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 'edit',
                                child: Row(
                                  children: [
                                    const Icon(Icons.edit_outlined, size: 16),
                                    const SizedBox(width: 8),
                                    Text(l10n?.editGroupNameTitle ?? 'Edit Name'),
                                  ],
                                ),
                              ),
                              if (groups.length > 1)
                                PopupMenuItem(
                                  value: 'delete',
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete_outline,
                                          size: 16, color: theme.colorScheme.error),
                                      const SizedBox(width: 8),
                                      Text(
                                        l10n?.deleteGroupDialogTitle ?? 'Delete Group',
                                        style: TextStyle(color: theme.colorScheme.error),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  // ==========================================
  // LEVEL 2: ROUTINES SECTION
  // ==========================================
  Widget _buildRoutinesSection(
    BuildContext context,
    WorkoutGroup group,
    WorkoutRoutine? selectedRoutine,
    DailyTrainingSession? session,
  ) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final routines = group.routines;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        l10n?.workoutRoutinesTitle ?? 'Workout Routines',
                        key: const Key('workout_routines_title'),
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondaryContainer.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${routines.length}',
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    l10n?.workoutRoutinesSubtitle ??
                        'Select a routine to view exercises or start training',
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            IconButton.filledTonal(
              key: const Key('add_routine_button'),
              tooltip: l10n?.addRoutineButton ?? 'Add Routine',
              icon: const Icon(Icons.add_rounded, size: 20),
              onPressed: () => _showAddRoutineDialog(context, group),
            ),
          ],
        ),
        const SizedBox(height: 12),

        if (routines.isEmpty)
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(color: theme.colorScheme.outlineVariant.withOpacity(0.4)),
            ),
            child: Center(
              child: Column(
                children: [
                  Icon(Icons.fitness_center_outlined, size: 30, color: theme.colorScheme.outline),
                  const SizedBox(height: 8),
                  Text(
                    l10n?.emptyRoutinesInGroup ??
                        'No routines in this group yet. Tap above to create your first routine!',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          )
        else
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: routines.map((routine) {
                final isSelected = selectedRoutine?.id == routine.id;

                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    key: Key('routine_chip_${routine.id}'),
                    selected: isSelected,
                    showCheckmark: false,
                    avatar: Icon(
                      isSelected ? Icons.fitness_center_rounded : Icons.fitness_center_outlined,
                      size: 16,
                      color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outline,
                    ),
                    label: Text(
                      routine.name,
                      style: TextStyle(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                    onSelected: (_) {
                      setState(() {
                        _selectedRoutineId = routine.id;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  // ==========================================
  // LEVEL 3: INDIVIDUAL EXERCISES SECTION
  // ==========================================
  Widget _buildExercisesSection(
    BuildContext context,
    WorkoutGroup group,
    WorkoutRoutine routine,
    DailyTrainingSession? session,
  ) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final exercises = routine.exercises;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          routine.name,
                          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit_outlined, size: 18),
                        tooltip: l10n?.editRoutineNameTitle ?? 'Edit Routine',
                        onPressed: () => _showEditRoutineDialog(context, routine),
                      ),
                      if (group.routines.length > 1)
                        IconButton(
                          icon: Icon(Icons.delete_outline, size: 18, color: theme.colorScheme.error),
                          tooltip: l10n?.deleteRoutineDialogTitle ?? 'Delete Routine',
                          onPressed: () => _showDeleteRoutineDialog(context, routine),
                        ),
                    ],
                  ),
                  Text(
                    '${exercises.length} ${exercises.length == 1 ? "exercise" : "exercises"} configured',
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        if (exercises.isEmpty)
          Container(
            key: const Key('physical_activities_empty_card'),
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.35),
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: theme.colorScheme.outlineVariant.withOpacity(0.4)),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.fitness_center_outlined,
                  size: 36,
                  color: theme.colorScheme.primary.withOpacity(0.7),
                ),
                const SizedBox(height: 12),
                Text(
                  l10n?.emptyExercisesInRoutine ??
                      'No exercises in this routine yet. Tap below to add exercises!',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          )
        else
          ReorderableListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            buildDefaultDragHandles: false,
            itemCount: exercises.length,
            onReorder: (oldIndex, newIndex) {
              ref.read(trainingControllerProvider.notifier).reorderExercises(
                    routine.id,
                    oldIndex,
                    newIndex,
                    exercises,
                  );
            },
            itemBuilder: (context, index) {
              final ex = exercises[index];
              final isDuration = ex.activityType == 'duration';
              final setsUnit = l10n?.setsUnit ?? 'sets';
              final targetDisplay = isDuration
                  ? '${ex.targetSets} $setsUnit × ${(ex.targetDurationSeconds ?? 1800) ~/ 60} ${l10n?.minutesUnit ?? "min"}'
                  : '${ex.targetSets} $setsUnit × ${ex.targetRepetitions ?? 25} ${l10n?.repetitionsUnit ?? "reps"}';

              return Container(
                key: Key('physical_activity_card_${ex.id}'),
                margin: const EdgeInsets.only(bottom: 10.0),
                padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: theme.colorScheme.outlineVariant.withOpacity(0.4)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Icon(
                        _getExerciseIcon(ex.name, ex.activityType),
                        size: 20,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _localizeExerciseName(ex.name, l10n),
                            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Text(
                                targetDisplay,
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (ex.targetWeightKg != null) ...[
                                const SizedBox(width: 8),
                                Text(
                                  '• ${ex.targetWeightKg} kg',
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: theme.colorScheme.outline,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      key: Key('delete_activity_button_${ex.id}'),
                      icon: const Icon(Icons.close_rounded, size: 18),
                      color: theme.colorScheme.outline,
                      onPressed: () {
                        ref.read(trainingControllerProvider.notifier).deleteExercise(ex.id);
                      },
                    ),
                    ReorderableDragStartListener(
                      index: index,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Icon(Icons.drag_indicator, size: 20, color: theme.colorScheme.outline),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        const SizedBox(height: 16),

        // START WORKOUT BUTTON FOR THIS ROUTINE
        if (exercises.isNotEmpty && (session == null || session.isCompleted))
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              key: const Key('start_training_button'),
              onPressed: () {
                ref.read(trainingControllerProvider.notifier).startTraining(
                      routine,
                      groupName: group.name,
                    );
              },
              icon: const Icon(Icons.play_arrow_rounded, size: 20),
              label: Text(
                '${l10n?.trainRoutineButton ?? "Train Routine"} (${routine.name})',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
              ),
            ),
          ),
        if (exercises.isNotEmpty && (session == null || session.isCompleted))
          const SizedBox(height: 10),

        // ADD EXERCISE BUTTON
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            key: const Key('add_physical_activity_button'),
            onPressed: () => _showAddExerciseDialog(context, routine),
            icon: const Icon(Icons.add, size: 18),
            label: Text(
              l10n?.addExerciseTitle ?? 'Add Exercise',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            ),
          ),
        ),
      ],
    );
  }
}

