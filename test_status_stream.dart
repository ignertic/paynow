import 'package:paynow/paynow.dart';

// test payment status stream
void main() async {
  const String PAYNOW_ID = '';
  const String PAYNOW_KEY = '';
  const String PAYNOW_EMAIL = '';

  final paynow = Paynow(
    integrationId: PAYNOW_ID,
    integrationKey: PAYNOW_KEY,
  );

  var p = paynow.createPayment('reference-test', PAYNOW_EMAIL);
  p.add('test', 1.2);

  var ir = await paynow.sendMobile(p, '07xxxxxx');

  print(ir.toString());

  print('=== once off check status ====');
  var resp = await paynow.checkTransactionStatus(ir.pollUrl);

  print(resp.toString());

  print('==== listening to status stream =====');

  var _stream = paynow.streamTransactionStatus(ir.pollUrl, streamInterval: 20);

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
