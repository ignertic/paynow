import 'dart:async';
import '../models/status_response.dart';


/// stream payment status rather than waiting for delay
class PaymentStatusStreamManager {
  PaymentStatusStreamManager(this._paynowObject, this._pollUrl, {int streamInterval = 20}) {
    _startStream(streamInterval);
    //statusTransactionStream.listen((statusResponse) => statusResponse);
  }
  final _paynowObject;
  final String _pollUrl;

  late final Timer _timer;

  final StreamController<StatusResponse> _statusTransactionController =
      StreamController<StatusResponse>();

  Stream<StatusResponse> get statusTransactionStream => _statusTransactionController.stream;

  void _startStream(int streamInterval) {
    _timer = Timer.periodic(
      Duration(seconds: streamInterval),
      (timer) async {
        // maximum checks 5
        if (timer.tick == 5){
          dispose();
        }else{

          // poll transaction poll-url
          var _status = await _paynowObject.checkTransactionStatus(_pollUrl);

          // update stream with latest poll url result
          _statusTransactionController.sink.add(_status);
        }
      },
    );
  }


  /// close timer and stream controller
  void dispose() {
    _timer.cancel();
    _statusTransactionController.close();
  }
}
