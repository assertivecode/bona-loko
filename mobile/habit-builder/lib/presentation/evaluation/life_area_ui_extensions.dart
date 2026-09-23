import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../domain/models/life_area.dart';

/// Presentation extensions for [LifeArea] mapping domain enums to icons and localized text.
extension LifeAreaUIExtensions on LifeArea {
  IconData get icon {
    switch (this) {
      case LifeArea.healthFitness:
        return Icons.fitness_center_outlined;
      case LifeArea.emotionalWellbeing:
        return Icons.psychology_outlined;
      case LifeArea.personalGrowth:
        return Icons.school_outlined;
      case LifeArea.careerCalling:
        return Icons.work_outline;
      case LifeArea.financesWealth:
        return Icons.account_balance_wallet_outlined;
      case LifeArea.relationshipsIntimacy:
        return Icons.favorite_outline;
      case LifeArea.familyParenting:
        return Icons.family_restroom_outlined;
      case LifeArea.friendshipsCommunity:
        return Icons.groups_outlined;
      case LifeArea.physicalEnvironment:
        return Icons.home_work_outlined;
      case LifeArea.recreationPlay:
        return Icons.sports_esports_outlined;
      case LifeArea.focusMastery:
        return Icons.track_changes_outlined;
      case LifeArea.contributionLegacy:
        return Icons.volunteer_activism_outlined;
    }
  }

  String localizedName(AppLocalizations l10n) {
    switch (this) {
      case LifeArea.healthFitness:
        return l10n.area_health_fitness_name;
      case LifeArea.emotionalWellbeing:
        return l10n.area_emotional_wellbeing_name;
      case LifeArea.personalGrowth:
        return l10n.area_personal_growth_name;
      case LifeArea.careerCalling:
        return l10n.area_career_calling_name;
      case LifeArea.financesWealth:
        return l10n.area_finances_wealth_name;
      case LifeArea.relationshipsIntimacy:
        return l10n.area_relationships_intimacy_name;
      case LifeArea.familyParenting:
        return l10n.area_family_parenting_name;
      case LifeArea.friendshipsCommunity:
        return l10n.area_friendships_community_name;
      case LifeArea.physicalEnvironment:
        return l10n.area_physical_environment_name;
      case LifeArea.recreationPlay:
        return l10n.area_recreation_play_name;
      case LifeArea.focusMastery:
        return l10n.area_focus_mastery_name;
      case LifeArea.contributionLegacy:
        return l10n.area_contribution_legacy_name;
    }
  }

  String localizedDescription(AppLocalizations l10n) {
    switch (this) {
      case LifeArea.healthFitness:
        return l10n.area_health_fitness_desc;
      case LifeArea.emotionalWellbeing:
        return l10n.area_emotional_wellbeing_desc;
      case LifeArea.personalGrowth:
        return l10n.area_personal_growth_desc;
      case LifeArea.careerCalling:
        return l10n.area_career_calling_desc;
      case LifeArea.financesWealth:
        return l10n.area_finances_wealth_desc;
      case LifeArea.relationshipsIntimacy:
        return l10n.area_relationships_intimacy_desc;
      case LifeArea.familyParenting:
        return l10n.area_family_parenting_desc;
      case LifeArea.friendshipsCommunity:
        return l10n.area_friendships_community_desc;
      case LifeArea.physicalEnvironment:
        return l10n.area_physical_environment_desc;
      case LifeArea.recreationPlay:
        return l10n.area_recreation_play_desc;
      case LifeArea.focusMastery:
        return l10n.area_focus_mastery_desc;
      case LifeArea.contributionLegacy:
        return l10n.area_contribution_legacy_desc;
    }
  }
}
