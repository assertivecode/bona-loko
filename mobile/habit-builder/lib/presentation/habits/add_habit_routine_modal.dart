import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../domain/models/suggested_habit.dart';

/// Modal bottom sheet dialog for configuring a habit when adding it to daily routine:
/// 1. Current Habit vs New Habit (checkbox/chips)
/// 2. Hobby vs With Purpose (checkbox/chips)
/// 3. If "With Purpose", displays a small text area for purpose description (optional)
/// 4. Optional deadline date for experimentation
class AddHabitRoutineModal extends StatefulWidget {
  final SuggestedHabit habit;
  final Future<void> Function({
    required bool isNewHabit,
    required bool isPurposeful,
    String? purposeDescription,
    DateTime? experimentationDeadline,
  }) onConfirm;

  const AddHabitRoutineModal({
    super.key,
    required this.habit,
    required this.onConfirm,
  });

  static Future<void> show(
    BuildContext context, {
    required SuggestedHabit habit,
    required Future<void> Function({
      required bool isNewHabit,
      required bool isPurposeful,
      String? purposeDescription,
      DateTime? experimentationDeadline,
    }) onConfirm,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => AddHabitRoutineModal(
        habit: habit,
        onConfirm: onConfirm,
      ),
    );
  }

  @override
  State<AddHabitRoutineModal> createState() => _AddHabitRoutineModalState();
}

class _AddHabitRoutineModalState extends State<AddHabitRoutineModal> {
  // Classification: false = Current Habit, true = New Habit (defaulting to New Habit)
  bool _isNewHabit = true;

  // Nature: false = Hobby, true = With Purpose (defaulting to With Purpose)
  bool _isPurposeful = true;

  final TextEditingController _purposeController = TextEditingController();
  DateTime? _experimentationDeadline;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _purposeController.dispose();
    super.dispose();
  }

  Future<void> _pickDeadlineDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _experimentationDeadline ?? now.add(const Duration(days: 30)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 365 * 3)),
    );

    if (picked != null) {
      setState(() {
        _experimentationDeadline = picked;
      });
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final habitTitle = widget.habit.localizedTitle(l10n);

    return Container(
      padding: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 20.0,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.0,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
            ),

            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Icon(
                    widget.habit.icon,
                    size: 24,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n?.addHabitModalTitle ?? 'Add Habit to Routine',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        habitTitle,
                        key: const Key('modal_habit_title'),
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 1. CLASSIFICATION: Current Habit / New Habit
            Text(
              l10n?.addHabitClassificationLabel ?? 'Habit Classification',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    key: const Key('option_current_habit'),
                    borderRadius: BorderRadius.circular(12.0),
                    onTap: () {
                      setState(() {
                        _isNewHabit = false;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        color: !_isNewHabit
                            ? theme.colorScheme.primaryContainer.withOpacity(0.5)
                            : theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: !_isNewHabit
                              ? theme.colorScheme.primary
                              : theme.colorScheme.outlineVariant.withOpacity(0.5),
                          width: !_isNewHabit ? 1.5 : 1.0,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            !_isNewHabit
                                ? Icons.check_circle_rounded
                                : Icons.radio_button_unchecked_rounded,
                            size: 20,
                            color: !_isNewHabit
                                ? theme.colorScheme.primary
                                : theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              l10n?.habitCurrentOption ?? 'Current Habit',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: !_isNewHabit ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InkWell(
                    key: const Key('option_new_habit'),
                    borderRadius: BorderRadius.circular(12.0),
                    onTap: () {
                      setState(() {
                        _isNewHabit = true;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        color: _isNewHabit
                            ? theme.colorScheme.primaryContainer.withOpacity(0.5)
                            : theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: _isNewHabit
                              ? theme.colorScheme.primary
                              : theme.colorScheme.outlineVariant.withOpacity(0.5),
                          width: _isNewHabit ? 1.5 : 1.0,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _isNewHabit
                                ? Icons.check_circle_rounded
                                : Icons.radio_button_unchecked_rounded,
                            size: 20,
                            color: _isNewHabit
                                ? theme.colorScheme.primary
                                : theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              l10n?.habitNewOption ?? 'New Habit',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: _isNewHabit ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // 2. NATURE: Hobby / With Purpose
            Text(
              l10n?.addHabitNatureLabel ?? 'Habit Nature',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    key: const Key('option_hobby'),
                    borderRadius: BorderRadius.circular(12.0),
                    onTap: () {
                      setState(() {
                        _isPurposeful = false;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        color: !_isPurposeful
                            ? theme.colorScheme.primaryContainer.withOpacity(0.5)
                            : theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: !_isPurposeful
                              ? theme.colorScheme.primary
                              : theme.colorScheme.outlineVariant.withOpacity(0.5),
                          width: !_isPurposeful ? 1.5 : 1.0,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            !_isPurposeful
                                ? Icons.check_circle_rounded
                                : Icons.radio_button_unchecked_rounded,
                            size: 20,
                            color: !_isPurposeful
                                ? theme.colorScheme.primary
                                : theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              l10n?.habitHobbyOption ?? 'Hobby',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: !_isPurposeful ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InkWell(
                    key: const Key('option_with_purpose'),
                    borderRadius: BorderRadius.circular(12.0),
                    onTap: () {
                      setState(() {
                        _isPurposeful = true;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        color: _isPurposeful
                            ? theme.colorScheme.primaryContainer.withOpacity(0.5)
                            : theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: _isPurposeful
                              ? theme.colorScheme.primary
                              : theme.colorScheme.outlineVariant.withOpacity(0.5),
                          width: _isPurposeful ? 1.5 : 1.0,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _isPurposeful
                                ? Icons.check_circle_rounded
                                : Icons.radio_button_unchecked_rounded,
                            size: 20,
                            color: _isPurposeful
                                ? theme.colorScheme.primary
                                : theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              l10n?.habitWithPurposeOption ?? 'With Purpose',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: _isPurposeful ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // CONDITIONAL: If "With Purpose", small text area for purpose description
            if (_isPurposeful) ...[
              Text(
                l10n?.habitPurposeDescriptionLabel ?? 'Purpose Description (Optional)',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                key: const Key('habit_purpose_text_field'),
                controller: _purposeController,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: l10n?.habitPurposeDescriptionHint ??
                      'Describe what you aim to cultivate with this practice...',
                  hintStyle: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant.withOpacity(0.7),
                  ),
                  filled: true,
                  fillColor: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: theme.colorScheme.outlineVariant.withOpacity(0.6),
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
                ),
              ),
              const SizedBox(height: 18),
            ],

            // 3. EXPERIMENTATION DEADLINE DATE (Optional)
            Text(
              l10n?.habitExperimentationDeadlineLabel ??
                  'Define Deadline Date for Experimentation (Optional)',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    key: const Key('pick_deadline_date_button'),
                    onPressed: () => _pickDeadlineDate(context),
                    icon: const Icon(Icons.calendar_today_rounded, size: 16),
                    label: Text(
                      _experimentationDeadline != null
                          ? _formatDate(_experimentationDeadline!)
                          : (l10n?.habitExperimentationDeadlinePick ?? 'Select Deadline Date'),
                    ),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
                if (_experimentationDeadline != null) ...[
                  const SizedBox(width: 8),
                  IconButton(
                    key: const Key('clear_deadline_date_button'),
                    tooltip: l10n?.habitExperimentationDeadlineClear ?? 'Clear Date',
                    icon: const Icon(Icons.clear_rounded, size: 18),
                    onPressed: () {
                      setState(() {
                        _experimentationDeadline = null;
                      });
                    },
                  ),
                ],
              ],
            ),
            const SizedBox(height: 24),

            // CONFIRM ACTION BUTTON
            FilledButton(
              key: const Key('confirm_add_habit_button'),
              onPressed: _isSubmitting
                  ? null
                  : () async {
                      setState(() {
                        _isSubmitting = true;
                      });
                      try {
                        await widget.onConfirm(
                          isNewHabit: _isNewHabit,
                          isPurposeful: _isPurposeful,
                          purposeDescription: _isPurposeful && _purposeController.text.trim().isNotEmpty
                              ? _purposeController.text.trim()
                              : null,
                          experimentationDeadline: _experimentationDeadline,
                        );
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      } finally {
                        if (mounted) {
                          setState(() {
                            _isSubmitting = false;
                          });
                        }
                      }
                    },
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.0),
                ),
              ),
              child: Text(
                l10n?.addHabitConfirmButton ?? 'Add to Daily Routine',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
