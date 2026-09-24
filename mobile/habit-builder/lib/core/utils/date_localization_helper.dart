/// Utility for formatting dates and months accurately across supported locales:
/// English (en-US), Portuguese (pt-BR), and Esperanto (eo).
class DateLocalizationHelper {
  static const List<String> _monthsEn = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  static const List<String> _monthsPt = [
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    'Maio',
    'Junho',
    'Julho',
    'Agosto',
    'Setembro',
    'Outubro',
    'Novembro',
    'Dezembro',
  ];

  static const List<String> _monthsEo = [
    'Januaro',
    'Februaro',
    'Marto',
    'Aprilo',
    'Majo',
    'Junio',
    'Julio',
    'Aŭgusto',
    'Septembro',
    'Oktobro',
    'Novembro',
    'Decembro',
  ];

  static const List<String> _shortMonthsEn = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  static const List<String> _shortMonthsPt = [
    'jan.',
    'fev.',
    'mar.',
    'abr.',
    'maio',
    'jun.',
    'jul.',
    'ago.',
    'set.',
    'out.',
    'nov.',
    'dez.',
  ];

  static const List<String> _shortMonthsEo = [
    'jan.',
    'feb.',
    'mar.',
    'apr.',
    'maj.',
    'jun.',
    'jul.',
    'aŭg.',
    'sep.',
    'okt.',
    'nov.',
    'dec.',
  ];

  /// Returns the localized full month name for a given month number (1 to 12).
  static String getMonthName(int month, String languageCode) {
    if (month < 1 || month > 12) return '';
    final index = month - 1;
    final lang = languageCode.toLowerCase();
    if (lang.startsWith('pt')) {
      return _monthsPt[index];
    } else if (lang.startsWith('eo')) {
      return _monthsEo[index];
    } else {
      return _monthsEn[index];
    }
  }

  /// Formats month and year with appropriate grammar and prepositions.
  /// Examples:
  /// - Portuguese: "Setembro de 2026"
  /// - Esperanto: "Septembro 2026"
  /// - English: "September 2026"
  static String formatMonthYear(DateTime date, String languageCode) {
    final monthName = getMonthName(date.month, languageCode);
    final lang = languageCode.toLowerCase();
    if (lang.startsWith('pt')) {
      return '$monthName de ${date.year}';
    } else {
      return '$monthName ${date.year}';
    }
  }

  /// Formats day and short month.
  /// Examples:
  /// - Portuguese: "10 de set."
  /// - Esperanto: "10-a de sep."
  /// - English: "Sep 10"
  static String formatShortDate(DateTime date, String languageCode) {
    final index = (date.month - 1).clamp(0, 11);
    final lang = languageCode.toLowerCase();
    if (lang.startsWith('pt')) {
      return '${date.day} de ${_shortMonthsPt[index]}';
    } else if (lang.startsWith('eo')) {
      return '${date.day}-a de ${_shortMonthsEo[index]}';
    } else {
      return '${_shortMonthsEn[index]} ${date.day}';
    }
  }

  /// Formats full date with year.
  /// Examples:
  /// - Portuguese: "10 de set. de 2026"
  /// - Esperanto: "10-a de sep. 2026"
  /// - English: "Sep 10, 2026"
  static String formatFullDate(DateTime date, String languageCode) {
    final index = (date.month - 1).clamp(0, 11);
    final lang = languageCode.toLowerCase();
    if (lang.startsWith('pt')) {
      return '${date.day} de ${_shortMonthsPt[index]} de ${date.year}';
    } else if (lang.startsWith('eo')) {
      return '${date.day}-a de ${_shortMonthsEo[index]} ${date.year}';
    } else {
      return '${_shortMonthsEn[index]} ${date.day}, ${date.year}';
    }
  }
}
