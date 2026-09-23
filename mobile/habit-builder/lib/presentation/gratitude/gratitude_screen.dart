import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'gratitude_section_widget.dart';

/// Dedicated screen for the user to practice gratitude.
///
/// Features:
/// - Clear AppBar with back navigation.
/// - Guidance for the two daily rhythms: 1 minute morning & 5 minutes evening.
/// - Log of gratitude reasons grouped by calendar day with period icons.
/// - Ability to register and delete gratitude entries.
class GratitudePracticeScreen extends ConsumerWidget {
  const GratitudePracticeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n?.gratitudeSectionTitle ?? 'Gratitude Practice',
          key: const Key('gratitude_screen_title'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GratitudeSectionWidget(),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
