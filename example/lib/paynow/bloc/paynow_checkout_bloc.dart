import 'package:bloc/bloc.dart';
import 'package:example/cart_items/cart_item.model.dart';
import 'package:example/common/component/base_bloc.dart';
import 'package:example/common/injection/injection.dart';
import 'package:example/payments/payment.model.dart';
import 'package:flutter/material.dart';
import 'package:paynow/paynow.dart' hide Payment;
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

part 'paynow_checkout_event.dart';
part 'paynow_checkout_state.dart';

class PaynowCheckoutBloc
    extends Bloc<PaynowCheckoutEvent, PaynowCheckoutState> {
  PaynowCheckoutBloc() : super(PaynowCheckoutInitial()) {
    on<StartPaymentEvent>(_onStartPayment);
  }

  Future<void> _onStartPayment(
      StartPaymentEvent event, Emitter<PaynowCheckoutState> emit) async {
    final cartItems = event.cartItems;
    final paymentsRepository = getIt<BaseRepository<Payment>>();

    final payment = Payment()
      ..id = const Uuid().v1()
      ..currency = cartItems.first.currency
      ..total = cartItems.total;
    final createdPayment = await paymentsRepository.create(payment);

    final paynow = getIt<Paynow>();
    final paynowPayment =
        paynow.createPayment('Flutter ZW', 'gish@petalmafrica.com');

    for (final cartItem in cartItems) {
      paynowPayment.addToCart(
          PaynowCartItem(title: cartItem.product$id, amount: cartItem.total));
    }

    final response = await paynow.send(paynowPayment);
    if (response.success ?? false & response.hasRedirect) {
      await paymentsRepository.update(
          createdPayment.id!,
          createdPayment
            ..pollUrl = response.pollUrl
            ..redirectUrl = response.redirectUrl
            ..instructions = response.instructions
            ..error = response.error);
      launchUrl(Uri.parse(response.redirectUrl!),
          mode: LaunchMode.externalApplication);
    } else {
      emit(PaynowCheckoutError(response.error));
    }
  }
}
