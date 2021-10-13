library paynow;
import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:localregex/localregex.dart';



part '_routes.dart';
part 'models/_paynow_cart_item.dart';
part 'errors/errors.dart';
part 'payment_status_stream_manager/payment_status_stream_manager.dart';
part 'models/status_response.dart';
part 'models/init_response.dart';
part 'models/payment.dart';
part 'models/mobile_payment_methods.dart';




LocalRegex localRegex = LocalRegex();


/// Contains helper methods to interact with the Paynow API.
///
///  Attributes:
///  integrationId : Merchant's integration id.
///  integrationKey :  Merchant's integration key.
///  returnUrl :  Merchant's return url.
///  resultUrl :  Merchant's result url.
///
///  Args:
///   integrationId : Merchant's integration id. (You can generate this in your merchant dashboard).
///   integrationKey :  Merchant's integration key.
///   returnUrl :  Merchant's return url.
///   resultUrl:  Merchant's result url.
class Paynow {
  /// Transaction initation url (constant).

  ///  Merchant's integration Id.
  String? integrationId;

  /// Merchant's Key.
  String? integrationKey;

  /// Merchant Return Url.
  String? returnUrl;

  ///  Merchant's Result Url.
  String? resultUrl;

  /// internal payment status stream manager
  _PaymentStatusStreamManager? _statusStreamManager;

  ///
  Paynow({
    required this.integrationId,
    required this.integrationKey,
    required this.returnUrl,
    required this.resultUrl,
  });

  /// Create Payment - Returns [Payment]
  Payment createPayment(String reference, String authEmail) {
    return Payment(reference: reference, authEmail: authEmail, items: {});
  }

  Future<InitResponse> _init(Payment payment) async {
    if (payment.total < 0 || payment.total == 0) {
      throw ValueError("Transaction Total Invalid");
    }

    Map<String, dynamic> data = _build(payment);

    var response =
        await http.post(Uri.parse(PaynowUrlRoutes.URL_INITIATE_TRANSACTION), body: data);



    return InitResponse.fromJson(this._rebuildResponse(response.body));
  }

  String _quotePlus(String value) {
    try {
      return value
          .replaceAll(":", "%3A")
          .replaceAll("/", "%2F")
          .replaceAll("@", "%40");
    } catch (e) {
      return "";
    }
  }

  static String notQuotePlus(String value) {
    // lazy way
    return value
        .replaceAll("%3A", ":")
        .replaceAll("%2F", "/")
        .replaceAll("%3a", ":")
        .replaceAll("%2f", "/")
        .replaceAll("%3f", "?")
        .replaceAll("%3d", "=");
  }

  Map<String, dynamic> _rebuildResponse(String qry) {
    List<String> q = qry.split("&");
    Map<String, dynamic> data = {};
    for (int i = 0; i < q.length; i++) {
      List<String> parts = q[i].split("=");
      data[parts[0]] = parts[1];
    }
    return data;
  }

  Map<String, dynamic> _build(Payment payment) {
    Map<String, dynamic> body = {
      "reference": payment.reference,
      "amount": payment.total,
      "id": this.integrationId,
      "additionalinfo": payment.info,

      "authemail": payment.authEmail,
      "status": "Message",
    };

    body.keys.forEach((f) {
      String _p = _quotePlus(body[f].toString());
      body[f] = _p;
    });

    // send urls as is
    body['resulturl'] = this.resultUrl;
    body['returnurl'] = this.returnUrl;

    String out = _stringify(body);

    body['hash'] = _generateHash(out);

    return body;
  }

  /// Stream Transaction Status,
  ///
  /// streamInterval shows the number of seconds to wait for next polling in the stream
  ///
  /// returns a [Stream] of [StatusResponse]
  Stream<StatusResponse> streamTransactionStatus(
    String? pollUrl, {
    int streamInterval = 20,
  }) {
    _statusStreamManager =
        _PaymentStatusStreamManager(this, pollUrl!, streamInterval: streamInterval);

    return _statusStreamManager!.statusTransactionStream;
  }

  /// close [streamTransactionStatus] stream
  void closeStream() {
    if (_statusStreamManager != null) {
      _statusStreamManager!.dispose();
    }
  }

  /// Check Transaction Status
  ///
  /// Returns [StatusResponse]
  Future<StatusResponse> checkTransactionStatus(String? pollUrl) async {
    var response = await http.post(
      Uri.parse(pollUrl!
          .replaceAll("%3a", ":")
          .replaceAll("%2f", "/")
          .replaceAll("%3d", "=")
          .replaceAll("%3f", "?")),
    );

    return StatusResponse.fromJson(this._rebuildResponse(response.body));
  }

  /// Send  mobile payment request to Paynow
  /// Returns [InitResponse]
  Future<InitResponse> _initMobile(
    Payment payment,
    String phone,
    String method,
  ) async {
    if (payment.total == 0) {
      throw Exception("Total balance of cart items cannot be 0");
    }

    Map<String, dynamic> data = await _buildMobile(payment, phone, method);




    final response = await http.post(
      Uri.parse(PaynowUrlRoutes.URL_INITIATE_MOBILE_TRANSACTION),
      body: data,
    );

    return InitResponse.fromJson(this._rebuildResponse(response.body));
  }

  /// Build Mobile transaction request
  /// Returns [Map<String, dynamic>]
  Future<Map<String, dynamic>> _buildMobile(Payment payment, String phone, String method) async {
    Map<String, dynamic> body = {
      'reference': payment.reference,
      "amount": payment.total,
      "id": this.integrationId,
      "additionalinfo": payment.info,
      "authemail": payment.authEmail,
      "status": "Message",
      "phone": phone,
      "method": method,
    };

    body.keys.forEach((paymentInfoElement) {
      if (paymentInfoElement == "authemail") {
        // skip auth email
        // Triggers a bug
      } else {
        body[paymentInfoElement] = _quotePlus(body[paymentInfoElement].toString());
      }
    });

    // send urls as is
    body['resulturl'] = this.resultUrl;
    body['returnurl'] = this.returnUrl;

    String out = _stringify(body);

    body["hash"] = _generateHash(out); //await __hash(body);

    return body;
  }


  /// convert payment body to [String]
  String _stringify(Map<String, dynamic> body) {
    String out = "";

    List<String> values = body.keys.toList();

    for (int i = 0; i < values.length; i++) {
      if (values[i] != "hash") {
        out += body[values[i]];
      }
    }

    out += this.integrationKey!;

    return out;
  }

  /// generate secure hash for the payment request
  String _generateHash(String string) {
    String _hash = sha512.convert(utf8.encode(string)).toString().toUpperCase();

    return _hash;
  }

  /// Initiate mobile transactions
  Future<InitResponse> sendMobile(
    Payment payment,
    String phone,
    MobilePaymentMethod method,
  ) {

    if (
      !(localRegex.isEconet(phone) ||
      localRegex.isNetone(phone) ||
      localRegex.isTelecel(phone))
    ){
      throw ValueError('Invalid Mobile Number');
    }

    return this._initMobile(payment, phone, method.toRepresentation);
  }

  Future<InitResponse> send(Payment payment) {
    return this._init(payment);
  }
}
