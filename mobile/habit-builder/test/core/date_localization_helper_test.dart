import 'package:flutter_test/flutter_test.dart';
import 'package:habit_builder/core/utils/date_localization_helper.dart';

void main() {
  group('DateLocalizationHelper Tests', () {
    test('formats month and year across English, Portuguese, and Esperanto', () {
      final sept2026 = DateTime(2026, 9, 23);

      expect(DateLocalizationHelper.formatMonthYear(sept2026, 'en'), 'September 2026');
      expect(DateLocalizationHelper.formatMonthYear(sept2026, 'en_US'), 'September 2026');

      expect(DateLocalizationHelper.formatMonthYear(sept2026, 'pt'), 'Setembro de 2026');
      expect(DateLocalizationHelper.formatMonthYear(sept2026, 'pt_BR'), 'Setembro de 2026');

      expect(DateLocalizationHelper.formatMonthYear(sept2026, 'eo'), 'Septembro 2026');
    });

    test('retrieves all 12 month names accurately in Portuguese and Esperanto', () {
      final ptMonths = [
        'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
        'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'
      ];
      final eoMonths = [
        'Januaro', 'Februaro', 'Marto', 'Aprilo', 'Majo', 'Junio',
        'Julio', 'Aŭgusto', 'Septembro', 'Oktobro', 'Novembro', 'Decembro'
      ];

      for (var i = 1; i <= 12; i++) {
        expect(DateLocalizationHelper.getMonthName(i, 'pt'), ptMonths[i - 1]);
        expect(DateLocalizationHelper.getMonthName(i, 'eo'), eoMonths[i - 1]);
      }
    });

    test('formats short dates correctly per locale grammar', () {
      final date = DateTime(2026, 9, 10);

      expect(DateLocalizationHelper.formatShortDate(date, 'en'), 'Sep 10');
      expect(DateLocalizationHelper.formatShortDate(date, 'pt'), '10 de set.');
      expect(DateLocalizationHelper.formatShortDate(date, 'eo'), '10-a de sep.');
    });

    test('formats full dates with year correctly per locale grammar', () {
      final date = DateTime(2026, 9, 10);

      expect(DateLocalizationHelper.formatFullDate(date, 'en'), 'Sep 10, 2026');
      expect(DateLocalizationHelper.formatFullDate(date, 'pt'), '10 de set. de 2026');
      expect(DateLocalizationHelper.formatFullDate(date, 'eo'), '10-a de sep. 2026');
    });
  });
}
