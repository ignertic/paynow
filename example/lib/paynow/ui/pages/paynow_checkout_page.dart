import 'package:example/cart_items/cart_item.model.dart';
import 'package:example/common/component/base_bloc.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/injection/injection.dart';
import 'package:example/common/isar/builders/custom_isar_filter_stream.builder.dart';
import 'package:example/payments/payment.model.dart';
import 'package:example/paynow/bloc/paynow_checkout_bloc.dart';
import 'package:example/products/product.model.dart';
import 'package:flutter/material.dart';
import 'package:paynow/paynow.dart' hide Payment;
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaynowCheckoutPage extends StatelessWidget {
  const PaynowCheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PaynowCheckoutBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Final Step'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // show cart items
              CustomIsarFilterStreamBuilder<CartItem>(
                queryBuilder: (isar) => isar.cartItems.filter().idIsNotNull(),
                collection: (isar) => isar.cartItems,
                onData: (cartItems) {
                  return Column(
                    children: [
                      ListTile(
                        leading: Text('TOTAL',
                            style: context.textTheme.headlineMedium),
                        trailing: Text(
                          cartItems.stringifiedTotal,
                          style: context.textTheme.headlineLarge?.merge(
                              const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.blue)),
                        ),
                      ),
                      SizedBox(
                        height: context.height / 2,
                        child: ListView.separated(
                          separatorBuilder: (contex, index) => const Divider(),
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            final cartItem = cartItems[index];

                            return CustomIsarFilterStreamBuilder(
                                collection: (isar) => isar.products,
                                queryBuilder: (isar) => isar.products
                                    .filter()
                                    .idEqualTo(cartItem.product$id),
                                onData: (productMatches) {
                                  if (productMatches.isEmpty) {
                                    return Text(
                                        'No Product Matching ${cartItem.product$id}');
                                  }
                                  final product = productMatches.first;
                                  return ListTile(
                                    leading: Text(
                                      cartItem.quantity.toString(),
                                      style: context.textTheme.headlineMedium
                                          ?.merge(const TextStyle(
                                              fontWeight: FontWeight.w900)),
                                    ),
                                    title: Text(product.title),
                                    subtitle: RichText(
                                      text: TextSpan(
                                          text: "x ${product.currency} ",
                                          style: const TextStyle(
                                              color: Colors.black),
                                          children: [
                                            TextSpan(text: "${product.price}")
                                          ]),
                                    ),
                                    trailing: Text(
                                      cartItem.stringifiedTotal,
                                      style: context.textTheme.labelLarge
                                          ?.merge(const TextStyle(
                                              fontWeight: FontWeight.w700)),
                                    ),
                                  );
                                });
                          },
                        ),
                      ),
                      SizedBox(
                        width: context.width / 1.5,
                        child: StartPaymentButtonWidget(
                          cartItems: cartItems,
                        ),
                      )
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class StartPaymentButtonWidget extends StatelessWidget {
  final List<CartItem> cartItems;
  const StartPaymentButtonWidget({
    super.key,
    required this.cartItems,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
      icon: const Icon(
        Icons.money,
        color: Colors.white,
      ),
      label: Text(
        'Proceed To Pay',
        style: context.textTheme.labelLarge?.merge(const TextStyle(
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: 2)),
      ),
      onPressed: () {
        context.read<PaynowCheckoutBloc>().add(StartPaymentEvent(cartItems));
      },
    );
  }
}
