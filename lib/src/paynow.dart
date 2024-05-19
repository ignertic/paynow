import 'dart:async';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:localregex/localregex.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../_routes.dart';
import '../errors/errors.dart';
import '../models/models.dart'
    show InitResponse, Payment, StatusResponse, MobilePaymentMethod, Currency;
import '../payment_status_stream_manager/payment_status_stream_manager.dart';
import 'hash.dart';

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
  /// Transaction initiation url (constant).

  ///  Merchant's integration Id.
  String integrationId;

  /// Merchant's Key.
  String integrationKey;

  /// Merchant Return Url.
  String returnUrl;

  ///  Merchant's Result Url.
  String resultUrl;

  /// internal payment status stream manager
  PaymentStatusStreamManager? _statusStreamManager;

  /// Dio
  Dio dio = Dio()
    ..options.baseUrl = "https://www.paynow.co.zw/interface"
    ..options.validateStatus = (status) {
      return (status ?? 500) < 500;
    };

  Paynow({
    required this.integrationId,
    required this.integrationKey,
    required this.returnUrl,
    required this.resultUrl,
    bool enableLogging = true,
  }) {
    if (enableLogging) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        error: true,
      ));
    }
  }

  /// Create Payment - Returns [Payment]
  Payment createPayment(
    String reference,
    String authEmail, {
    Currency currency = Currency.zig,
  }) {
    return Payment(
      reference: reference,
      authEmail: authEmail,
      items: {},
    );
  }

  Future<InitResponse> _init(Payment payment) async {
    if (payment.total < 0 || payment.total == 0) {
      throw ValueError("Transaction Total Invalid");
    }

    Map<String, dynamic> data = _build(payment);

    final response = await dio.post(PaynowUrlRoutes.URL_INITIATE_TRANSACTION,
        data: FormData.fromMap(data),
        options: Options(headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
        }));

    return InitResponse.fromJson(this._rebuildResponse(response.data));
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

  static DateTime? parseExpiration(String date) {
    final dateFormat = DateFormat("d-MMM-yyyy+HH:mm");

    try {
      final DateTime dateTime = dateFormat.parse(date);
      return dateTime;
    } catch (_) {
      return null;
    }
  }

  Map<String, dynamic> _rebuildResponse(String query) {
    List<String> querySlices = query.split("&");
    Map<String, dynamic> data = {};
    for (int index = 0; index < querySlices.length; index++) {
      List<String> imports = querySlices[index].split("=");
      data[imports[0]] = imports[1];
    }
    return data;
  }

  Map<String, dynamic> _build(Payment payment) {
    Map<String, dynamic> requestBody = {
      "id": this.integrationId,
      "reference": payment.reference,
      "amount": payment.total,
      "authemail": payment.authEmail,
      "additionalinfo": payment.info,
    };

    // send urls as is
    requestBody['returnurl'] = this.returnUrl;
    requestBody['resulturl'] = this.resultUrl;
    requestBody['status'] = 'Message';

    String payloadForHashString = _stringify(requestBody);
    String transactionHash = generatePaynowHash(payloadForHashString);

    requestBody['hash'] = transactionHash;
    return requestBody;
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
    _statusStreamManager = PaymentStatusStreamManager(this, pollUrl!,
        streamInterval: streamInterval);

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
    var response = await dio.post(
      pollUrl!
          .replaceAll("%3a", ":")
          .replaceAll("%2f", "/")
          .replaceAll("%3d", "=")
          .replaceAll("%3f", "?"),
    );

    return StatusResponse.fromJson(this._rebuildResponse(response.data));
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

    final response =
        await dio.post(PaynowUrlRoutes.URL_INITIATE_MOBILE_TRANSACTION,
            data: FormData.fromMap(data),
            options: Options(headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/x-www-form-urlencoded',
            }));

    return InitResponse.fromJson(this._rebuildResponse(response.data));
  }

  /// Build Mobile transaction request
  /// Returns [Map<String, dynamic>]
  Future<Map<String, dynamic>> _buildMobile(
      Payment payment, String phone, String method) async {
    Map<String, dynamic> body = {
      "method": method,
      "phone": phone,
      "authemail": payment.authEmail,
      'reference': payment.reference,
      "amount": payment.total.toString(),
      "id": this.integrationId,
      "additionalinfo": payment.info,
      "status": "Message",
    };

    // send urls as is
    body['resulturl'] = this.resultUrl;
    body['returnurl'] = this.returnUrl;

    String out = _stringify(body);

    body["hash"] = generatePaynowHash(out);

    return body;
  }

  /// convert payment body to [String]
  String _stringify(Map<String, dynamic> body) {
    List values = body.values.toList();

    String outputString = values.fold("", (previousValue, element) {
      return previousValue + element.toString();
    });

    outputString += this.integrationKey;

    return outputString;
  }

  /// Initiate mobile transactions
  Future<InitResponse> sendMobile(
    Payment payment,
    String phone,
    MobilePaymentMethod method,
  ) {
    if (!(LocalRegex.isEconet(phone) ||
        LocalRegex.isNetone(phone) ||
        LocalRegex.isTelecel(phone))) {
      throw ValueError('Invalid Mobile Number');
    }

    return this._initMobile(payment, phone, method.toRepresentation);
  }

  Future<InitResponse> send(Payment payment) {
    return this._init(payment);
  }

  static String constructInnbucksDeepLink(String authorizationCode) {
    return 'schinn.wbpycode://innbucks.co.zw?pymInnCode=$authorizationCode';
  }
}

extension on MobilePaymentMethod {
  String get toRepresentation => this.toString().split('.').last;
}
