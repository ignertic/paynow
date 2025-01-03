
part of 'paynow_checkout_bloc.dart';

abstract class PaynowCheckoutEvent {}

class StartPaymentEvent extends PaynowCheckoutEvent {
  final List<CartItem> cartItems;

  StartPaymentEvent(this.cartItems);
}