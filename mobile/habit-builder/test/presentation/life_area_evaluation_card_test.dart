import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_builder/domain/models/life_area.dart';
import 'package:habit_builder/presentation/evaluation/life_area_evaluation_card.dart';

Widget _buildTestWidget(Widget child) {
  return MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    locale: const Locale('en'),
    home: Scaffold(
      body: SingleChildScrollView(child: child),
    ),
  );
}

void main() {
  group('Centralized LifeAreaEvaluationCard Widget', () {
    testWidgets('renders all required evaluation fields, icons, and short description text',
        (WidgetTester tester) async {
      double currentScore = 7.5;
      int currentPriority = 5;

      await tester.pumpWidget(
        _buildTestWidget(
          LifeAreaEvaluationCard(
            lifeArea: LifeArea.healthFitness,
            score: currentScore,
            currentPriority: currentPriority,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // 1. Renders title and area number
      expect(find.text('Health & Physical Fitness'), findsOneWidget);
      expect(find.text('Area 1 of 12'), findsOneWidget);

      // 2. Renders short description text explaining what is evaluated
      expect(
        find.textContaining('Vitality, regular movement and exercise, restorative sleep'),
        findsOneWidget,
      );

      // 3. Renders score label and half-decimal value display
      expect(find.text('Current State Score'), findsOneWidget);
      expect(find.text('7.5 / 10'), findsOneWidget);

      // 4. Renders priority label, 5-tier selector, and concept description
      expect(find.text('Priority to Focus / Practice'), findsOneWidget);
      expect(find.text('5 - High Priority'), findsOneWidget);
      expect(
        find.text('Active effort focusing in having a significant improvement in the current score'),
        findsOneWidget,
      );

      for (int i = 1; i <= 5; i++) {
        expect(
          find.byKey(Key('priority_button_health_fitness_$i')),
          findsOneWidget,
        );
      }
    });

    testWidgets('increments and decrements score in 0.5 steps when buttons are pressed',
        (WidgetTester tester) async {
      double updatedScore = 5.0;

      await tester.pumpWidget(
        _buildTestWidget(
          StatefulBuilder(
            builder: (context, setState) {
              return LifeAreaEvaluationCard(
                lifeArea: LifeArea.focusMastery,
                score: updatedScore,
                currentPriority: 3,
                onScoreChanged: (val) {
                  setState(() {
                    updatedScore = val;
                  });
                },
              );
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('5.0 / 10'), findsOneWidget);

      // Tap increment (+0.5)
      await tester.tap(find.byKey(const Key('score_increment_focus_mastery')));
      await tester.pumpAndSettle();
      expect(updatedScore, 5.5);
      expect(find.text('5.5 / 10'), findsOneWidget);

      // Tap decrement (-0.5)
      await tester.tap(find.byKey(const Key('score_decrement_focus_mastery')));
      await tester.pumpAndSettle();
      expect(updatedScore, 5.0);
      expect(find.text('5.0 / 10'), findsOneWidget);
    });

    testWidgets('changes priority to 5 when priority button 5 is tapped',
        (WidgetTester tester) async {
      int updatedPriority = 2;

      await tester.pumpWidget(
        _buildTestWidget(
          StatefulBuilder(
            builder: (context, setState) {
              return LifeAreaEvaluationCard(
                lifeArea: LifeArea.emotionalWellbeing,
                score: 6.0,
                currentPriority: updatedPriority,
                onPriorityChanged: (val) {
                  setState(() {
                    updatedPriority = val;
                  });
                },
              );
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('2 - Gentle Maintenance'), findsOneWidget);

      // Tap priority 5 button
      await tester.tap(find.byKey(const Key('priority_button_emotional_wellbeing_5')));
      await tester.pumpAndSettle();

      expect(updatedPriority, 5);
      expect(find.text('5 - High Priority'), findsOneWidget);
      expect(
        find.text('Active effort focusing in having a significant improvement in the current score'),
        findsOneWidget,
      );
    });
  });
}
