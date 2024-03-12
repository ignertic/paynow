enum Currency { usd, zwl }

extension CurrencyExtension on Currency {
  String get name {
    switch (this) {
      case Currency.usd:
        return 'USD';
      case Currency.zwl:
        return 'ZWL';
      default:
        throw ArgumentError('Invalid currency: $this');
    }
  }
}
