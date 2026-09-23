import 'package:flutter/material.dart';

/// Transaction type: income (money received) or expense (money spent/outcome).
enum FinancialTransactionType {
  income,
  expense;

  bool get isIncome => this == FinancialTransactionType.income;
  bool get isExpense => this == FinancialTransactionType.expense;

  static FinancialTransactionType fromString(String value) {
    final normalized = value.trim().toLowerCase();
    if (normalized == 'income') return FinancialTransactionType.income;
    return FinancialTransactionType.expense;
  }
}

/// Standard categories for financial categorization.
class FinancialCategory {
  static const String salary = 'salary';
  static const String investments = 'investments';
  static const String freelance = 'freelance';
  static const String housing = 'housing';
  static const String food = 'food';
  static const String transportation = 'transportation';
  static const String health = 'health';
  static const String education = 'education';
  static const String leisure = 'leisure';
  static const String other = 'other';

  static const List<String> all = [
    salary,
    investments,
    freelance,
    housing,
    food,
    transportation,
    health,
    education,
    leisure,
    other,
  ];

  static IconData getIcon(String? category, FinancialTransactionType type) {
    switch (category?.toLowerCase().trim()) {
      case salary:
        return Icons.work_rounded;
      case investments:
        return Icons.trending_up_rounded;
      case freelance:
        return Icons.laptop_mac_rounded;
      case housing:
        return Icons.home_rounded;
      case food:
        return Icons.restaurant_rounded;
      case transportation:
        return Icons.directions_car_rounded;
      case health:
        return Icons.medical_services_rounded;
      case education:
        return Icons.school_rounded;
      case leisure:
        return Icons.sports_esports_rounded;
      case other:
      default:
        return type.isIncome
            ? Icons.arrow_upward_rounded
            : Icons.arrow_downward_rounded;
    }
  }
}

/// Represents a financial category item (standard or user-created custom category).
@immutable
class FinancialCategoryItem {
  final String id;
  final String name;
  final bool isCustom;
  final IconData icon;

  const FinancialCategoryItem({
    required this.id,
    required this.name,
    this.isCustom = false,
    this.icon = Icons.category_rounded,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FinancialCategoryItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// Immutable domain entity representing an individual financial transaction (income or expense).
@immutable
class FinancialTransaction {
  final String id;
  final String title;
  final double amount;
  final FinancialTransactionType type;
  final DateTime date;
  final String? category;
  final String currencyCode;
  final DateTime createdAt;

  const FinancialTransaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.date,
    this.category,
    this.currencyCode = 'USD',
    required this.createdAt,
  }) : assert(amount >= 0, 'Amount must be non-negative');

  FinancialTransaction copyWith({
    String? id,
    String? title,
    double? amount,
    FinancialTransactionType? type,
    DateTime? date,
    String? category,
    String? currencyCode,
    DateTime? createdAt,
  }) {
    return FinancialTransaction(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      date: date ?? this.date,
      category: category ?? this.category,
      currencyCode: currencyCode ?? this.currencyCode,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FinancialTransaction &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          amount == other.amount &&
          type == other.type &&
          date == other.date &&
          category == other.category &&
          currencyCode == other.currencyCode &&
          createdAt == other.createdAt;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      amount.hashCode ^
      type.hashCode ^
      date.hashCode ^
      category.hashCode ^
      currencyCode.hashCode ^
      createdAt.hashCode;
}

/// Aggregated monthly financial summary.
@immutable
class MonthlyFinancialSummary {
  final int year;
  final int month;
  final double totalIncome;
  final double totalExpense;
  final double netBalance;

  const MonthlyFinancialSummary({
    required this.year,
    required this.month,
    required this.totalIncome,
    required this.totalExpense,
    required this.netBalance,
  });

  factory MonthlyFinancialSummary.fromTransactions({
    required int year,
    required int month,
    required List<FinancialTransaction> transactions,
  }) {
    double incomes = 0.0;
    double expenses = 0.0;

    for (final tx in transactions) {
      if (tx.date.year == year && tx.date.month == month) {
        if (tx.type.isIncome) {
          incomes += tx.amount;
        } else {
          expenses += tx.amount;
        }
      }
    }

    return MonthlyFinancialSummary(
      year: year,
      month: month,
      totalIncome: incomes,
      totalExpense: expenses,
      netBalance: incomes - expenses,
    );
  }

  static const MonthlyFinancialSummary empty = MonthlyFinancialSummary(
    year: 0,
    month: 0,
    totalIncome: 0.0,
    totalExpense: 0.0,
    netBalance: 0.0,
  );
}
