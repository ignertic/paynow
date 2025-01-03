enum Currency { usd, zig }

extension CurrencyExtension on Currency {
  String get name {
    switch (this) {
      case Currency.usd:
        return 'USD';
      case Currency.zig:
        return 'ZIG';
      default:
        throw ArgumentError('Invalid currency: $this');
    }
  }
}
