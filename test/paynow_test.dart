import 'package:flutter_test/flutter_test.dart';

import 'package:paynow/paynow.dart';

void main() {
  test('check if cart is working', () {
    final paynow = Paynow(
      integrationId: "INTEGRATION_ID",
      integrationKey: "INTEGRATION_KEY",
      returnUrl: "https://return.url",
      resultUrl: "https://result.url"
    );
    final payment = paynow.createPayment("reference", "authEmail");
    payment.add("product", 1.0);
    expect(payment.total(), 1.0);

  });
}
