# Feature Specification: 008 - Mobile Financial Management

| Metadata | Details |
| :--- | :--- |
| **Feature ID** | `feat-008` |
| **Status** | `Approved` |
| **Component Path** | `mobile/habit-builder` |
| **Target Release** | Phase 2 (Financial Life Management & Monthly Stewardship) |
| **Related Specs** | [specs/features/006-mobile-daily-tasks-and-dedicated-screens/spec.md](../006-mobile-daily-tasks-and-dedicated-screens/spec.md), [specs/domain/12-life-areas.spec.md](../../domain/12-life-areas.spec.md) |

---

## 1. Problem Statement & Context

### 1.1 The Problem
Cultivating financial clarity and intentional stewardship is a vital dimension of life balance (anchored in the *Finances & Wealth* life area). Without clear, low-friction visibility into monthly cashflow, personal finances often become clouded with avoidance, anxiety, or unexamined spending. Users need an unpretentious, grounding mobile screen to manage their financial life by registering incomes and outcomes/expenses, immediately seeing the total sum of incomes and the total sum of outcomes/expenses for the current month at the top of the screen, and navigating directly to this screen from their daily Home Page.

### 1.2 Invariants & Principles
- **Humility & Clarity**: The financial overview presents numbers honestly and calmly without judgment, guilt-inducing alerts, or vanity metrics.
- **Freedom & Sovereignty**: Users retain complete control over their local financial entries, with all data persisted locally on device via SQLite/Drift.
- **Zero App Comparisons**: The screen and feature descriptions focus entirely on Bona Loko's self-contained principles of intentional stewardship and life balance without contrasting with third-party apps.
- **Tri-Lingual Parity**: All labels, categories, summary badges, and dialogs are fully localized across English (`en-US`), Portuguese (`pt-BR`), and Esperanto (`eo`).
- **Persistence Table Name**:
  - SQLite table for financial entries: `financial_transactions`

---

## 2. Domain & Data Requirements

### 2.1 Table: `financial_transactions`
- `id` (Text / UUID primary key)
- `title` (Text: e.g. "Monthly Salary", "Supermarket Groceries", "Apartment Rent")
- `amount` (Real: positive number representing the monetary transaction value)
- `type` (Text: `'income'` | `'expense'`)
- `date` (DateTime timestamp representing the transaction date)
- `category` (Text, nullable: e.g. `'salary'`, `'freelance'`, `'investments'`, `'housing'`, `'food'`, `'transportation'`, `'health'`, `'education'`, `'leisure'`, `'other'`, or custom category ID/name)
- `currency_code` (Text, default `'USD'`)
- `created_at` (DateTime timestamp when recorded)

### 2.2 Table: `financial_categories`
- `id` (Text / UUID primary key)
- `name` (Text: custom category name, e.g. "Pet Care", "Gym", "Gifts", "Books")
- `is_custom` (Boolean: default `true`)
- `created_at` (DateTime timestamp when created)

### 2.3 Table: `monthly_currencies`
- `year` (Integer)
- `month` (Integer)
- `currency_code` (Text, e.g. `'BRL'`, `'USD'`, `'EUR'`)
- `created_at` (DateTime timestamp when registered)
- Primary Key: `(year, month, currency_code)`

### 2.4 Monthly Summary Aggregation by Currency
For any selected calendar month $(Y, M)$ and selected currency $C$:
$$\text{Total Incomes}(C) = \sum_{\text{type} = \text{'income'}, \text{currency} = C} \text{amount}$$
$$\text{Total Expenses}(C) = \sum_{\text{type} = \text{'expense'}, \text{currency} = C} \text{amount}$$
$$\text{Net Balance}(C) = \text{Total Incomes}(C) - \text{Total Expenses}(C)$$

---

## 3. CQRS API Contracts

### 3.1 Commands (Mutations)
- `AddFinancialTransactionCommand`:
  - Input: `title: String`, `amount: double (> 0)`, `type: FinancialTransactionType`, `date: DateTime`, `category: String?`, `currencyCode: String`
  - Output: `FinancialTransaction`
- `DeleteFinancialTransactionCommand`:
  - Input: `id: String`
  - Output: `void`
- `UpdateFinancialTransactionCommand`:
  - Input: `FinancialTransaction`
  - Output: `void`
- `RegisterMonthlyCurrencyCommand`:
  - Input: `year: int`, `month: int`, `currencyCode: String`
  - Output: `void`
- `DeleteMonthCurrencyTransactionsCommand`:
  - Input: `year: int`, `month: int`, `currencyCode: String`
  - Output: `void` (deletes all transactions for the year, month, and currency, and unregisters the monthly currency)

### 3.2 Queries (Projections)
- `WatchMonthlyCurrenciesQuery`:
  - Input: `year: int`, `month: int`
  - Output: `Stream<List<String>>` (registered currency codes)
- `WatchMonthlySummaryQuery`:
  - Input: `year: int`, `month: int`, `currencyCode: String?`
  - Output: `Stream<MonthlyFinancialSummary>` (`totalIncome`, `totalExpense`, `netBalance`)
- `WatchMonthlyTransactionsQuery`:
  - Input: `year: int`, `month: int`, `currencyCode: String?`
  - Output: `Stream<List<FinancialTransaction>>` ordered by date descending

---

## 4. User Flows & Components

### 4.1 Home Screen Redirection Card
- In `HomeScreen`, under the primary feature actions, a dedicated card is presented:
  - Key: `home_financial_management_button`
  - Icon: `Icons.account_balance_wallet_rounded`
  - Title: Localized "Financial Management" (`financialManagementCardTitle`)
  - Subtitle: Localized "Track monthly incomes, expenses, and cultivate mindful stewardship"
  - Tapping navigates to `FinancialManagementScreen`.

### 4.2 Financial Management Screen
- **Header & Month Selector**:
  - Displays `< Month Year >` with previous/next month navigation buttons and quick return to the current month.
- **Top Summary Cards**:
  - Two prominent cards rendered side-by-side at the top:
    1. **Incomes Card**: Displays upward trend icon, localized "Incomes" label, and formatted sum of incomes for the active month (e.g. `+$3,500.00`).
    2. **Outcomes/Expenses Card**: Displays downward trend icon, localized "Expenses" label, and formatted sum of expenses for the active month (e.g. `-$1,200.00`).
  - Below the two cards, a subtle Net Balance indicator communicates the monthly delta (`Net: +$2,300.00`).
- **Ledger of Transactions**:
  - Chronological list of transactions registered in the active month.
  - Each item displays title, category badge/icon, localized date, and color-coded signed amount.
  - Items support deletion with confirmation dialog.
- **Empty State**:
  - When no records exist in the selected month, a peaceful prompt invites registering the first income or expense.
- **Add Transaction Modal (Bottom Sheet)**:
  - Segmented toggle to choose between **Income** and **Expense**.
  - Currency amount field with positive numeric validation.
  - Description / Title field.
  - Date picker (defaults to today).
  - Category selector with multiline `Wrap` layout adapting to screen width.
  - Option to create custom categories saved in SQLite `financial_categories`.
  - "Save" action button.

---

## 5. Acceptance Criteria (Gherkin Scenarios)

### Scenario 1: Top summary cards display current month sums
```gherkin
Given the user opens the Financial Management screen for the current month
And there are 2 registered incomes totaling $3,500.00 in the current month
And there are 3 registered expenses totaling $1,200.00 in the current month
When the screen finishes rendering
Then the top Incomes card displays "$3,500.00"
And the top Expenses card displays "$1,200.00"
```

### Scenario 2: Registering a new income updates top sum
```gherkin
Given the user is on the Financial Management screen
When the user taps "Add Entry"
And selects "Income" with amount 500.00 and title "Freelance Bonus"
And confirms the entry
Then the transaction is added to the ledger
And the top Incomes card immediately reflects the increased sum
```

### Scenario 3: Registering a new outcome/expense updates top sum
```gherkin
Given the user is on the Financial Management screen
When the user taps "Add Entry"
And selects "Expense" with amount 150.00 and title "Groceries"
And confirms the entry
Then the transaction is added to the ledger
And the top Expenses card immediately reflects the increased sum
```

### Scenario 4: Deleting a transaction updates monthly sums
```gherkin
Given an expense of $100.00 is registered in the current month
When the user deletes this expense entry and confirms
Then the entry is removed from the ledger
And the top Expenses card is decremented by $100.00
```

### Scenario 5: Month navigation recalculates sums for selected month
```gherkin
Given transactions exist in both August 2026 and September 2026
When the user switches the active month to August 2026
Then the top summary cards display the sums strictly corresponding to August 2026
```

### Scenario 6: Home screen redirection
```gherkin
Given the user is on the Home Screen
When the user taps the Financial Management card
Then the application navigates to the Financial Management screen
```

### Scenario 7: Custom category creation and responsive wrap layout
```gherkin
Given the user is in the Add Transaction modal
When the user views the categories section
Then the categories wrap into multiple lines according to screen width
And when the user taps "+ Category" and enters "Pet Care"
Then "Pet Care" is persisted in the custom categories table
And becomes immediately selected for the transaction
```

### Scenario 8: Editing an existing transaction and currency input positioning
```gherkin
Given an existing transaction exists in the financial ledger
When the user taps the edit button or row of the transaction
Then the transaction modal opens pre-filled with the transaction's title, amount, type, date, category, and currency
And the currency selector is positioned on the same line, in front of the amount input
When the user modifies the amount or description and taps "Save Changes"
Then the transaction in the ledger is updated
And the monthly summary cards reflect the updated values immediately
```

### Scenario 9: Managing finances by currency and registering month currency
```gherkin
Given the user is on the Financial Management screen for a given month
When the user taps "+ Currency" and registers a new currency (e.g. "BRL")
Then "BRL" is persisted in the monthly currencies table for that month
And becomes an active selectable currency tab
And when the user registers an income of R$ 5,000.00 while BRL is active
Then the transaction modal inherits BRL without displaying a currency dropdown
And the top Incomes card for BRL displays "R$ 5.000,00"
And switching to another currency tab shows independent sums for that currency
```

### Scenario 10: Localized month display across languages
```gherkin
Given the application locale is set to Portuguese ("pt-BR")
When the user navigates the Financial Management screen
Then the month navigator displays Portuguese month formatting (e.g. "Setembro de 2026")
And when the locale is switched to Esperanto ("eo")
Then the month navigator displays Esperanto month formatting (e.g. "Septembro 2026")
And when the locale is switched to English ("en-US")
Then the month navigator displays English month formatting (e.g. "September 2026")
```

### Scenario 11: Removing a currency month transactions with confirmation
```gherkin
Given registered transactions exist for a specific currency in a calendar month
When the user requests to remove the currency for that month
Then a confirmation dialog appears warning that all transactions in this currency for the month will be deleted
When the user confirms deletion
Then all transactions matching the year, month, and currency code are deleted
And the currency registration is removed from the monthly currencies table
And the active currency automatically falls back to an available registered currency or default
```


