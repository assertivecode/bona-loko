import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:habit_builder/app/app.dart';
import 'package:habit_builder/presentation/profile/profile_screen.dart';
import 'package:habit_builder/presentation/profile/sponsor_screen.dart';
import '../test_helper.dart';

void main() {
  setUpAll(() {
    setupTestDatabase();
  });

  group('SponsorScreen & Profile Integration Widget Tests', () {
    Widget buildTestWidget({
      required Widget child,
      Locale locale = const Locale('en'),
    }) {
      return ProviderScope(
        child: MaterialApp(
          locale: locale,
          localizationsDelegates: const [
            ...AppLocalizations.localizationsDelegates,
            EsperantoMaterialLocalizationsDelegate(),
            EsperantoCupertinoLocalizationsDelegate(),
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: child,
        ),
      );
    }

    testWidgets('renders all sponsor sections in English', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        buildTestWidget(
          child: const SponsorScreen(),
          locale: const Locale('en'),
        ),
      );
      await tester.pumpAndSettle();

      // Check titles & pillars
      expect(find.text('Support Bona Loko'), findsAtLeastNWidgets(1));
      expect(find.text('Open source, privacy-first, and uncorruptible'), findsOneWidget);
      expect(find.text('Why Your Support Matters'), findsOneWidget);
      expect(find.text('100% Ad-Free & Privacy First'), findsOneWidget);
      expect(find.text('Independent & Uncorruptible'), findsOneWidget);
      expect(find.text('Trilingual & Open Source'), findsOneWidget);

      // Check action button
      expect(find.byKey(const Key('sponsor_github_button')), findsOneWidget);
      expect(find.text('Sponsor on GitHub'), findsOneWidget);

      // Check Rule 4 disclaimer
      expect(find.text('Rule 4: Unconditional Giving'), findsOneWidget);
    });

    testWidgets('renders properly in Portuguese (pt)', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        buildTestWidget(
          child: const SponsorScreen(),
          locale: const Locale('pt'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Apoie o Bona Loko'), findsAtLeastNWidgets(1));
      expect(find.text('Código aberto, focado na privacidade e incorruptível'), findsOneWidget);
      expect(find.text('Por Que o Seu Apoio Importa'), findsOneWidget);
      expect(find.text('100% Sem Anúncios & Privacidade'), findsOneWidget);
      expect(find.text('Independente & Incorruptível'), findsOneWidget);
      expect(find.text('Trilíngue & Código Aberto'), findsOneWidget);
      expect(find.text('Apoiar no GitHub'), findsOneWidget);
      expect(find.text('Regra 4: Doação Incondicional'), findsOneWidget);
    });

    testWidgets('renders properly in Esperanto (eo)', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        buildTestWidget(
          child: const SponsorScreen(),
          locale: const Locale('eo'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Subtenu Bona Loko'), findsAtLeastNWidgets(1));
      expect(find.text('Malfermfonta, fokusita al privateco kaj nekoruptebla'), findsOneWidget);
      expect(find.text('Kial Via Subteno Gravas'), findsOneWidget);
      expect(find.text('100% Senreklama & Unue Privateco'), findsOneWidget);
      expect(find.text('Sendependa & Nekoruptebla'), findsOneWidget);
      expect(find.text('Trilingva & Malfermfonta'), findsOneWidget);
      expect(find.text('Subteni ĉe GitHub'), findsOneWidget);
      expect(find.text('Regulo 4: Senkondiĉa Donaco'), findsOneWidget);
    });

    testWidgets('ProfileScreen shows sponsor tile and navigates to SponsorScreen', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        buildTestWidget(
          child: const ProfileScreen(),
          locale: const Locale('en'),
        ),
      );
      await tester.pumpAndSettle();

      // Find the sponsor tile on ProfileScreen
      final sponsorTileFinder = find.byKey(const Key('profile_sponsor_tile'));
      expect(sponsorTileFinder, findsOneWidget);

      // Scroll into view if needed and tap
      await tester.ensureVisible(sponsorTileFinder);
      await tester.pumpAndSettle();
      await tester.tap(sponsorTileFinder);
      await tester.pumpAndSettle();

      // SponsorScreen is displayed
      expect(find.byKey(const Key('sponsor_github_button')), findsOneWidget);
      expect(find.text('Why Your Support Matters'), findsOneWidget);
    });

    testWidgets('ProfileScreen renders Assertive Code initiative link at bottom', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        buildTestWidget(
          child: const ProfileScreen(),
          locale: const Locale('en'),
        ),
      );
      await tester.pumpAndSettle();

      final initiativeFinder = find.byKey(const Key('profile_initiative_link'));
      expect(initiativeFinder, findsOneWidget);

      await tester.ensureVisible(initiativeFinder);
      await tester.pumpAndSettle();

      expect(find.text('Assertive Code Open Source Initiative'), findsOneWidget);
    });
  });
}
