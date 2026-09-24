import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/gratitude_repository.dart';
import '../../domain/models/gratitude_entry.dart';
import 'gratitude_controller.dart';

/// Centralized widget for the Gratitude Practice section.
///
/// Features:
/// - 2 Checkable items for daily completion: Morning Grounding (1 min) and Evening Reflection (5 min).
/// - Ungrouped list of gratitude reasons ordered by user preference with drag-and-drop reordering.
/// - Ability to add and delete gratitude reasons.
class GratitudeSectionWidget extends ConsumerWidget {
  const GratitudeSectionWidget({super.key});

  void _showAddEntryDialog(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    GratitudePeriod selectedPeriod = now.hour < 12
        ? GratitudePeriod.morning
        : (now.hour >= 18 ? GratitudePeriod.evening : GratitudePeriod.anytime);

    final textController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) {
        final theme = Theme.of(bottomSheetContext);
        final l10n = AppLocalizations.of(bottomSheetContext);

        return StatefulBuilder(
          builder: (context, setModalState) {
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
                      l10n?.gratitudeDialogTitle ?? 'Novo Motivo de Gratidão',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      key: const Key('gratitude_text_input'),
                      controller: textController,
                      maxLines: 3,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: l10n?.gratitudePlaceholder ??
                            'Pelo que você é grato(a) agora? (Busque um detalhe concreto)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8.0,
                      children: [
                        ChoiceChip(
                          key: const Key('period_chip_morning'),
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.wb_sunny_outlined, size: 16),
                              const SizedBox(width: 4),
                              Text(l10n?.gratitudePeriodMorning ?? 'Manhã'),
                            ],
                          ),
                          selected: selectedPeriod == GratitudePeriod.morning,
                          onSelected: (selected) {
                            if (selected) {
                              setModalState(() => selectedPeriod = GratitudePeriod.morning);
                            }
                          },
                        ),
                        ChoiceChip(
                          key: const Key('period_chip_evening'),
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.bedtime_outlined, size: 16),
                              const SizedBox(width: 4),
                              Text(l10n?.gratitudePeriodEvening ?? 'Noite'),
                            ],
                          ),
                          selected: selectedPeriod == GratitudePeriod.evening,
                          onSelected: (selected) {
                            if (selected) {
                              setModalState(() => selectedPeriod = GratitudePeriod.evening);
                            }
                          },
                        ),
                        ChoiceChip(
                          key: const Key('period_chip_anytime'),
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.schedule_outlined, size: 16),
                              const SizedBox(width: 4),
                              Text(l10n?.gratitudePeriodAnytime ?? 'Livre'),
                            ],
                          ),
                          selected: selectedPeriod == GratitudePeriod.anytime,
                          onSelected: (selected) {
                            if (selected) {
                              setModalState(() => selectedPeriod = GratitudePeriod.anytime);
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(bottomSheetContext).pop(),
                          child: Text(l10n?.gratitudeCancel ?? 'Cancelar'),
                        ),
                        const SizedBox(width: 8),
                        FilledButton.icon(
                          key: const Key('save_gratitude_button'),
                          onPressed: () async {
                            final text = textController.text.trim();
                            if (text.isNotEmpty) {
                              await ref
                                  .read(gratitudeControllerProvider.notifier)
                                  .addEntry(content: text, period: selectedPeriod);
                              if (bottomSheetContext.mounted) {
                                Navigator.of(bottomSheetContext).pop();
                              }
                            }
                          },
                          icon: const Icon(Icons.check, size: 18),
                          label: Text(l10n?.gratitudeSave ?? 'Salvar Motivo'),
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
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final entriesAsync = ref.watch(gratitudeEntriesStreamProvider);
    final completionAsync = ref.watch(todayGratitudeCompletionStreamProvider);

    final completion = completionAsync.valueOrNull ??
        DailyGratitudeCompletion(
          id: '',
          date: DateTime.now(),
          morningCompleted: false,
          eveningCompleted: false,
        );

    return Container(
      key: const Key('gratitude_section_container'),
      margin: const EdgeInsets.only(top: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER ROW
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Icon(
                  Icons.favorite_rounded,
                  color: theme.colorScheme.primary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n?.gratitudeSectionTitle ?? 'Prática da Gratidão',
                      key: const Key('gratitude_section_title'),
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n?.gratitudeSectionSubtitle ??
                          'Cultive a gratidão ao longo do dia',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // TWO CHECKABLE DAILY COMPLETION ITEMS (MORNING 1 MIN & EVENING 5 MIN)
          _buildCheckableRhythmCard(
            context: context,
            key: const Key('gratitude_morning_card'),
            checkboxKey: const Key('gratitude_morning_checkbox'),
            title: l10n?.gratitudeMorningRec ?? 'Manhã (1 min)',
            description: l10n?.gratitudeMorningDesc ??
                'Contemple o ambiente ao seu redor e agradeça pelas dádivas na sua vida.',
            icon: Icons.wb_sunny_outlined,
            iconColor: Colors.amber.shade700,
            isChecked: completion.morningCompleted,
            completedAt: completion.morningCompletedAt,
            onChanged: (val) {
              ref.read(gratitudeControllerProvider.notifier).toggleMorning(DateTime.now());
            },
          ),
          const SizedBox(height: 10),
          _buildCheckableRhythmCard(
            context: context,
            key: const Key('gratitude_evening_card'),
            checkboxKey: const Key('gratitude_evening_checkbox'),
            title: l10n?.gratitudeEveningRec ?? 'Noite (5 min)',
            description: l10n?.gratitudeEveningDesc ??
                'Reflita sobre aquilo que você é grato, de forma específica, que aconteceu no seu dia.',
            icon: Icons.bedtime_outlined,
            iconColor: Colors.indigo.shade400,
            isChecked: completion.eveningCompleted,
            completedAt: completion.eveningCompletedAt,
            onChanged: (val) {
              ref.read(gratitudeControllerProvider.notifier).toggleEvening(DateTime.now());
            },
          ),
          const SizedBox(height: 20),

          // GRATITUDE REASONS HEADER WITH REORDER HINT
          Row(
            children: [
              Text(
                l10n?.gratitudeAddButton ?? 'Motivos de Gratidão',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              if (entriesAsync.valueOrNull != null && entriesAsync.valueOrNull!.isNotEmpty)
                Tooltip(
                  message: l10n?.gratitudeReorderTooltip ?? 'Arraste para reordenar',
                  child: Row(
                    children: [
                      Icon(Icons.swap_vert, size: 16, color: theme.colorScheme.outline),
                      const SizedBox(width: 4),
                      Text(
                        l10n?.gratitudeReorderTooltip ?? 'Reordenar',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),

          // UNGROUPED REORDERABLE GRATITUDE REASONS LIST
          entriesAsync.when(
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
            ),
            error: (err, stack) => Text(
              'Error loading gratitude entries: $err',
              style: TextStyle(color: theme.colorScheme.error),
            ),
            data: (entries) {
              if (entries.isEmpty) {
                return Container(
                  key: const Key('gratitude_empty_card'),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.spa_outlined,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          l10n?.gratitudeEmptyState ??
                              'Nenhum motivo registrado ainda hoje. Que tal dedicar 1 minuto agora?',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ReorderableListView.builder(
                key: const Key('gratitude_reorderable_list'),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                buildDefaultDragHandles: false,
                itemCount: entries.length,
                onReorder: (oldIndex, newIndex) {
                  ref
                      .read(gratitudeControllerProvider.notifier)
                      .reorderEntries(oldIndex, newIndex, entries);
                },
                itemBuilder: (context, index) {
                  final entry = entries[index];
                  return Container(
                    key: Key('gratitude_entry_card_${entry.id}'),
                    margin: const EdgeInsets.only(bottom: 8.0),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14.0,
                      vertical: 10.0,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: theme.colorScheme.outlineVariant.withOpacity(0.4),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildPeriodIcon(entry.period, theme),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                entry.content,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  height: 1.35,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _formatTime(entry.createdAt),
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: theme.colorScheme.outline,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          key: Key('delete_gratitude_button_${entry.id}'),
                          icon: const Icon(Icons.close_rounded, size: 18),
                          color: theme.colorScheme.outline,
                          tooltip: l10n?.gratitudeDeleteTooltip ?? 'Remover motivo',
                          onPressed: () {
                            ref
                                .read(gratitudeControllerProvider.notifier)
                                .deleteEntry(entry.id);
                          },
                        ),
                        ReorderableDragStartListener(
                          index: index,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                            child: Icon(
                              Icons.drag_indicator,
                              size: 20,
                              color: theme.colorScheme.outline.withOpacity(0.7),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 14),

          // ADD GRATITUDE REASON BUTTON
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              key: const Key('add_gratitude_reason_button'),
              onPressed: () => _showAddEntryDialog(context, ref),
              icon: const Icon(Icons.add, size: 18),
              label: Text(
                l10n?.gratitudeAddButton ?? 'Motivos de Gratidão',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckableRhythmCard({
    required BuildContext context,
    required Key key,
    required Key checkboxKey,
    required String title,
    required String description,
    required IconData icon,
    required Color iconColor,
    required bool isChecked,
    required DateTime? completedAt,
    required ValueChanged<bool?> onChanged,
  }) {
    final theme = Theme.of(context);

    return InkWell(
      key: key,
      onTap: () => onChanged(!isChecked),
      borderRadius: BorderRadius.circular(14.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: isChecked
              ? theme.colorScheme.primaryContainer.withOpacity(0.25)
              : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(
            color: isChecked
                ? theme.colorScheme.primary.withOpacity(0.6)
                : theme.colorScheme.outlineVariant.withOpacity(0.5),
            width: isChecked ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
              key: checkboxKey,
              value: isChecked,
              onChanged: onChanged,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            const SizedBox(width: 8),
            Icon(icon, size: 20, color: iconColor),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          decoration: isChecked ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      if (isChecked && completedAt != null) ...[
                        const SizedBox(width: 8),
                        Text(
                          _formatTime(completedAt),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      height: 1.25,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodIcon(GratitudePeriod period, ThemeData theme) {
    switch (period) {
      case GratitudePeriod.morning:
        return Icon(
          Icons.wb_sunny_outlined,
          size: 18,
          color: Colors.amber.shade700,
        );
      case GratitudePeriod.evening:
        return Icon(
          Icons.bedtime_outlined,
          size: 18,
          color: Colors.indigo.shade400,
        );
      case GratitudePeriod.anytime:
        return Icon(
          Icons.schedule_outlined,
          size: 18,
          color: theme.colorScheme.primary,
        );
    }
  }

  static String _formatTime(DateTime dt) {
    return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
