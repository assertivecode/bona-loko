import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/utils/date_localization_helper.dart';
import '../../data/repositories/financial_repository.dart';
import '../../domain/models/currency.dart';
import '../../domain/models/financial_transaction.dart';
import 'add_transaction_modal.dart';
import 'financial_controller.dart';

/// Screen for managing personal financial life:
/// - Displays two summary cards at the top representing the sum of current month incomes and sum of outcomes/expenses.
/// - Month navigation.
/// - Chronological ledger of financial transactions.
/// - Ability to register and delete incomes and expenses.
class FinancialManagementScreen extends ConsumerWidget {
  const FinancialManagementScreen({super.key});

  String _formatCurrency(double amount, String currencyCode) {
    final currency = Currency.fromCode(currencyCode) ?? Currency.usd;
    final formatter = NumberFormat.currency(
      symbol: currency.symbol,
      decimalDigits: 2,
    );
    return formatter.format(amount);
  }

  String _localizeCategory(String? categoryKey, AppLocalizations? l10n) {
    if (categoryKey == null) return l10n?.categoryOther ?? 'Other';
    switch (categoryKey) {
      case FinancialCategory.salary:
        return l10n?.categorySalary ?? 'Salary';
      case FinancialCategory.investments:
        return l10n?.categoryInvestments ?? 'Investments';
      case FinancialCategory.freelance:
        return l10n?.categoryFreelance ?? 'Freelance';
      case FinancialCategory.housing:
        return l10n?.categoryHousing ?? 'Housing';
      case FinancialCategory.food:
        return l10n?.categoryFood ?? 'Food & Groceries';
      case FinancialCategory.transportation:
        return l10n?.categoryTransportation ?? 'Transportation';
      case FinancialCategory.health:
        return l10n?.categoryHealth ?? 'Health';
      case FinancialCategory.education:
        return l10n?.categoryEducation ?? 'Education';
      case FinancialCategory.leisure:
        return l10n?.categoryLeisure ?? 'Leisure';
      case FinancialCategory.other:
      default:
        return l10n?.categoryOther ?? 'Other';
    }
  }

  Future<void> _showRegisterCurrencyDialog(
    BuildContext context,
    WidgetRef ref,
    DateTime selectedMonth,
    List<String> alreadyRegistered,
    AppLocalizations? l10n,
  ) async {
    final locale = Localizations.localeOf(context).languageCode;
    final available = Currency.values
        .where((c) => !alreadyRegistered.contains(c.code))
        .toList();

    if (available.isEmpty) return;

    final selected = await showDialog<Currency>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: Text(l10n?.registerCurrencyDialogTitle ?? 'Register Currency for Month'),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n?.selectCurrencyPrompt ??
                    'Select a currency to manage in this month:',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 12),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 320),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: available.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (ctx, idx) {
                    final c = available[idx];
                    return ListTile(
                      key: Key('select_currency_${c.code}'),
                      leading: CircleAvatar(
                        radius: 18,
                        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                        child: Text(
                          c.symbol,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                      title: Text('${c.code} (${c.symbol})'),
                      subtitle: Text(c.nameIn(locale)),
                      onTap: () => Navigator.of(dialogCtx).pop(c),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(),
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          ),
        ],
      ),
    );

    if (selected != null) {
      await ref.read(financialControllerProvider).registerMonthCurrency(
            selectedMonth.year,
            selectedMonth.month,
            selected.code,
          );
    }
  }

  Future<void> _confirmDeleteCurrency(
    BuildContext context,
    WidgetRef ref,
    DateTime selectedMonth,
    String currencyCode,
    AppLocalizations? l10n,
    String localeCode,
  ) async {
    final currency = Currency.fromCode(currencyCode);
    final currencyName = currency != null ? '${currency.code} (${currency.symbol})' : currencyCode;
    final formattedMonthYear = DateLocalizationHelper.formatMonthYear(selectedMonth, localeCode);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: Text(l10n?.deleteCurrencyMonthTransactionsTitle ?? 'Remove Month Currency'),
        content: Text(
          l10n?.deleteCurrencyMonthTransactionsConfirmation(currencyName, formattedMonthYear) ??
              'Are you sure you want to remove $currencyName and delete all its registered transactions for $formattedMonthYear? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(false),
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          ),
          FilledButton(
            key: const Key('confirm_delete_currency_button'),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.of(dialogCtx).pop(true),
            child: Text(l10n?.deleteCurrencyMonthTransactionsButton ?? 'Remove Currency'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(financialControllerProvider).deleteMonthCurrencyTransactions(
            selectedMonth.year,
            selectedMonth.month,
            currencyCode,
          );
    }
  }

  void _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    FinancialTransaction tx,
    AppLocalizations? l10n,
  ) {
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: Text(l10n?.deleteTransactionDialogTitle ?? 'Delete Transaction'),
        content: Text(
          l10n?.deleteTransactionConfirmation ??
              'Are you sure you want to delete this transaction?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(),
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              Navigator.of(dialogCtx).pop();
              await ref.read(financialControllerProvider).deleteTransaction(tx.id);
            },
            child: Text(l10n?.deleteButton ?? 'Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final selectedMonth = ref.watch(selectedFinancialMonthProvider);
    final controller = ref.read(financialControllerProvider);
    final localeCode = Localizations.localeOf(context).languageCode;

    final defaultCurrency = localeCode.startsWith('pt')
        ? 'BRL'
        : (localeCode.startsWith('eo') ? 'EUR' : 'USD');

    // Watch registered currencies for this month
    final currenciesAsync = ref.watch(monthlyCurrenciesStreamProvider(selectedMonth));
    final rawRegistered = currenciesAsync.valueOrNull ?? [defaultCurrency];
    final registeredCurrencies = List<String>.from(rawRegistered)
      ..sort((a, b) {
        final rankA = Currency.fromCode(a)?.rank ?? 999;
        final rankB = Currency.fromCode(b)?.rank ?? 999;
        return rankA.compareTo(rankB);
      });

    final userSelectedCurrency = ref.watch(selectedFinancialCurrencyProvider);
    final activeCurrency = (userSelectedCurrency != null && registeredCurrencies.contains(userSelectedCurrency))
        ? userSelectedCurrency
        : registeredCurrencies.first;

    final filter = MonthlyQueryFilter(selectedMonth, activeCurrency);
    final summaryAsync = ref.watch(monthlyFilteredSummaryStreamProvider(filter));
    final transactionsAsync = ref.watch(monthlyFilteredTransactionsStreamProvider(filter));

    final summary = summaryAsync.valueOrNull ??
        MonthlyFinancialSummary(
          year: selectedMonth.year,
          month: selectedMonth.month,
          totalIncome: 0.0,
          totalExpense: 0.0,
          netBalance: 0.0,
        );

    final transactions = transactionsAsync.valueOrNull ?? const [];

    final now = DateTime.now();
    final isCurrentMonth =
        selectedMonth.year == now.year && selectedMonth.month == now.month;

    final monthLabel = DateLocalizationHelper.formatMonthYear(selectedMonth, localeCode);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n?.financialManagementTitle ?? 'Financial Management',
          key: const Key('financial_screen_title'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          if (!isCurrentMonth)
            IconButton(
              icon: const Icon(Icons.today_rounded),
              tooltip: l10n?.currentMonthTooltip ?? 'Current Month',
              onPressed: () => controller.jumpToCurrentMonth(),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        key: const Key('add_transaction_fab'),
        icon: const Icon(Icons.add_rounded),
        label: Text(l10n?.addTransactionButton ?? 'Add Transaction'),
        onPressed: () {
          AddTransactionModal.show(
            context,
            initialDate: selectedMonth,
            currencyCode: activeCurrency,
          );
        },
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          children: [
            // MONTH NAVIGATION BAR
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.35),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    key: const Key('prev_month_button'),
                    icon: const Icon(Icons.chevron_left_rounded),
                    tooltip: l10n?.previousMonthTooltip ?? 'Previous Month',
                    onPressed: () => controller.previousMonth(),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_rounded,
                        size: 20,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        monthLabel,
                        key: const Key('selected_month_label'),
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    key: const Key('next_month_button'),
                    icon: const Icon(Icons.chevron_right_rounded),
                    tooltip: l10n?.nextMonthTooltip ?? 'Next Month',
                    onPressed: () => controller.nextMonth(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // CURRENCY SELECTOR BAR
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.25),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.payments_outlined,
                            size: 18,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            l10n?.monthCurrenciesLabel ?? 'Currencies',
                            style: theme.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      TextButton.icon(
                        key: const Key('delete_active_currency_button'),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red.shade700,
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                          visualDensity: VisualDensity.compact,
                        ),
                        icon: const Icon(Icons.delete_outline_rounded, size: 16),
                        label: Text(
                          l10n?.deleteCurrencyMonthTransactionsButton ?? 'Remove Currency',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                        onPressed: () => _confirmDeleteCurrency(
                          context,
                          ref,
                          selectedMonth,
                          activeCurrency,
                          l10n,
                          localeCode,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...registeredCurrencies.map((cCode) {
                          final isSelected = cCode == activeCurrency;
                          final curr = Currency.fromCode(cCode) ?? Currency.usd;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ChoiceChip(
                              key: Key('currency_chip_$cCode'),
                              avatar: isSelected
                                  ? const Icon(Icons.check_rounded, size: 16, color: Colors.white)
                                  : null,
                              label: Text('${curr.code} (${curr.symbol})'),
                              selected: isSelected,
                              selectedColor: theme.colorScheme.primary,
                              labelStyle: TextStyle(
                                color: isSelected ? Colors.white : theme.colorScheme.onSurface,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                              ),
                              onSelected: (selected) {
                                if (selected) {
                                  controller.setCurrency(cCode);
                                }
                              },
                            ),
                          );
                        }),
                        ActionChip(
                          key: const Key('register_currency_button'),
                          avatar: Icon(
                            Icons.add_rounded,
                            size: 16,
                            color: theme.colorScheme.primary,
                          ),
                          label: Text(
                            l10n?.registerCurrencyButton ?? '+ Currency',
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () => _showRegisterCurrencyDialog(
                            context,
                            ref,
                            selectedMonth,
                            registeredCurrencies,
                            l10n,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 1. HERO NET BALANCE CARD (ABOVE INCOMES & EXPENSES)
            Container(
              key: const Key('monthly_net_balance_card'),
              padding: const EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                gradient: LinearGradient(
                  colors: [
                    (summary.netBalance >= 0 ? Colors.teal : Colors.deepOrange).withOpacity(0.12),
                    theme.colorScheme.surface,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: (summary.netBalance >= 0 ? Colors.teal : Colors.deepOrange).withOpacity(0.35),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.shadow.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: (summary.netBalance >= 0 ? Colors.teal : Colors.deepOrange).withOpacity(0.18),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Icon(
                              summary.netBalance >= 0
                                  ? Icons.account_balance_wallet_rounded
                                  : Icons.warning_amber_rounded,
                              size: 20,
                              color: summary.netBalance >= 0
                                  ? (theme.brightness == Brightness.dark ? Colors.tealAccent : Colors.teal.shade800)
                                  : (theme.brightness == Brightness.dark ? Colors.deepOrangeAccent : Colors.deepOrange.shade800),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            l10n?.monthlyBalanceLabel ?? 'Net Balance',
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          color: (summary.netBalance >= 0 ? Colors.teal : Colors.deepOrange).withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          summary.netBalance >= 0
                              ? Icons.trending_up_rounded
                              : Icons.trending_down_rounded,
                          size: 18,
                          color: summary.netBalance >= 0
                              ? (theme.brightness == Brightness.dark ? Colors.tealAccent : Colors.teal.shade800)
                              : (theme.brightness == Brightness.dark ? Colors.deepOrangeAccent : Colors.deepOrange.shade800),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${summary.netBalance >= 0 ? '+' : ''}${_formatCurrency(summary.netBalance, activeCurrency)}',
                    key: const Key('monthly_net_balance_text'),
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                      color: summary.netBalance >= 0
                          ? (theme.brightness == Brightness.dark ? Colors.tealAccent.shade200 : Colors.teal.shade900)
                          : (theme.brightness == Brightness.dark ? Colors.deepOrangeAccent.shade100 : Colors.deepOrange.shade900),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // 2. COMPACT INCOMES & EXPENSES SUMMARY ROW (BELOW NET BALANCE)
            Row(
              children: [
                // Incomes Card
                Expanded(
                  child: Container(
                    key: const Key('monthly_incomes_summary_card'),
                    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
                    decoration: BoxDecoration(
                      color: Colors.teal.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: Colors.teal.withOpacity(0.25),
                        width: 1.0,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                color: Colors.teal.withOpacity(0.18),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: const Icon(
                                Icons.trending_up_rounded,
                                color: Colors.teal,
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                l10n?.monthlyIncomesLabel ?? 'Incomes',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.brightness == Brightness.dark
                                      ? Colors.tealAccent.shade100
                                      : Colors.teal.shade800,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _formatCurrency(summary.totalIncome, activeCurrency),
                          key: const Key('monthly_incomes_sum_text'),
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.brightness == Brightness.dark
                                ? Colors.tealAccent.shade200
                                : Colors.teal.shade900,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // Expenses Card
                Expanded(
                  child: Container(
                    key: const Key('monthly_expenses_summary_card'),
                    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
                    decoration: BoxDecoration(
                      color: Colors.deepOrange.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: Colors.deepOrange.withOpacity(0.25),
                        width: 1.0,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                color: Colors.deepOrange.withOpacity(0.18),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: const Icon(
                                Icons.trending_down_rounded,
                                color: Colors.deepOrange,
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                l10n?.monthlyExpensesLabel ?? 'Expenses',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.brightness == Brightness.dark
                                      ? Colors.deepOrangeAccent.shade100
                                      : Colors.deepOrange.shade800,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _formatCurrency(summary.totalExpense, activeCurrency),
                          key: const Key('monthly_expenses_sum_text'),
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.brightness == Brightness.dark
                                ? Colors.deepOrangeAccent.shade100
                                : Colors.deepOrange.shade900,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // SECTION HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  monthLabel,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  '${transactions.length} ${transactions.length == 1 ? 'entry' : 'entries'}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // TRANSACTIONS LIST / EMPTY STATE
            if (transactions.isEmpty)
              Container(
                key: const Key('empty_transactions_card'),
                margin: const EdgeInsets.only(top: 24.0),
                padding: const EdgeInsets.all(28.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: theme.colorScheme.outlineVariant.withOpacity(0.3),
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.account_balance_wallet_outlined,
                      size: 48,
                      color: theme.colorScheme.outline,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n?.emptyCurrencyTransactionsMessage ??
                          l10n?.emptyFinancialMonthMessage ??
                          'No transactions registered in this currency for this month. Tap the button below to register an income or expense.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...transactions.map((tx) {
                final isIncome = tx.type.isIncome;
                final sign = isIncome ? '+' : '-';
                final amountColor = isIncome ? Colors.teal.shade800 : Colors.deepOrange.shade800;
                final formatted = _formatCurrency(tx.amount, tx.currencyCode);
                final formattedDate = DateLocalizationHelper.formatShortDate(tx.date, localeCode);

                return Container(
                  key: Key('transaction_item_${tx.id}'),
                  margin: const EdgeInsets.only(bottom: 10.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: theme.colorScheme.outlineVariant.withOpacity(0.4),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.shadow.withOpacity(0.02),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
                    onTap: () => AddTransactionModal.show(
                      context,
                      transactionToEdit: tx,
                      currencyCode: tx.currencyCode,
                    ),
                    leading: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: isIncome
                            ? Colors.teal.withOpacity(0.12)
                            : Colors.deepOrange.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Icon(
                        FinancialCategory.getIcon(tx.category, tx.type),
                        size: 22,
                        color: isIncome ? Colors.teal : Colors.deepOrange,
                      ),
                    ),
                    title: Text(
                      tx.title,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${_localizeCategory(tx.category, l10n)} • $formattedDate',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$sign$formatted',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: amountColor,
                          ),
                        ),
                        const SizedBox(width: 2),
                        IconButton(
                          key: Key('edit_transaction_${tx.id}'),
                          icon: Icon(
                            Icons.edit_outlined,
                            size: 20,
                            color: theme.colorScheme.onSurfaceVariant.withOpacity(0.7),
                          ),
                          tooltip: l10n?.editTransactionTooltip ?? 'Edit',
                          onPressed: () => AddTransactionModal.show(
                            context,
                            transactionToEdit: tx,
                            currencyCode: tx.currencyCode,
                          ),
                        ),
                        IconButton(
                          key: Key('delete_transaction_${tx.id}'),
                          icon: Icon(
                            Icons.delete_outline_rounded,
                            size: 20,
                            color: theme.colorScheme.onSurfaceVariant.withOpacity(0.6),
                          ),
                          tooltip: l10n?.deleteButton ?? 'Delete',
                          onPressed: () => _confirmDelete(context, ref, tx, l10n),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            const SizedBox(height: 80), // Padding for FAB
          ],
        ),
      ),
    );
  }
}
