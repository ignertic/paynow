library paynow;


import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:steel_crypt/steel_crypt.dart';
import 'package:http/http.dart' as http;
// / A Calculator.
class HashMismatchException implements Exception{
  String cause;
  HashMismatchException(this.cause);
}

class ValueError implements Exception{
  String cause;
  ValueError(this.cause);
}

class StatusResponse{

  String paid;

  String status;

  double amount;

  String reference;

  String hash;

  StatusResponse({this.paid, this.status,this.amount,this.reference, this.hash});

  static fromJson(Map<String, dynamic> data){

    return StatusResponse(
      paid: data['paid'],
      status: data['status'],
      amount: double.parse(data['amount']),
      reference: data['reference'],
      hash: data['hash']
    );
  }
}


class InitResponse{
  bool success;

  String instructions;

  bool hasRedirect;

  String hash;

  String redirectUrl;

  String error;

  String pollUrl;

  InitResponse({this.redirectUrl, this.hasRedirect, this.pollUrl, this.error, this.success, this.hash, this.instructions});


  static fromJson(Map<String, dynamic> data){
    return InitResponse(
      success: data['status']!="error",
      error: data['error'].toString().toLowerCase(),
      hash: data['hash'],
      hasRedirect: data['browserurl'] != null,
      redirectUrl: data['browserurl'],
      instructions: data['instructions']
    );
  }
}


class Payment{
  String reference;

  List<Map<String, dynamic>> items=[];

  String authEmail;

  Payment({String reference, String authEmail});

  Payment add(String title, double amount){

    this.items.add({"title" : title, "amount" : amount});

    return this;
  }

  String info(){
    String out = "";
    for (int i=0; i<this.items.length;i++){
      out+=this.items.elementAt(i)["title"];
    }
    out+="%2C+";

    return out;
  }

  double total(){
    double total=0.0;

    if (this.items.length==0) return 0.0;

    for (int i=0;i<this.items.length;i++){
      total+=this.items[i]['amount'];
    }
    return total;
  }
}


class Paynow{
  static const String URL_INITIATE_TRANSACTION = "https://www.paynow.co.zw/interface/initiatetransaction";
  static const String URL_INITIATE_MOBILE_TRANSACTION = "https://www.paynow.co.zw/interface/remotetransaction";

  String integrationId;

  String integrationKey;

  String returnUrl;

  Function onError;

  Function onCheck;

  Function onDone;

  String resultUrl;

  Paynow({this.integrationId, this.integrationKey, this.returnUrl, this.resultUrl});

  Payment createPayment(String reference, String authEmail)=>Payment(reference: reference, authEmail: authEmail);

  _onDone(Response response){
    print(response.data);
    Map<String, dynamic> data = this._rebuildResponse(response.data);
    var result = onDone==null ? (data){
      print(data);
      print("False");
    } : this.onDone(InitResponse.fromJson(data));
  }
  __init(Payment payment){

    if (payment.total() < 0){
      throw ValueError("Transaction Total Invalid");
    }

    Map<String, dynamic> data = this.__build(payment);

    // Make POST request to Paynow
    Dio().post(Paynow.URL_INITIATE_TRANSACTION, data: data)
    ..then(this._onDone);
    // Map<String, dynamic> responseObject = _rebuildResponse(response.data);

  }

  String _quotePlus(String value){
    // lazy way
    return value.replaceAll(":", "%3A").replaceAll("/", "%2F");
  }

  String _notQuotePlus(String value){
    // lazy way
    return value.replaceAll("%3A", ":").replaceAll("%2F", "/");
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


  Map<String, dynamic> __build(Payment payment){

    Map<String, dynamic> body = {
      "resulturl" : this.resultUrl,
      "returnurl" : this.returnUrl,
      "reference" : payment.reference,
      "amount" : payment.total(),
      "id" : this.integrationId,
      "additionalinfo" : payment.info(),
      "authemail" : payment.authEmail,
      "status" : "Message"
    };

    body.keys.forEach((f){
      body[f] = _quotePlus(body[f].toString());
    });

    return body;
  }

  Future<StatusResponse> checkTransactionStatus(String pollUrl)async{
    // POST Request
    var client = http.Client();

    try{
      var response = client.post(pollUrl.replaceAll("%3a", ":").replaceAll("%2f", "/").replaceAll("%3d", "=").replaceAll("%3f", "?"));
      response.then((res){
        // print(res.body);
        StatusResponse data = StatusResponse.fromJson(this._rebuildResponse(res.body));
        this.onCheck(data);

      });

    }catch(e){
      this.onError(e);
    }
  }

  _initMobile(Payment payment, String phone, String method)async{

    try{

      if (payment.total()==0) throw Exception("Invalid Total");
      Map<String, dynamic> data = await _buildMobile(payment, phone, method);
      var client=http.Client();
      client.post(Paynow.URL_INITIATE_MOBILE_TRANSACTION, body: data).then((res){
        this.onDone(this._rebuildResponse(res.body));
        client.close();
      });
    }catch(e){this.onError(e);}
  }

  __hash(Map<String, dynamic> data)async{

  var url = "http://144.202.106.91:8008/parse/${this.integrationKey}";

  try{

    var response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);

      return res['hash'];
    } else {
      print("Request failed with status: ${response.statusCode}.");
    }
    return "";

  }catch(e){
    this.onError(e);
  }

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
        print("skip emai;");
      }else{
        body[f] = _quotePlus(body[f].toString());
      }
    });

    String out = "";
    List<String> values = body.keys.toList();
    for (int i=0;i<values.length;i++){
      if (values[i]=="hash"){
        continue;
      }
      out+=body[values[i]];
    }
    out+=this.integrationKey;
    body["hash"] = await __hash(body);
    return body;
  }

}



main(){
  Paynow paynow = Paynow(integrationKey: "960ad10a-fc0c-403b-af14-e9520a50fbf4", integrationId: "6054", returnUrl: "http://google.com", resultUrl: "http://google.co");

  Payment payment = paynow.createPayment(DateTime.now().toString(), "user@email.com");

  payment.add("Banana", 23.9);
  
  paynow.onDone = (response){
    // Future.delayed(duration);
    print("Checking Transaction Status");
    paynow.checkTransactionStatus(response['pollurl']);
  };


  paynow.onCheck = (StatusResponse response){
    print(response.reference);
  };

  paynow._initMobile(payment, "0784442662", "ecocash");



}
