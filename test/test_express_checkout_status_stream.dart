import '../lib/paynow.dart';

// test payment status stream
void main() async {
  // USE YOUR KEYS WHEN TESTING A PAYMENT.
  // THESE KEYS WERE ONLY USED FOR TESTING AND HAVE BEEN REVOKED
  const String PAYNOW_INTEGRATION_ID = "6054";
  const String PAYNOW_INTEGRATION_KEY = "960ad10a-fc0c-403b-af14-e9520a50fbf4";
  const String PAYNOW_EMAIL = 'youremail@site.com';
  const String RESULT_URL = 'http:/google.com/q=yoursite';
  const String RETURN_URL = 'http://google.com/q=yoursite';

  final paynow = Paynow(
    integrationId: PAYNOW_INTEGRATION_ID,
    integrationKey: PAYNOW_INTEGRATION_KEY,
    returnUrl: RETURN_URL,
    resultUrl: RESULT_URL
  );


  final Payment payment = paynow.createPayment('reference-test', PAYNOW_EMAIL);
  // add item to cart
  payment.add('test', 10.0);
  // perform Express Checkout
  final InitResponse paynowResponse = await paynow.sendMobile(payment, '0784442662', method: "ecocash");

  // display response data
  print(paynowResponse.toString());

  print('=== once off check status ====');
  final StatusResponse paynowStatusResponse = await paynow.checkTransactionStatus(paynowResponse.pollUrl);

  print(paynowStatusResponse.toString());

  print('==== listening to status stream =====');

  var _stream = paynow.streamTransactionStatus(paynowResponse.pollUrl, streamInterval: 20);

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
