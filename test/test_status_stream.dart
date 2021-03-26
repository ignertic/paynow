import 'package:paynow/paynow.dart';

// test payment status stream
void main() async {
  const String PAYNOW_INTEGRATION_ID = "PAYNOW_INTEGRATION_ID";
  const String PAYNOW_INTEGRATION_KEY = 'PAYNOW_INTEGREATION_KEY';
  const String PAYNOW_EMAIL = 'youremail@site.com';
  const String RESULT_URL = '';
  const String RETURN_URL = '';

  final paynow = Paynow(
    integrationId: PAYNOW_INTEGRATION_ID,
    integrationKey: PAYNOW_INTEGRATION_KEY,
    returnUrl: RETURN_URL,
    resultUrl: RESULT_URL
  );


  final Payment payment = paynow.createPayment('reference-test', PAYNOW_EMAIL);
  // add item to cart
  payment.add('test', 1.2);

  final InitResponse paynowResponse = await paynow.sendMobile(payment, '07xxxxxx');

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

  print('done!');
}
