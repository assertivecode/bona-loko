import 'package:flutter_test/flutter_test.dart';
import 'package:habit_builder/domain/models/currency.dart';

void main() {
  group('Currency Enum & Translations', () {
    test('contains all 25 top FX currencies ordered by rank', () {
      expect(Currency.values.length, 25);
      for (var i = 0; i < Currency.values.length; i++) {
        expect(Currency.values[i].rank, i + 1);
      }
    });

    test('validates USD attributes and translations', () {
      const usd = Currency.usd;
      expect(usd.rank, 1);
      expect(usd.code, 'USD');
      expect(usd.symbol, '\$');
      expect(usd.fxSharePercentage, 89.2);
      expect(usd.namePt, 'Dólar americano');
      expect(usd.nameEn, 'US Dollar');
      expect(usd.nameEo, 'Usona dolaro');
      expect(usd.nameIn('pt'), 'Dólar americano');
      expect(usd.nameIn('en'), 'US Dollar');
      expect(usd.nameIn('eo'), 'Usona dolaro');
      expect(usd.shareDisplay(), '89,2%');
    });

    test('validates BRL (Real brasileiro) attributes and translations', () {
      const brl = Currency.brl;
      expect(brl.rank, 3);
      expect(brl.code, 'BRL');
      expect(brl.symbol, 'R\$');
      expect(brl.fxSharePercentage, 0.9);
      expect(brl.isApproximate, isTrue);
      expect(brl.namePt, 'Real brasileiro');
      expect(brl.nameEn, 'Brazilian Real');
      expect(brl.nameEo, 'Brazila realo');
      expect(brl.shareDisplay(), '~0,9%');
    });

    test('verifies priority order: USD, EUR, BRL, then other currencies', () {
      expect(Currency.values[0], Currency.usd);
      expect(Currency.values[1], Currency.eur);
      expect(Currency.values[2], Currency.brl);
    });

    test('resolves currencies by ISO code (case-insensitive)', () {
      expect(Currency.fromCode('USD'), Currency.usd);
      expect(Currency.fromCode('usd'), Currency.usd);
      expect(Currency.fromCode('EUR'), Currency.eur);
      expect(Currency.fromCode('brl'), Currency.brl);
      expect(Currency.fromCode('TRY'), Currency.tryCurrency);
      expect(Currency.fromCode('INVALID'), isNull);
    });

    test('resolves currencies by rank (1..25)', () {
      expect(Currency.fromRank(1), Currency.usd);
      expect(Currency.fromRank(2), Currency.eur);
      expect(Currency.fromRank(3), Currency.brl);
      expect(Currency.fromRank(25), Currency.ils);
      expect(Currency.fromRank(0), isNull);
      expect(Currency.fromRank(26), isNull);
    });

    test('verifies each currency has non-empty translations in all 3 languages', () {
      for (final currency in Currency.values) {
        expect(currency.namePt, isNotEmpty);
        expect(currency.nameEn, isNotEmpty);
        expect(currency.nameEo, isNotEmpty);
        expect(currency.code.length, 3);
        expect(currency.symbol, isNotEmpty);
      }
    });
  });
}
