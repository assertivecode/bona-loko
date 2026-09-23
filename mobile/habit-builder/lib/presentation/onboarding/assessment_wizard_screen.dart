import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/life_area.dart';
import '../evaluation/evaluation_controller.dart';
import '../evaluation/life_area_evaluation_card.dart';
import 'user_controller.dart';

/// Guided 12-step onboarding wizard for assessing all 12 Life Areas.
///
/// Reuses the centralized [LifeAreaEvaluationCard] component for each area step.
/// Automatically detects progress and allows resuming at the first unevaluated area.
/// Each step advances and immediately saves to SQLite "life_areas_evaluations".
/// Final completion marks onboarding complete, automatically navigating to the Home Page.
class AssessmentWizardScreen extends ConsumerStatefulWidget {
  final int? initialStep;

  const AssessmentWizardScreen({
    super.key,
    this.initialStep,
  });

  @override
  ConsumerState<AssessmentWizardScreen> createState() => _AssessmentWizardScreenState();
}

class _AssessmentWizardScreenState extends ConsumerState<AssessmentWizardScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    final controllerStep = ref.read(assessmentControllerProvider).currentStepIndex;
    final startStep = widget.initialStep ?? controllerStep;
    _pageController = PageController(initialPage: startStep);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToStep(int step) {
    ref.read(assessmentControllerProvider.notifier).setStep(step);
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        step,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AssessmentState>(assessmentControllerProvider, (previous, next) {
      if (previous?.currentStepIndex != next.currentStepIndex &&
          _pageController.hasClients &&
          _pageController.page?.round() != next.currentStepIndex) {
        _pageController.jumpToPage(next.currentStepIndex);
      }
    });

    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final assessmentState = ref.watch(assessmentControllerProvider);
    final int currentStep = assessmentState.currentStepIndex;
    final int totalSteps = LifeArea.values.length;
    final double progress = (currentStep + 1) / totalSteps;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          key: const Key('wizard_back_to_welcome_button'),
          icon: const Icon(Icons.arrow_back),
          tooltip: l10n?.previousArea ?? 'Back',
          onPressed: () {
            ref.read(userControllerProvider.notifier).setProfileConfigured(false);
          },
        ),
        title: Text(
          l10n?.assessmentTitle ?? 'Life Balance Assessment',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6.0),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
            minHeight: 4.0,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // STEP INDICATOR HEADER (TRANSLATED)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n?.wizardStepIndicator(currentStep + 1, totalSteps) ??
                        'Step ${currentStep + 1} of $totalSteps',
                    key: const Key('wizard_step_indicator'),
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  Text(
                    l10n?.wizardPercentCompleted((progress * 100).toInt()) ??
                        '${(progress * 100).toInt()}% Completed',
                    key: const Key('wizard_percent_completed'),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),

            // PAGEVIEW HOSTING REUSABLE CENTRALIZED LifeAreaEvaluationCard
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(), // Controlled via buttons
                itemCount: totalSteps,
                itemBuilder: (context, index) {
                  final lifeArea = LifeArea.values[index];
                  final currentScore = assessmentState.scores[lifeArea] ?? 5.0;
                  final currentPriority = assessmentState.priorities[lifeArea] ?? 3;

                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: LifeAreaEvaluationCard(
                      lifeArea: lifeArea,
                      score: currentScore,
                      currentPriority: currentPriority,
                      onScoreChanged: (newScore) {
                        ref
                            .read(assessmentControllerProvider.notifier)
                            .updateScore(lifeArea, newScore);
                      },
                      onPriorityChanged: (newPriority) {
                        ref
                            .read(assessmentControllerProvider.notifier)
                            .updatePriority(lifeArea, newPriority);
                      },
                    ),
                  );
                },
              ),
            ),

            // FOOTER NAVIGATION CONTROLS
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                border: Border(
                  top: BorderSide(
                    color: theme.colorScheme.outlineVariant.withOpacity(0.4),
                  ),
                ),
              ),
              child: Row(
                children: [
                  if (currentStep > 0)
                    OutlinedButton.icon(
                      key: const Key('wizard_previous_button'),
                      onPressed: () {
                        final prev = currentStep - 1;
                        _goToStep(prev);
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: Text(l10n?.previousArea ?? 'Previous'),
                    ),
                  if (currentStep > 0) const SizedBox(width: 12),
                  Expanded(
                    child: currentStep < totalSteps - 1
                        ? FilledButton.icon(
                            key: const Key('wizard_next_button'),
                            onPressed: () async {
                              // Save current step immediately to SQLite
                              await ref
                                  .read(assessmentControllerProvider.notifier)
                                  .saveCurrentStep();
                              final next = currentStep + 1;
                              _goToStep(next);
                            },
                            icon: const Icon(Icons.arrow_forward),
                            label: Text(l10n?.nextArea ?? 'Next Area'),
                          )
                        : FilledButton.icon(
                            key: const Key('wizard_complete_button'),
                            onPressed: assessmentState.isSaving
                                ? null
                                : () async {
                                    // Complete and save final evaluations
                                    await ref
                                        .read(assessmentControllerProvider.notifier)
                                        .completeAssessment();
                                  },
                            icon: assessmentState.isSaving
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  )
                                : const Icon(Icons.check_circle_outline),
                            label: Text(l10n?.completeAssessment ?? 'Complete Assessment'),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
