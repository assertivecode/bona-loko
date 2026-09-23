import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_builder/data/repositories/gratitude_repository.dart';
import 'package:habit_builder/domain/models/gratitude_entry.dart';
import 'package:habit_builder/presentation/gratitude/gratitude_section_widget.dart';

Widget _buildTestWidget(Widget child, [List<Override> overrides = const []]) {
  return ProviderScope(
    overrides: overrides,
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: Scaffold(
        body: SingleChildScrollView(child: child),
      ),
    ),
  );
}

void main() {
  group('GratitudeSectionWidget with 2 Checkable Items & Custom Reordering', () {
    testWidgets(
        'renders header, 2 checkable morning & evening rhythm cards, and empty state',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _buildTestWidget(
          const GratitudeSectionWidget(),
          [
            gratitudeEntriesStreamProvider
                .overrideWith((ref) => Stream.value([])),
            todayGratitudeCompletionStreamProvider.overrideWith(
              (ref) => Stream.value(
                DailyGratitudeCompletion(
                  id: 'comp-1',
                  date: DateTime.now(),
                  morningCompleted: false,
                  eveningCompleted: false,
                ),
              ),
            ),
          ],
        ),
      );
      await tester.pumpAndSettle();

      // 1. Header and Add button
      expect(find.byKey(const Key('gratitude_section_title')), findsOneWidget);
      expect(find.text('Gratitude Practice'), findsOneWidget);
      expect(find.byKey(const Key('add_gratitude_reason_button')), findsOneWidget);

      // 2. Morning and Evening checkable cards with checkboxes
      expect(find.byKey(const Key('gratitude_morning_card')), findsOneWidget);
      expect(find.byKey(const Key('gratitude_morning_checkbox')), findsOneWidget);
      expect(find.text('Morning (1 min)'), findsOneWidget);
      expect(find.textContaining('Contemplate your surroundings and give thanks'), findsOneWidget);

      expect(find.byKey(const Key('gratitude_evening_card')), findsOneWidget);
      expect(find.byKey(const Key('gratitude_evening_checkbox')), findsOneWidget);
      expect(find.text('Evening (5 min)'), findsOneWidget);
      expect(find.textContaining('Reflect specifically on what you are grateful for'), findsOneWidget);

      // 3. Empty state
      expect(find.byKey(const Key('gratitude_empty_card')), findsOneWidget);
    });

    testWidgets('displays ungrouped reorderable gratitude reasons without date headers',
        (WidgetTester tester) async {
      final now = DateTime.now();
      final yesterday = now.subtract(const Duration(days: 1));

      final entries = [
        GratitudeEntry(
          id: 'entry-1',
          content: 'Fresh morning breeze',
          createdAt: now,
          period: GratitudePeriod.morning,
          orderIndex: 0,
        ),
        GratitudeEntry(
          id: 'entry-2',
          content: 'Good conversation with family',
          createdAt: yesterday,
          period: GratitudePeriod.evening,
          orderIndex: 1,
        ),
      ];

      await tester.pumpWidget(
        _buildTestWidget(
          const GratitudeSectionWidget(),
          [
            gratitudeEntriesStreamProvider.overrideWith((ref) => Stream.value(entries)),
            todayGratitudeCompletionStreamProvider.overrideWith(
              (ref) => Stream.value(
                DailyGratitudeCompletion(
                  id: 'comp-1',
                  date: now,
                  morningCompleted: true,
                  morningCompletedAt: now,
                  eveningCompleted: false,
                ),
              ),
            ),
          ],
        ),
      );
      await tester.pumpAndSettle();

      // Empty state is not present
      expect(find.byKey(const Key('gratitude_empty_card')), findsNothing);

      // Date group headers do NOT exist (grouping by date removed)
      expect(find.text('Today'), findsNothing);
      expect(find.text('Yesterday'), findsNothing);

      // Reorderable list exists
      expect(find.byKey(const Key('gratitude_reorderable_list')), findsOneWidget);

      // Entries are visible
      expect(find.text('Fresh morning breeze'), findsOneWidget);
      expect(find.text('Good conversation with family'), findsOneWidget);

      // Drag handles exist for reordering
      expect(find.byIcon(Icons.drag_indicator), findsNWidgets(2));
    });

    testWidgets('opens dialog and shows period chips',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _buildTestWidget(
          const GratitudeSectionWidget(),
          [
            gratitudeEntriesStreamProvider
                .overrideWith((ref) => Stream.value([])),
            todayGratitudeCompletionStreamProvider.overrideWith(
              (ref) => Stream.value(
                DailyGratitudeCompletion(
                  id: 'comp-1',
                  date: DateTime.now(),
                  morningCompleted: false,
                  eveningCompleted: false,
                ),
              ),
            ),
          ],
        ),
      );
      await tester.pumpAndSettle();

      // Tap "Add Reason" button
      await tester.tap(find.byKey(const Key('add_gratitude_reason_button')));
      await tester.pumpAndSettle();

      // Dialog opens
      expect(find.byKey(const Key('gratitude_text_input')), findsOneWidget);
      expect(find.byKey(const Key('period_chip_morning')), findsOneWidget);
      expect(find.byKey(const Key('period_chip_evening')), findsOneWidget);
      expect(find.byKey(const Key('period_chip_anytime')), findsOneWidget);

      // Enter text
      await tester.enterText(
        find.byKey(const Key('gratitude_text_input')),
        'A quiet moment reading my favorite book',
      );
      await tester.pumpAndSettle();

      // Select evening chip
      await tester.tap(find.byKey(const Key('period_chip_evening')));
      await tester.pumpAndSettle();

      // Cancel button closes dialog
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('gratitude_text_input')), findsNothing);
    });
  });
}
