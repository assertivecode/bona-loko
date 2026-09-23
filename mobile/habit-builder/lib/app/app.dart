import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme.dart';
import '../presentation/home/home_screen.dart';
import '../presentation/onboarding/assessment_wizard_screen.dart';
import '../presentation/onboarding/user_controller.dart';
import '../presentation/onboarding/welcome_screen.dart';

/// Fallback MaterialLocalizations delegate for Esperanto ('eo').
class EsperantoMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const EsperantoMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'eo';

  @override
  Future<MaterialLocalizations> load(Locale locale) =>
      DefaultMaterialLocalizations.load(locale);

  @override
  bool shouldReload(EsperantoMaterialLocalizationsDelegate old) => false;
}

/// Fallback CupertinoLocalizations delegate for Esperanto ('eo').
class EsperantoCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const EsperantoCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'eo';

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      DefaultCupertinoLocalizations.load(locale);

  @override
  bool shouldReload(EsperantoCupertinoLocalizationsDelegate old) => false;
}

/// Root application widget for Bona Loko Habit Builder.
class BonaLokoApp extends ConsumerWidget {
  const BonaLokoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeLocale = ref.watch(activeLocaleProvider);
    final userState = ref.watch(userControllerProvider);

    Widget homeWidget;
    if (userState.isLoading) {
      homeWidget = const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    } else if (userState.onboardingCompleted) {
      homeWidget = const HomeScreen();
    } else if (userState.profileConfigured) {
      homeWidget = const AssessmentWizardScreen();
    } else {
      homeWidget = const WelcomeScreen();
    }

    return MaterialApp(
      title: 'Bona Loko',
      debugShowCheckedModeBanner: false,
      locale: activeLocale,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      localizationsDelegates: const [
        ...AppLocalizations.localizationsDelegates,
        EsperantoMaterialLocalizationsDelegate(),
        EsperantoCupertinoLocalizationsDelegate(),
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: homeWidget,
    );
  }
}
