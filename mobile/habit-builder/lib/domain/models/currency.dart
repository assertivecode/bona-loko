/// Top 25 currencies by global FX turnover according to the BIS Triennial Central Bank Survey.
/// Includes canonical ISO 4217 code, symbol, global market share, and translations across
/// English (en), Portuguese (pt), and Esperanto (eo).
enum Currency {
  usd(
    rank: 1,
    code: 'USD',
    symbol: '\$',
    fxSharePercentage: 89.2,
    namePt: 'Dólar americano',
    nameEn: 'US Dollar',
    nameEo: 'Usona dolaro',
  ),
  eur(
    rank: 2,
    code: 'EUR',
    symbol: '€',
    fxSharePercentage: 28.9,
    namePt: 'Euro',
    nameEn: 'Euro',
    nameEo: 'Eŭro',
  ),
  brl(
    rank: 3,
    code: 'BRL',
    symbol: 'R\$',
    fxSharePercentage: 0.9,
    namePt: 'Real brasileiro',
    nameEn: 'Brazilian Real',
    nameEo: 'Brazila realo',
    isApproximate: true,
  ),
  jpy(
    rank: 4,
    code: 'JPY',
    symbol: '¥',
    fxSharePercentage: 16.8,
    namePt: 'Iene japonês',
    nameEn: 'Japanese Yen',
    nameEo: 'Japana eno',
  ),
  gbp(
    rank: 5,
    code: 'GBP',
    symbol: '£',
    fxSharePercentage: 10.2,
    namePt: 'Libra esterlina',
    nameEn: 'British Pound',
    nameEo: 'Brita pundo',
  ),
  cny(
    rank: 6,
    code: 'CNY',
    symbol: '¥',
    fxSharePercentage: 8.5,
    namePt: 'Renminbi chinês (yuan)',
    nameEn: 'Chinese Renminbi (Yuan)',
    nameEo: 'Ĉina renminbi (juano)',
  ),
  chf(
    rank: 7,
    code: 'CHF',
    symbol: 'CHF',
    fxSharePercentage: 6.4,
    namePt: 'Franco suíço',
    nameEn: 'Swiss Franc',
    nameEo: 'Svisa franko',
  ),
  aud(
    rank: 8,
    code: 'AUD',
    symbol: 'A\$',
    fxSharePercentage: 6.1,
    namePt: 'Dólar australiano',
    nameEn: 'Australian Dollar',
    nameEo: 'Aŭstralia dolaro',
  ),
  cad(
    rank: 9,
    code: 'CAD',
    symbol: 'C\$',
    fxSharePercentage: 5.8,
    namePt: 'Dólar canadense',
    nameEn: 'Canadian Dollar',
    nameEo: 'Kanada dolaro',
  ),
  hkd(
    rank: 10,
    code: 'HKD',
    symbol: 'HK\$',
    fxSharePercentage: 3.8,
    namePt: 'Dólar de Hong Kong',
    nameEn: 'Hong Kong Dollar',
    nameEo: 'Honkonga dolaro',
  ),
  sgd(
    rank: 11,
    code: 'SGD',
    symbol: 'S\$',
    fxSharePercentage: 2.4,
    namePt: 'Dólar de Singapura',
    nameEn: 'Singapore Dollar',
    nameEo: 'Singapuro-dolaro',
  ),
  inr(
    rank: 12,
    code: 'INR',
    symbol: '₹',
    fxSharePercentage: 1.9,
    namePt: 'Rúpia indiana',
    nameEn: 'Indian Rupee',
    nameEo: 'Barata rupio',
  ),
  krw(
    rank: 13,
    code: 'KRW',
    symbol: '₩',
    fxSharePercentage: 1.8,
    namePt: 'Won sul-coreano',
    nameEn: 'South Korean Won',
    nameEo: 'Sud-korea vono',
  ),
  sek(
    rank: 14,
    code: 'SEK',
    symbol: 'kr',
    fxSharePercentage: 1.6,
    namePt: 'Coroa sueca',
    nameEn: 'Swedish Krona',
    nameEo: 'Sveda krono',
  ),
  mxn(
    rank: 15,
    code: 'MXN',
    symbol: 'Mex\$',
    fxSharePercentage: 1.6,
    namePt: 'Peso mexicano',
    nameEn: 'Mexican Peso',
    nameEo: 'Meksika peso',
  ),
  nzd(
    rank: 16,
    code: 'NZD',
    symbol: 'NZ\$',
    fxSharePercentage: 1.5,
    namePt: 'Dólar neozelandês',
    nameEn: 'New Zealand Dollar',
    nameEo: 'Novzelanda dolaro',
  ),
  nok(
    rank: 17,
    code: 'NOK',
    symbol: 'kr',
    fxSharePercentage: 1.3,
    namePt: 'Coroa norueguesa',
    nameEn: 'Norwegian Krone',
    nameEo: 'Norvega krono',
  ),
  twd(
    rank: 18,
    code: 'TWD',
    symbol: 'NT\$',
    fxSharePercentage: 1.0,
    namePt: 'Novo dólar taiwanês',
    nameEn: 'New Taiwan Dollar',
    nameEo: 'Nova tajvana dolaro',
    isApproximate: true,
  ),
  zar(
    rank: 19,
    code: 'ZAR',
    symbol: 'R',
    fxSharePercentage: 0.8,
    namePt: 'Rand sul-africano',
    nameEn: 'South African Rand',
    nameEo: 'Sud-afrika rando',
    isApproximate: true,
  ),
  pln(
    rank: 20,
    code: 'PLN',
    symbol: 'zł',
    fxSharePercentage: 0.7,
    namePt: 'Zloty polonês',
    nameEn: 'Polish Zloty',
    nameEo: 'Pola zloto',
    isApproximate: true,
  ),
  dkk(
    rank: 21,
    code: 'DKK',
    symbol: 'kr',
    fxSharePercentage: 0.6,
    namePt: 'Coroa dinamarquesa',
    nameEn: 'Danish Krone',
    nameEo: 'Dana krono',
    isApproximate: true,
  ),
  idr(
    rank: 22,
    code: 'IDR',
    symbol: 'Rp',
    fxSharePercentage: 0.5,
    namePt: 'Rupia indonésia',
    nameEn: 'Indonesian Rupiah',
    nameEo: 'Indonezia rupio',
    isApproximate: true,
  ),
  tryCurrency(
    rank: 23,
    code: 'TRY',
    symbol: '₺',
    fxSharePercentage: 0.5,
    namePt: 'Lira turca',
    nameEn: 'Turkish Lira',
    nameEo: 'Turka liro',
    isApproximate: true,
  ),
  thb(
    rank: 24,
    code: 'THB',
    symbol: '฿',
    fxSharePercentage: 0.4,
    namePt: 'Baht tailandês',
    nameEn: 'Thai Baht',
    nameEo: 'Taja baĥto',
    isApproximate: true,
  ),
  ils(
    rank: 25,
    code: 'ILS',
    symbol: '₪',
    fxSharePercentage: 0.4,
    namePt: 'Novo shekel israelense',
    nameEn: 'Israeli New Shekel',
    nameEo: 'Israela nova siklo',
    isApproximate: true,
  );

  final int rank;
  final String code;
  final String symbol;
  final double fxSharePercentage;
  final String namePt;
  final String nameEn;
  final String nameEo;
  final bool isApproximate;

  const Currency({
    required this.rank,
    required this.code,
    required this.symbol,
    required this.fxSharePercentage,
    required this.namePt,
    required this.nameEn,
    required this.nameEo,
    this.isApproximate = false,
  });

  /// Returns the localized name based on a language code ('en', 'pt', 'eo').
  String nameIn(String languageCode) {
    final lang = languageCode.trim().toLowerCase();
    if (lang.startsWith('pt')) return namePt;
    if (lang.startsWith('eo')) return nameEo;
    return nameEn;
  }

  /// Formatted global FX turnover share (e.g. "89,2%" or "~0,9%").
  String shareDisplay({bool commaDecimal = true}) {
    final valueStr = commaDecimal
        ? fxSharePercentage.toStringAsFixed(1).replaceAll('.', ',')
        : fxSharePercentage.toStringAsFixed(1);
    final prefix = isApproximate ? '~' : '';
    return '$prefix$valueStr%';
  }

  /// Resolves a [Currency] from its ISO 4217 code (case-insensitive).
  static Currency? fromCode(String code) {
    final normalized = code.trim().toUpperCase();
    for (final c in Currency.values) {
      if (c.code == normalized) return c;
    }
    return null;
  }

  /// Resolves a [Currency] from its ranking position (1..25).
  static Currency? fromRank(int rank) {
    for (final c in Currency.values) {
      if (c.rank == rank) return c;
    }
    return null;
  }
}
