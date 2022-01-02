import 'package:flutter_test/flutter_test.dart';

import '../lib/paynow.dart';

void main() {
  test('check if cart is working', () {
    final paynow = Paynow(
      integrationId: "8379",
      integrationKey: "a671ff85-94dc-4613-93f2-9d3de0f5d5ff",
      returnUrl: "https://return.url",
      resultUrl: "https://result.url"
    );
    final payment = paynow.createPayment("reference", "authEmail");
    final cartItem1 = PaynowCartItem(title: 'Product 1', amount: 20.0);
    payment.addToCart(cartItem1, quantity: 2);

    expect(payment.items[cartItem1], 2);
    expect(payment.total, 40.0);

  });
}
