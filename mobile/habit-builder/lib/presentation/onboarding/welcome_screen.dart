import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/local/tables/users_table.dart';
import 'user_controller.dart';

/// The initial landing screen of the onboarding setup sequence:
/// 1. Preferred Language Selector (Esperanto = 1, Portuguese = 2, English = 3)
/// 2. User Name Input Field
/// 3. Short Grounding Assessment Description
/// 4. "Start Assessment" Action Button at the bottom
class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  late final TextEditingController _nameController;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    final initialName = ref.read(userControllerProvider).name;
    if (initialName.isNotEmpty) {
      _nameController.text = initialName;
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _nameController.dispose();
    super.dispose();
  }

  void _onNameChanged(String value) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      if (mounted) {
        ref.read(userControllerProvider.notifier).setName(value.trim());
      }
    });
  }

  void _saveNameImmediately() {
    _debounceTimer?.cancel();
    final currentText = _nameController.text.trim();
    ref.read(userControllerProvider.notifier).setName(currentText);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<UserProfileState>(userControllerProvider, (previous, next) {
      if (previous?.name != next.name && _nameController.text != next.name) {
        _nameController.text = next.name;
      }
    });

    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final userState = ref.watch(userControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/horizontal-logo.png',
          height: 30,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => Text(
            l10n?.appTitle ?? 'Bona Loko',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.shadow.withOpacity(0.08),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: theme.colorScheme.primaryContainer,
                              child: Icon(
                                Icons.spa_outlined,
                                size: 48,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 1. SELECT PREFERRED LANGUAGE
                    Text(
                      l10n?.preferredLanguage ?? 'Preferred Language',
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<AppLanguage>(
                      key: const Key('language_selector'),
                      value: userState.selectedLanguage,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.language_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 14.0,
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: AppLanguage.esperanto,
                          child: Text('Esperanto'),
                        ),
                        DropdownMenuItem(
                          value: AppLanguage.portuguese,
                          child: Text('Português'),
                        ),
                        DropdownMenuItem(
                          value: AppLanguage.english,
                          child: Text('English'),
                        ),
                      ],
                      onChanged: (AppLanguage? newLanguage) {
                        if (newLanguage != null) {
                          ref
                              .read(userControllerProvider.notifier)
                              .setLanguage(newLanguage);
                        }
                      },
                    ),
                    const SizedBox(height: 24),

                    // 2. TEXT INPUT FOR USER NAME
                    Text(
                      l10n?.yourName ?? 'Your Name',
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      key: const Key('name_input_field'),
                      controller: _nameController,
                      onChanged: _onNameChanged,
                      onSubmitted: (_) => _saveNameImmediately(),
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person_outline),
                        hintText: l10n?.namePlaceholder ?? 'Enter your name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 14.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // 3. SHORT TEXT DESCRIBING WHAT THE ASSESSMENT IS ABOUT
                    Container(
                      key: const Key('assessment_description_card'),
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          color: theme.colorScheme.outlineVariant.withOpacity(0.6),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                size: 22,
                                color: theme.colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                l10n?.assessmentTitle ?? 'Life Balance Assessment',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            l10n?.assessmentDescription ??
                                'Reflect on 12 essential areas of your life to identify priority gaps and understand where you wish to invest your time and energy to cultivate balance and sustainable daily habits.',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              height: 1.45,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),
                    const SizedBox(height: 32),

                    // 4. AT THE BOTTOM OF THE SCREEN: "START ASSESSMENT" BUTTON
                    FilledButton.icon(
                      key: const Key('start_assessment_button'),
                      onPressed: () {
                        _saveNameImmediately();
                        ref.read(userControllerProvider.notifier).setProfileConfigured(true);
                      },
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                      ),
                      icon: const Icon(Icons.arrow_forward),
                      label: Text(
                        l10n?.startAssessment ?? 'Start Assessment',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
