import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../data/local/tables/users_table.dart';
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

  String scoreReference3(AppLocalizations l10n) {
    switch (this) {
      case LifeArea.healthFitness:
        return l10n.area_health_fitness_score_3;
      case LifeArea.emotionalWellbeing:
        return l10n.area_emotional_wellbeing_score_3;
      case LifeArea.personalGrowth:
        return l10n.area_personal_growth_score_3;
      case LifeArea.careerCalling:
        return l10n.area_career_calling_score_3;
      case LifeArea.financesWealth:
        return l10n.area_finances_wealth_score_3;
      case LifeArea.relationshipsIntimacy:
        return l10n.area_relationships_intimacy_score_3;
      case LifeArea.familyParenting:
        return l10n.area_family_parenting_score_3;
      case LifeArea.friendshipsCommunity:
        return l10n.area_friendships_community_score_3;
      case LifeArea.physicalEnvironment:
        return l10n.area_physical_environment_score_3;
      case LifeArea.recreationPlay:
        return l10n.area_recreation_play_score_3;
      case LifeArea.focusMastery:
        return l10n.area_focus_mastery_score_3;
      case LifeArea.contributionLegacy:
        return l10n.area_contribution_legacy_score_3;
    }
  }

  String scoreReference6(AppLocalizations l10n) {
    switch (this) {
      case LifeArea.healthFitness:
        return l10n.area_health_fitness_score_6;
      case LifeArea.emotionalWellbeing:
        return l10n.area_emotional_wellbeing_score_6;
      case LifeArea.personalGrowth:
        return l10n.area_personal_growth_score_6;
      case LifeArea.careerCalling:
        return l10n.area_career_calling_score_6;
      case LifeArea.financesWealth:
        return l10n.area_finances_wealth_score_6;
      case LifeArea.relationshipsIntimacy:
        return l10n.area_relationships_intimacy_score_6;
      case LifeArea.familyParenting:
        return l10n.area_family_parenting_score_6;
      case LifeArea.friendshipsCommunity:
        return l10n.area_friendships_community_score_6;
      case LifeArea.physicalEnvironment:
        return l10n.area_physical_environment_score_6;
      case LifeArea.recreationPlay:
        return l10n.area_recreation_play_score_6;
      case LifeArea.focusMastery:
        return l10n.area_focus_mastery_score_6;
      case LifeArea.contributionLegacy:
        return l10n.area_contribution_legacy_score_6;
    }
  }

  String scoreReference10(AppLocalizations l10n) {
    switch (this) {
      case LifeArea.healthFitness:
        return l10n.area_health_fitness_score_10;
      case LifeArea.emotionalWellbeing:
        return l10n.area_emotional_wellbeing_score_10;
      case LifeArea.personalGrowth:
        return l10n.area_personal_growth_score_10;
      case LifeArea.careerCalling:
        return l10n.area_career_calling_score_10;
      case LifeArea.financesWealth:
        return l10n.area_finances_wealth_score_10;
      case LifeArea.relationshipsIntimacy:
        return l10n.area_relationships_intimacy_score_10;
      case LifeArea.familyParenting:
        return l10n.area_family_parenting_score_10;
      case LifeArea.friendshipsCommunity:
        return l10n.area_friendships_community_score_10;
      case LifeArea.physicalEnvironment:
        return l10n.area_physical_environment_score_10;
      case LifeArea.recreationPlay:
        return l10n.area_recreation_play_score_10;
      case LifeArea.focusMastery:
        return l10n.area_focus_mastery_score_10;
      case LifeArea.contributionLegacy:
        return l10n.area_contribution_legacy_score_10;
    }
  }

  String getArticleUrl(AppLanguage language) {
    switch (language) {
      case AppLanguage.portuguese:
        return 'https://bonaloko.com/pt-br/areas-da-vida/$_portugueseSlug';
      case AppLanguage.esperanto:
        return 'https://bonaloko.com/eo/viv-areoj/$_esperantoSlug';
      case AppLanguage.english:
      default:
        return 'https://bonaloko.com/life-areas/$_englishSlug';
    }
  }

  String get _englishSlug {
    switch (this) {
      case LifeArea.healthFitness:
        return 'health-and-physical-fitness';
      case LifeArea.emotionalWellbeing:
        return 'mental-and-emotional-wellbeing';
      case LifeArea.personalGrowth:
        return 'personal-growth-and-learning';
      case LifeArea.careerCalling:
        return 'career-and-professional-calling';
      case LifeArea.financesWealth:
        return 'finances-and-wealth';
      case LifeArea.relationshipsIntimacy:
        return 'relationships-and-intimacy';
      case LifeArea.familyParenting:
        return 'family-and-parenting';
      case LifeArea.friendshipsCommunity:
        return 'friendships-and-community';
      case LifeArea.physicalEnvironment:
        return 'physical-environment-and-spaces';
      case LifeArea.recreationPlay:
        return 'recreation-hobbies-and-play';
      case LifeArea.focusMastery:
        return 'focus-and-attention-mastery';
      case LifeArea.contributionLegacy:
        return 'contribution-and-legacy';
    }
  }

  String get _portugueseSlug {
    switch (this) {
      case LifeArea.healthFitness:
        return 'saude-e-condicionamento-fisico';
      case LifeArea.emotionalWellbeing:
        return 'bem-estar-mental-e-emocional';
      case LifeArea.personalGrowth:
        return 'crescimento-pessoal-e-aprendizado';
      case LifeArea.careerCalling:
        return 'carreira-e-vocacao-profissional';
      case LifeArea.financesWealth:
        return 'financas-e-prosperidade';
      case LifeArea.relationshipsIntimacy:
        return 'relacionamentos-e-intimidade';
      case LifeArea.familyParenting:
        return 'familia-e-parentalidade';
      case LifeArea.friendshipsCommunity:
        return 'amizades-e-comunidade';
      case LifeArea.physicalEnvironment:
        return 'ambiente-fisico-e-espacos';
      case LifeArea.recreationPlay:
        return 'recreacao-hobbies-e-lazer';
      case LifeArea.focusMastery:
        return 'dominio-do-foco-e-atencao';
      case LifeArea.contributionLegacy:
        return 'contribuicao-e-legado';
    }
  }

  String get _esperantoSlug {
    switch (this) {
      case LifeArea.healthFitness:
        return 'sano-kaj-fizika-taugeco';
      case LifeArea.emotionalWellbeing:
        return 'mensa-kaj-emocia-bonfarto';
      case LifeArea.personalGrowth:
        return 'persona-kresko-kaj-lernado';
      case LifeArea.careerCalling:
        return 'kariero-kaj-profesia-vokigo';
      case LifeArea.financesWealth:
        return 'financoj-kaj-rico';
      case LifeArea.relationshipsIntimacy:
        return 'rilatoj-kaj-intimeco';
      case LifeArea.familyParenting:
        return 'familio-kaj-gepatreco';
      case LifeArea.friendshipsCommunity:
        return 'amikecoj-kaj-komunumo';
      case LifeArea.physicalEnvironment:
        return 'fizika-medio-kaj-spacoj';
      case LifeArea.recreationPlay:
        return 'distrado-satokupoj-kaj-ludo';
      case LifeArea.focusMastery:
        return 'majstreco-pri-atento-kaj-fokuso';
      case LifeArea.contributionLegacy:
        return 'kontribuo-kaj-heredajo';
    }
  }
}
