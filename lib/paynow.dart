library paynow;


import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

class HashMismatchException implements Exception{
  final String cause;
  HashMismatchException(this.cause);
}

class ValueError implements Exception{

  final String cause;
  ValueError(this.cause);
}

class StatusResponse{

  /// Boolean value indication whether the transaction was paid or not.
  bool paid;

  /// The status of the transaction in Paynow.
  String status;

  /// The total amount of the transaction.
  var amount;

  /// The unique identifier for the transaction.
  String reference;

  /// The unique identifier for the transaction.
  String hash;

  StatusResponse({this.paid, this.status,this.amount,this.reference, this.hash});

  /// Return [StatusResponse] from json.
  static fromJson(Map<String, dynamic> data){

    return StatusResponse(
      paid: data['paid']=="paid",
      status: data['status'],
      amount: data['amount'],
      reference: data['reference'],
      hash: data['hash']
    );
  }
}


class InitResponse{
  /// Boolean indicating whether initiate request was successful or not.
  final bool success;

  /// Instruction for transcation status.
  final String instructions;

  /// Boolean indicating whether the response contains a url to redirect to
  final bool hasRedirect;

  /// Transaction Hash
  final String hash;

  /// The url the user should be taken to so they can make a payment
  final String redirectUrl;

  /// Error String
  final String error;

  /// The poll URL sent from Paynow
  final String pollUrl;

  InitResponse({this.redirectUrl, this.hasRedirect, this.pollUrl, this.error, this.success, this.hash, this.instructions});

  Map<String, dynamic> call(){
    Map<String, dynamic> data = {"redirect" : this.redirectUrl, "hasRedirect" : this.hasRedirect,"pollUrl" : this.pollUrl,"error" : this.error,"success" : this.success,"hash" : this.hash, "instructions" : this.instructions};
    // TODO:/// Refactor
    return data;
  }

  /// Returns [InitResponse]
  static fromJson(Map<String, dynamic> data){

    return InitResponse(
      success: data['status']!="error",
      error: data['error'].toString().toLowerCase(),
      hash: data['hash'],
      hasRedirect: data['browserurl'] != null,
      redirectUrl: data['browserurl'],
      instructions: data['instructions'],
      pollUrl: Paynow.notQuotePlus(data['pollurl'])
    );
  }
}


class Payment{

  /// The unique identifier for the transaction.
  final String reference;

  /// Cart Items.
  List<Map<String, dynamic>> items=[];

  /// The user's email address.
  final String authEmail;

  Payment({this.reference, this.authEmail});

  Payment add(String title, double amount){

    this.items.add({"title" : title, "amount" : amount});

    return this;
  }

  /// Return Info of items in cart.
  String info(){
    String out = "";
    for (int i=0; i<this.items.length;i++){
      out+=this.items.elementAt(i)["title"];
    }
    out+="%2C+";

    return out;
  }

  /// Total amount of items in cart.
  double total(){
    double total=0.0;

    if (this.items.length==0) return 0.0;

    for (int i=0;i<this.items.length;i++){
      total+=this.items[i]['amount'];
    }
    return total;
  }
}

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
class Paynow{
  /// Transaction initation url (constant).
  static const String URL_INITIATE_TRANSACTION = "https://www.paynow.co.zw/interface/initiatetransaction";
  /// Transaction initation url (constant)
  static const String URL_INITIATE_MOBILE_TRANSACTION = "https://www.paynow.co.zw/interface/remotetransaction";

  ///  Merchant's integration Id.
  String integrationId;

  /// Merchant's Key.
  String integrationKey;

  /// Merchant Return Url.
  String returnUrl;

  ///  Merchant's Result Url.
  String resultUrl;

  Paynow({this.integrationId, this.integrationKey, this.returnUrl, this.resultUrl});


  /// Create Payment - Returns [Payment]
  Payment createPayment(String reference, String authEmail){

    return Payment(reference: reference, authEmail: authEmail);
  }



  Future<InitResponse> _init(Payment payment)async{

    if (payment.total() < 0 || payment.total() == 0){
      throw ValueError("Transaction Total Invalid");
    }

    Map<String, dynamic> data = _build(payment);
    var client=http.Client();
    var response = await client.post(Paynow.URL_INITIATE_TRANSACTION, body: data);

    return InitResponse.fromJson(this._rebuildResponse(response.body));


  }

  String _quotePlus(String value){

    try{
      return value.replaceAll(":", "%3A").replaceAll("/", "%2F");
    }catch(e){
      return "";
    }
  }

  static String notQuotePlus(String value){
    // lazy way
    return value.replaceAll("%3A", ":").replaceAll("%2F", "/").replaceAll("%3a", ":").replaceAll("%2f", "/").replaceAll("%3f", "?").replaceAll("%3d", "=");

  }

  Map<String, dynamic> _rebuildResponse(String qry){

  	List<String> q = qry.split("&");
  	Map<String, dynamic> data={};
  	for(int i=0;i<q.length;i++){
  		List<String> parts = q[i].split("=");
  		data[parts[0]] = parts[1];
  	}
  	return data;
  }


  Map<String, dynamic> _build(Payment payment){

    Map<String, dynamic> body = {
      "resulturl" : this.resultUrl,
      "returnurl" : this.returnUrl,
      "reference" : payment.reference,
      "amount" : payment.total(),
      "id" : this.integrationId,
      "additionalinfo" : payment.info(),
      "authemail" : payment.authEmail ?? "",
      "status" : "Message"
    };

    body.keys.forEach((f){

        String _p = _quotePlus(body[f].toString());
        body[f] = _p;
    });



    String out = _stringify(body);

    body['hash'] = _generateHash(out);

    return body;
  }

  /// Check Transaction Status
  ///
  /// Returns [StatusResponse]
  Future<StatusResponse> checkTransactionStatus(String pollUrl)async{


    var response = await http.post(pollUrl.replaceAll("%3a", ":").replaceAll("%2f", "/").replaceAll("%3d", "=").replaceAll("%3f", "?"));
    return StatusResponse.fromJson(this._rebuildResponse(response.body));

  }

  Future<InitResponse> _initMobile(Payment payment, String phone, String method)async{


      if (payment.total()==0) throw Exception("Invalid Total");
      Map<String, dynamic> data = await _buildMobile(payment, phone, method);
      var client=http.Client();
      var response = await client.post(Paynow.URL_INITIATE_MOBILE_TRANSACTION, body: data);
      return InitResponse.fromJson(this._rebuildResponse(response.body));

  }

  _buildMobile(Payment payment, String phone, String method)async{

    Map<String, dynamic> body = {
      "resulturl" : this.resultUrl,
      "returnurl" : this.returnUrl,
      "reference" : "asf",
      "amount" : payment.total(),
      "id" : this.integrationId,
      "additionalinfo" : payment.info(),
      "authemail" : "g@gmail.com",
      "status" : "Message",
      "phone" : phone,
      "method" : method
    };


    body.keys.forEach((f){
      if(f=="authemail"){
        // skip auth
      }else{
        body[f] = _quotePlus(body[f].toString());
      }
    });

    String out = _stringify(body);

    body["hash"] = _generateHash(out); //await __hash(body);

    return body;
  }

  String _stringify(Map<String, dynamic> body){
    String out = "";

    List<String> values = body.keys.toList();
    for (int i=0;i<values.length;i++){
      if (values[i]=="hash"){
        continue;
      }


      out += body[values[i]];

    }

    out+=this.integrationKey;


    return out;
  }

  String _generateHash(String string){
    return sha512.convert(utf8.encode(string)).toString().toUpperCase();
  }

  Future<InitResponse> sendMobile(Payment payment, String phone, String method){
    return this._initMobile(payment, phone, method);
  }

  Future<InitResponse> send(Payment payment){
    return this._init(payment);
  }

}


main(){

}
