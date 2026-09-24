import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/local/tables/users_table.dart';
import '../onboarding/user_controller.dart';

/// Profile & Settings screen allowing the user to update their preferred language and name.
class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  late final TextEditingController _nameController;
  late AppLanguage _selectedLanguage;

  @override
  void initState() {
    super.initState();
    final userState = ref.read(userControllerProvider);
    _nameController = TextEditingController(text: userState.name);
    _selectedLanguage = userState.selectedLanguage;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile(BuildContext context, AppLocalizations? l10n) async {
    final updatedName = _nameController.text.trim();
    final controller = ref.read(userControllerProvider.notifier);

    await controller.setLanguage(_selectedLanguage);
    await controller.setName(updatedName);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n?.profileUpdated ?? 'Profile updated successfully'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n?.profileTitle ?? 'Profile & Settings',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          children: [
            // User avatar badge
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.shadow.withOpacity(0.08),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: theme.colorScheme.primaryContainer,
                      child: Icon(
                        Icons.person_outline,
                        size: 40,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 28),

            // LANGUAGE SETTING
            Text(
              l10n?.preferredLanguage ?? 'Preferred Language',
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<AppLanguage>(
              key: const Key('profile_language_selector'),
              value: _selectedLanguage,
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
                  setState(() {
                    _selectedLanguage = newLanguage;
                  });
                }
              },
            ),
            const SizedBox(height: 24),

            // NAME SETTING
            Text(
              l10n?.yourName ?? 'Your Name',
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              key: const Key('profile_name_input_field'),
              controller: _nameController,
              decoration: InputDecoration(
                hintText: l10n?.namePlaceholder ?? 'Enter your name',
                prefixIcon: const Icon(Icons.person_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 14.0,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // SAVE BUTTON
            ElevatedButton(
              key: const Key('save_profile_button'),
              onPressed: () => _saveProfile(context, l10n),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: Text(
                l10n?.saveProfile ?? 'Save Changes',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
