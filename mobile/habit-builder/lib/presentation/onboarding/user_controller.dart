import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/local/tables/users_table.dart';
import '../../data/repositories/user_repository.dart';

/// State representation for the user's profile, language settings, and onboarding status.
class UserProfileState {
  final String? id;
  final String name;
  final AppLanguage selectedLanguage;
  final bool onboardingCompleted;
  final bool profileConfigured;
  final bool isLoading;

  const UserProfileState({
    this.id,
    this.name = '',
    this.selectedLanguage = AppLanguage.english,
    this.onboardingCompleted = false,
    this.profileConfigured = false,
    this.isLoading = false,
  });

  UserProfileState copyWith({
    String? id,
    String? name,
    AppLanguage? selectedLanguage,
    bool? onboardingCompleted,
    bool? profileConfigured,
    bool? isLoading,
  }) {
    return UserProfileState(
      id: id ?? this.id,
      name: name ?? this.name,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      profileConfigured: profileConfigured ?? this.profileConfigured,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// Controller managing user profile loading, name input, preferred language, and onboarding progression.
class UserController extends StateNotifier<UserProfileState> {
  final UserRepository _repository;

  UserController(this._repository) : super(const UserProfileState(isLoading: true)) {
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final user = await _repository.getUser();
      if (user != null) {
        final bool hasConfiguredName = user.name.trim().isNotEmpty;
        state = state.copyWith(
          id: user.id,
          name: user.name,
          selectedLanguage: user.selectedLanguage,
          onboardingCompleted: user.onboardingCompleted,
          profileConfigured: user.onboardingCompleted || hasConfiguredName,
          isLoading: false,
        );
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (_) {
      state = state.copyWith(isLoading: false);
    }
  }

  /// Sets the preferred language and persists to SQLite.
  Future<void> setLanguage(AppLanguage language) async {
    state = state.copyWith(selectedLanguage: language);
    final saved = await _repository.saveLanguage(language);
    state = state.copyWith(
      id: saved.id,
      selectedLanguage: saved.selectedLanguage,
      onboardingCompleted: saved.onboardingCompleted,
    );
  }

  /// Updates the user's name and persists to SQLite.
  Future<void> setName(String name) async {
    state = state.copyWith(name: name);
    final saved = await _repository.saveName(name);
    state = state.copyWith(
      id: saved.id,
      name: saved.name,
      onboardingCompleted: saved.onboardingCompleted,
    );
  }

  /// Marks profile as configured (user finished Welcome screen and moves to assessment).
  void setProfileConfigured(bool configured) {
    state = state.copyWith(profileConfigured: configured);
  }

  /// Marks the onboarding sequence as completed and persists to SQLite.
  Future<void> completeOnboarding() async {
    state = state.copyWith(
      onboardingCompleted: true,
      profileConfigured: true,
    );
    final saved = await _repository.setOnboardingCompleted(true);
    state = state.copyWith(
      id: saved.id,
      onboardingCompleted: saved.onboardingCompleted,
      profileConfigured: true,
    );
  }

  /// Resets onboarding status (useful for restarting assessment flow).
  Future<void> resetOnboarding() async {
    state = state.copyWith(
      onboardingCompleted: false,
      profileConfigured: false,
    );
    final saved = await _repository.setOnboardingCompleted(false);
    state = state.copyWith(
      id: saved.id,
      onboardingCompleted: saved.onboardingCompleted,
      profileConfigured: false,
    );
  }
}

/// Provider for the UserController.
final userControllerProvider =
    StateNotifierProvider<UserController, UserProfileState>((ref) {
  final repo = ref.watch(userRepositoryProvider);
  return UserController(repo);
});

/// Provider for the active Flutter [Locale] derived from the user's preferred language.
final activeLocaleProvider = Provider<Locale>((ref) {
  final userState = ref.watch(userControllerProvider);
  return Locale(userState.selectedLanguage.code);
});

/// Provider indicating whether the user has completed onboarding.
final onboardingStatusProvider = Provider<bool>((ref) {
  final userState = ref.watch(userControllerProvider);
  return userState.onboardingCompleted;
});
