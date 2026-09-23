/// Canonical 12 Life Areas modeled as an integer enum (1 to 12)
/// matching specs/domain/12-life-areas.spec.md.
enum LifeArea {
  healthFitness(1, 'health_fitness'),
  emotionalWellbeing(2, 'emotional_wellbeing'),
  personalGrowth(3, 'personal_growth'),
  careerCalling(4, 'career_calling'),
  financesWealth(5, 'finances_wealth'),
  relationshipsIntimacy(6, 'relationships_intimacy'),
  familyParenting(7, 'family_parenting'),
  friendshipsCommunity(8, 'friendships_community'),
  physicalEnvironment(9, 'physical_environment'),
  recreationPlay(10, 'recreation_play'),
  focusMastery(11, 'focus_mastery'),
  contributionLegacy(12, 'contribution_legacy');

  final int value;
  final String key;

  const LifeArea(this.value, this.key);

  /// Resolves a [LifeArea] from its 1-based integer value (1..12).
  static LifeArea fromValue(int value) {
    return LifeArea.values.firstWhere(
      (area) => area.value == value,
      orElse: () => throw ArgumentError('Invalid LifeArea value: $value. Must be between 1 and 12.'),
    );
  }

  /// Resolves a [LifeArea] from its canonical snake_case key.
  static LifeArea fromKey(String key) {
    return LifeArea.values.firstWhere(
      (area) => area.key == key,
      orElse: () => throw ArgumentError('Invalid LifeArea key: $key'),
    );
  }
}
