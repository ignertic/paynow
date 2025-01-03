
part of 'paynow_checkout_bloc.dart';

abstract class PaynowCheckoutState {}

class PaynowCheckoutInitial extends PaynowCheckoutState {}

class PaynowCheckoutError extends PaynowCheckoutState {
  final String? error;

  PaynowCheckoutError(this.error);
}