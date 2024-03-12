import 'package:auto_route/auto_route.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/injection/injection.dart';
import 'package:example/common/isar/builders/custom_isar_filter_stream.builder.dart';
import 'package:example/payments/payment.model.dart';
import 'package:flutter/material.dart';
import 'package:paynow/paynow.dart';

class PaynowReturnPage extends StatelessWidget {
  final String paymentId;
  const PaynowReturnPage(
      {super.key, @PathParam('payment_id') required this.paymentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomIsarFilterStreamBuilder(
        collection: (isar) => isar.payments,
        queryBuilder: (isar) => isar.payments.filter().idEqualTo(paymentId),
        onData: (paymentMatches) {
          if (paymentMatches.isEmpty) {
            return const Center(
              child: Text('Sorry No Payment Found'),
            );
          }

          final payment = paymentMatches.first;
          return Column(
            children: [
              StreamBuilder<StatusResponse?>(
                  stream:
                      getIt<Paynow>().streamTransactionStatus(payment.pollUrl),
                  builder: (context, snap) {
                    late Widget widget;

                    if (snap.hasData) {
                      final statusResponse = snap.data!;
                      if (statusResponse.paid) {
                        widget = ListTile(
                          tileColor: Colors.green,
                          leading: Chip(
                            label: Text('Payment Successful',
                                style: context.textTheme.titleMedium?.merge(
                                    const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w900))),
                          ),
                          trailing: const Icon(
                            Icons.check_circle,
                            color: Colors.white,
                          ),
                        );
                      } else {
                        widget = ListTile(
                          tileColor: Colors.red,
                          leading: Chip(
                            label: Text('Payment Failed',
                                style: context.textTheme.titleMedium?.merge(
                                    const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w900))),
                          ),
                          trailing: const Icon(
                            Icons.error,
                            color: Colors.white,
                          ),
                        );
                      }
                    } else if (snap.hasError) {
                      widget = Text(snap.error.toString());
                    } else {
                      widget = const Column(
                        children: [
                          Text('Waiting for payment status event'),
                          LinearProgressIndicator()
                        ],
                      );
                    }

                    return AnimatedSwitcher(
                      duration: const Duration(seconds: 2),
                      child: widget,
                    );
                  }),
              ListTile(
                leading: Text(
                  'Amount',
                  style: context.textTheme.headlineMedium,
                ),
                trailing: Text(
                  payment.stringifiedTotal,
                  style: context.textTheme.headlineMedium?.merge(
                      const TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w900)),
                ),
              ),
              ListTile(
                title: Text('Reference'),
                trailing: Text('${payment.reference}'),
              ),
              ListTile(
                title: Text('Instructions'),
                trailing: Text('${payment.instructions}'),
              ),
              ListTile(
                title: Text('Error'),
                trailing: Text('${payment.error}'),
              ),
              ListTile(
                title: Text('Additional Information'),
                trailing: Text('${payment.additionalInformation}'),
              ),
              ListTile(
                title: Text('Redirect Url'),
                subtitle: Text('${payment.redirectUrl}'),
              )
            ],
          );
        },
      ),
    );
  }
}
