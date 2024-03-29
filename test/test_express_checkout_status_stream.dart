import '../lib/paynow.dart';

// test payment status stream
void main() async {
  // USE YOUR KEYS WHEN TESTING A PAYMENT.
  // THESE KEYS WERE ONLY USED FOR TESTING AND HAVE BEEN REVOKED
  const String PAYNOW_INTEGRATION_ID = "17190";
  const String PAYNOW_INTEGRATION_KEY = "fe360955-4a87-4648-b922-c65ed96f90ae";
  const String PAYNOW_EMAIL = 'gishobertgwenzi@outlook.com';
  const String RESULT_URL = 'https://google.com/id';
  const String RETURN_URL = 'https://google.com/id';

  final paynow = Paynow(
      integrationId: PAYNOW_INTEGRATION_ID,
      integrationKey: PAYNOW_INTEGRATION_KEY,
      returnUrl: RETURN_URL,
      resultUrl: RESULT_URL);

  final Payment payment = paynow.createPayment('TEST REF 3', PAYNOW_EMAIL);
  final cartItem1 = PaynowCartItem(title: 'Banana', amount: 2000.5);
  // add item to cart

  payment.addToCart(cartItem1);

  // perform Express Checkout

  final InitResponse paynowResponse = await paynow.send(payment);

  // display response data
  print(paynowResponse.toString());

  print('=== once off check status ====');
  final StatusResponse paynowStatusResponse =
      await paynow.checkTransactionStatus(paynowResponse.pollUrl);

  print(paynowStatusResponse.toString());

  print('==== listening to status stream =====');

  var _stream =
      paynow.streamTransactionStatus(paynowResponse.pollUrl, streamInterval: 5);

  // listen to status changes as opposed to delay and polling
  _stream.listen(
    (event) {
      print('=== stream event at: ${DateTime.now()} | event: $event');
      if (event.status != 'Sent') {
        paynow.closeStream();
      }
    },
  );

  print('Mobile Express Chekout Testing Complete');
}
