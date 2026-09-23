import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/date_localization_helper.dart';
import '../../data/repositories/financial_repository.dart';
import '../../domain/models/currency.dart';
import '../../domain/models/financial_transaction.dart';
import 'financial_controller.dart';

/// Modal bottom sheet for registering or editing an income or outcome/expense.
class AddTransactionModal extends ConsumerStatefulWidget {
  final DateTime? initialDate;
  final FinancialTransaction? transactionToEdit;
  final String? currencyCode;

  const AddTransactionModal({
    super.key,
    this.initialDate,
    this.transactionToEdit,
    this.currencyCode,
  });

  static Future<void> show(
    BuildContext context, {
    DateTime? initialDate,
    FinancialTransaction? transactionToEdit,
    String? currencyCode,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddTransactionModal(
        initialDate: initialDate,
        transactionToEdit: transactionToEdit,
        currencyCode: currencyCode,
      ),
    );
  }

  @override
  ConsumerState<AddTransactionModal> createState() => _AddTransactionModalState();
}

class _AddTransactionModalState extends ConsumerState<AddTransactionModal> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  FinancialTransactionType _selectedType = FinancialTransactionType.expense;
  late DateTime _selectedDate;
  String _selectedCategory = FinancialCategory.food;
  late Currency _currency;

  bool get isEditing => widget.transactionToEdit != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      final tx = widget.transactionToEdit!;
      _titleController.text = tx.title;
      _amountController.text = tx.amount % 1 == 0
          ? tx.amount.toInt().toString()
          : tx.amount.toString();
      _selectedType = tx.type;
      _selectedDate = tx.date;
      _selectedCategory = tx.category ??
          (_selectedType.isIncome ? FinancialCategory.salary : FinancialCategory.food);
      _currency = Currency.fromCode(tx.currencyCode) ?? Currency.usd;
    } else {
      _selectedDate = widget.initialDate ?? DateTime.now();
      _currency = Currency.fromCode(widget.currencyCode ?? 'USD') ?? Currency.usd;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isEditing && widget.currencyCode == null) {
      final locale = Localizations.localeOf(context).languageCode;
      if (locale.startsWith('pt')) {
        _currency = Currency.brl;
      } else if (locale.startsWith('eo')) {
        _currency = Currency.eur;
      } else {
        _currency = Currency.usd;
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  String _localizeCategory(String categoryKey, AppLocalizations? l10n) {
    if (l10n == null) return categoryKey;
    switch (categoryKey) {
      case FinancialCategory.salary:
        return l10n.categorySalary;
      case FinancialCategory.investments:
        return l10n.categoryInvestments;
      case FinancialCategory.freelance:
        return l10n.categoryFreelance;
      case FinancialCategory.housing:
        return l10n.categoryHousing;
      case FinancialCategory.food:
        return l10n.categoryFood;
      case FinancialCategory.transportation:
        return l10n.categoryTransportation;
      case FinancialCategory.health:
        return l10n.categoryHealth;
      case FinancialCategory.education:
        return l10n.categoryEducation;
      case FinancialCategory.leisure:
        return l10n.categoryLeisure;
      case FinancialCategory.other:
        return l10n.categoryOther;
      default:
        return categoryKey;
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _showAddCategoryDialog() async {
    final l10n = AppLocalizations.of(context);
    final nameController = TextEditingController();

    final createdName = await showDialog<String>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: Text(l10n?.newCategoryDialogTitle ?? 'New Category'),
        content: TextField(
          key: const Key('custom_category_name_input'),
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            labelText: l10n?.categoryNameFieldLabel ?? 'Category Name',
            hintText: l10n?.categoryNamePlaceholder ?? 'e.g., Pet Care, Gym, Books',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(),
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          ),
          FilledButton(
            key: const Key('confirm_add_category_button'),
            onPressed: () {
              final text = nameController.text.trim();
              if (text.isNotEmpty) {
                Navigator.of(dialogCtx).pop(text);
              }
            },
            child: Text(l10n?.addCategoryConfirm ?? 'Add'),
          ),
        ],
      ),
    );

    if (createdName != null && createdName.isNotEmpty) {
      await ref.read(financialControllerProvider).addCustomCategory(createdName);
      if (mounted) {
        setState(() {
          _selectedCategory = createdName;
        });
      }
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final amountText = _amountController.text.trim().replaceAll(',', '.');
    final amount = double.tryParse(amountText);
    if (amount == null || amount <= 0) return;

    final title = _titleController.text.trim();

    if (isEditing) {
      final updated = widget.transactionToEdit!.copyWith(
        title: title,
        amount: amount,
        type: _selectedType,
        date: _selectedDate,
        category: _selectedCategory,
        currencyCode: _currency.code,
      );
      await ref.read(financialControllerProvider).updateTransaction(updated);
    } else {
      await ref.read(financialControllerProvider).addTransaction(
            title: title,
            amount: amount,
            type: _selectedType,
            date: _selectedDate,
            category: _selectedCategory,
            currencyCode: _currency.code,
          );
    }

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final isIncome = _selectedType.isIncome;
    final accentColor = isIncome ? Colors.teal : Colors.deepOrange;

    final customCategoriesAsync = ref.watch(customCategoriesStreamProvider);
    final customCategories = customCategoriesAsync.valueOrNull ?? const [];

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 16.0,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.0,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Drag Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isEditing
                        ? (l10n?.editTransactionTitle ?? 'Edit Transaction')
                        : (l10n?.addTransactionTitle ?? 'Register Transaction'),
                    key: const Key('add_transaction_modal_title'),
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Transaction Type Selector (Income vs Expense)
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      key: const Key('select_type_income'),
                      borderRadius: BorderRadius.circular(14),
                      onTap: () {
                        setState(() {
                          _selectedType = FinancialTransactionType.income;
                          if (_selectedCategory == FinancialCategory.food ||
                              _selectedCategory == FinancialCategory.housing) {
                            _selectedCategory = FinancialCategory.salary;
                          }
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: isIncome
                              ? Colors.teal.withOpacity(0.15)
                              : theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isIncome ? Colors.teal : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_upward_rounded,
                              size: 20,
                              color: isIncome ? Colors.teal : theme.colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              l10n?.transactionTypeIncome ?? 'Income',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isIncome ? Colors.teal : theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: InkWell(
                      key: const Key('select_type_expense'),
                      borderRadius: BorderRadius.circular(14),
                      onTap: () {
                        setState(() {
                          _selectedType = FinancialTransactionType.expense;
                          if (_selectedCategory == FinancialCategory.salary ||
                              _selectedCategory == FinancialCategory.investments) {
                            _selectedCategory = FinancialCategory.food;
                          }
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: !isIncome
                              ? Colors.deepOrange.withOpacity(0.15)
                              : theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: !isIncome ? Colors.deepOrange : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_downward_rounded,
                              size: 20,
                              color: !isIncome ? Colors.deepOrange : theme.colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              l10n?.transactionTypeExpense ?? 'Expense',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: !isIncome ? Colors.deepOrange : theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Amount Input Field (inherited from active month currency)
              TextFormField(
                key: const Key('transaction_amount_field'),
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                ),
                decoration: InputDecoration(
                  labelText: l10n?.amountFieldLabel ?? 'Amount',
                  hintText: l10n?.amountFieldPlaceholder ?? '0.00',
                  prefixText: '${_currency.symbol} ',
                  prefixStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: accentColor,
                  ),
                  filled: true,
                  fillColor: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter a valid amount';
                  }
                  final parsed = double.tryParse(val.replaceAll(',', '.'));
                  if (parsed == null || parsed <= 0) {
                    return 'Amount must be greater than zero';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Description / Title Field
              TextFormField(
                key: const Key('transaction_title_field'),
                controller: _titleController,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  labelText: l10n?.descriptionFieldLabel ?? 'Description',
                  hintText: l10n?.descriptionFieldPlaceholder ?? 'e.g., Monthly Salary, Groceries, Rent',
                  prefixIcon: const Icon(Icons.edit_note_rounded),
                  filled: true,
                  fillColor: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Date Picker (Localized)
              InkWell(
                key: const Key('transaction_date_picker_button'),
                borderRadius: BorderRadius.circular(14),
                onTap: _pickDate,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today_rounded, size: 20, color: theme.colorScheme.primary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          DateLocalizationHelper.formatShortDate(
                            _selectedDate,
                            Localizations.localeOf(context).languageCode,
                          ),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Category Selector (Responsive Wrap layout)
              Text(
                l10n?.categoryFieldLabel ?? 'Category',
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  // Standard categories
                  ...FinancialCategory.all.map((cat) {
                    final isSelected = _selectedCategory == cat;
                    return ChoiceChip(
                      key: Key('category_chip_$cat'),
                      avatar: Icon(
                        FinancialCategory.getIcon(cat, _selectedType),
                        size: 16,
                        color: isSelected ? Colors.white : theme.colorScheme.onSurfaceVariant,
                      ),
                      label: Text(_localizeCategory(cat, l10n)),
                      selected: isSelected,
                      selectedColor: accentColor,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : theme.colorScheme.onSurface,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _selectedCategory = cat;
                          });
                        }
                      },
                    );
                  }),
                  // Custom categories
                  ...customCategories.map((customCat) {
                    final isSelected = _selectedCategory == customCat.name;
                    return ChoiceChip(
                      key: Key('custom_category_chip_${customCat.id}'),
                      avatar: Icon(
                        Icons.label_outline_rounded,
                        size: 16,
                        color: isSelected ? Colors.white : theme.colorScheme.onSurfaceVariant,
                      ),
                      label: Text(customCat.name),
                      selected: isSelected,
                      selectedColor: accentColor,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : theme.colorScheme.onSurface,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _selectedCategory = customCat.name;
                          });
                        }
                      },
                    );
                  }),
                  // Add custom category button chip
                  ActionChip(
                    key: const Key('add_custom_category_chip'),
                    avatar: Icon(
                      Icons.add_rounded,
                      size: 16,
                      color: theme.colorScheme.primary,
                    ),
                    label: Text(
                      l10n?.addCategoryButton ?? '+ Category',
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _showAddCategoryDialog,
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // Submit Button
              ElevatedButton.icon(
                key: const Key('save_transaction_button'),
                icon: const Icon(Icons.check_rounded),
                label: Text(
                  isEditing
                      ? (l10n?.updateTransactionButton ?? 'Save Changes')
                      : (l10n?.saveTransactionButton ?? 'Save Transaction'),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 2,
                ),
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
