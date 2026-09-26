import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:habit_builder/app/app.dart';
import 'package:habit_builder/data/local/tables/users_table.dart';
import 'package:habit_builder/domain/models/life_area.dart';
import 'package:habit_builder/presentation/evaluation/life_area_evaluation_card.dart';
import 'package:habit_builder/presentation/evaluation/life_area_ui_extensions.dart';

void main() {
  group('LifeArea Scoring Reference Guide & Article Links Tests', () {
    test('LifeAreaUIExtensions resolves canonical URLs correctly across languages', () {
      // Contribution & Legacy
      expect(
        LifeArea.contributionLegacy.getArticleUrl(AppLanguage.english),
        'https://bonaloko.com/life-areas/contribution-and-legacy',
      );
      expect(
        LifeArea.contributionLegacy.getArticleUrl(AppLanguage.portuguese),
        'https://bonaloko.com/pt-br/areas-da-vida/contribuicao-e-legado',
      );
      expect(
        LifeArea.contributionLegacy.getArticleUrl(AppLanguage.esperanto),
        'https://bonaloko.com/eo/viv-areoj/kontribuo-kaj-heredajo',
      );

      // Health & Physical Fitness
      expect(
        LifeArea.healthFitness.getArticleUrl(AppLanguage.english),
        'https://bonaloko.com/life-areas/health-and-physical-fitness',
      );
      expect(
        LifeArea.healthFitness.getArticleUrl(AppLanguage.portuguese),
        'https://bonaloko.com/pt-br/areas-da-vida/saude-e-condicionamento-fisico',
      );
      expect(
        LifeArea.healthFitness.getArticleUrl(AppLanguage.esperanto),
        'https://bonaloko.com/eo/viv-areoj/sano-kaj-fizika-taugeco',
      );

      // Finances & Wealth
      expect(
        LifeArea.financesWealth.getArticleUrl(AppLanguage.english),
        'https://bonaloko.com/life-areas/finances-and-wealth',
      );
      expect(
        LifeArea.financesWealth.getArticleUrl(AppLanguage.portuguese),
        'https://bonaloko.com/pt-br/areas-da-vida/financas-e-prosperidade',
      );
      expect(
        LifeArea.financesWealth.getArticleUrl(AppLanguage.esperanto),
        'https://bonaloko.com/eo/viv-areoj/financoj-kaj-rico',
      );
    });

    Widget createCardHarness({
      required LifeArea area,
      required Locale locale,
      AppLanguage? language,
      double score = 5.0,
      int priority = 3,
    }) {
      return MaterialApp(
        locale: locale,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          EsperantoMaterialLocalizationsDelegate(),
          EsperantoCupertinoLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('pt', ''),
          Locale('eo', ''),
        ],
        home: Scaffold(
          body: SingleChildScrollView(
            child: LifeAreaEvaluationCard(
              lifeArea: area,
              score: score,
              currentPriority: priority,
              language: language,
            ),
          ),
        ),
      );
    }

    testWidgets('renders scoring reference guide and article button in English', (tester) async {
      await tester.pumpWidget(
        createCardHarness(
          area: LifeArea.contributionLegacy,
          locale: const Locale('en', ''),
          language: AppLanguage.english,
        ),
      );
      await tester.pumpAndSettle();

      // Guide container and title
      expect(find.byKey(const Key('scoring_reference_guide_contribution_legacy')), findsOneWidget);
      expect(find.text('Scoring Reference Guide'), findsOneWidget);

      // Reflective disclaimer
      expect(
        find.textContaining('These examples are illustrative personal references, not absolute metrics'),
        findsOneWidget,
      );

      // Scoring reference anchors (3, 6, 10)
      expect(find.byKey(const Key('score_reference_3_contribution_legacy')), findsOneWidget);
      expect(find.byKey(const Key('score_reference_6_contribution_legacy')), findsOneWidget);
      expect(find.byKey(const Key('score_reference_10_contribution_legacy')), findsOneWidget);

      expect(find.textContaining('Occasional small donations'), findsOneWidget);
      expect(find.textContaining('Consistent monthly financial contributions'), findsOneWidget);
      expect(find.textContaining('Sustained recurring contributions coupled with dedicated volunteering'), findsOneWidget);

      // Article link button
      expect(find.byKey(const Key('read_life_area_article_button_contribution_legacy')), findsOneWidget);
      expect(find.text('Read Life Area Guide'), findsOneWidget);
    });

    testWidgets('renders scoring reference guide and article button in Portuguese', (tester) async {
      await tester.pumpWidget(
        createCardHarness(
          area: LifeArea.contributionLegacy,
          locale: const Locale('pt', ''),
          language: AppLanguage.portuguese,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('scoring_reference_guide_contribution_legacy')), findsOneWidget);
      expect(find.text('Guia de Referência de Nota'), findsOneWidget);

      // Reflective disclaimer
      expect(
        find.textContaining('Estes exemplos são referências pessoais ilustrativas, não métricas absolutas'),
        findsOneWidget,
      );

      // Scoring reference anchors in Portuguese
      expect(find.textContaining('Doações pontuais ocasionais'), findsOneWidget);
      expect(find.textContaining('Contribuições financeiras mensais e consistentes'), findsOneWidget);
      expect(find.textContaining('Apoio recorrente sustentado aliado a voluntariado dedicado'), findsOneWidget);

      // Article link button
      expect(find.byKey(const Key('read_life_area_article_button_contribution_legacy')), findsOneWidget);
      expect(find.text('Ler Artigo da Área'), findsOneWidget);
    });

    testWidgets('renders scoring reference guide and article button in Esperanto', (tester) async {
      await tester.pumpWidget(
        createCardHarness(
          area: LifeArea.contributionLegacy,
          locale: const Locale('eo', ''),
          language: AppLanguage.esperanto,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('scoring_reference_guide_contribution_legacy')), findsOneWidget);
      expect(find.text('Gvidilo pri Poentaj Referencoj'), findsOneWidget);

      // Reflective disclaimer
      expect(
        find.textContaining('Ĉi tiuj ekzemploj estas ilustraj personaj referencoj, ne absolutaj metrikoj'),
        findsOneWidget,
      );

      // Scoring reference anchors in Esperanto
      expect(find.textContaining('Okazaj malgrandaj donacoj'), findsOneWidget);
      expect(find.textContaining('Konsekvenca monata financa subteno'), findsOneWidget);
      expect(find.textContaining('Daŭra monata donacado kune kun dediĉita volontulado'), findsOneWidget);

      // Article link button
      expect(find.byKey(const Key('read_life_area_article_button_contribution_legacy')), findsOneWidget);
      expect(find.text('Legi Artikolon pri Viv-Areo'), findsOneWidget);
    });
  });
}
