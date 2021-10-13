part of '../paynow.dart';

// Mobile Payment options
enum MobilePaymentMethod {
  ecocash,
  onemoney,
  telecash
}

extension on MobilePaymentMethod{
  String get toRepresentation => this.toString().split('.').last;
}
