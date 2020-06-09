// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:example/models/catalog.dart';
import 'package:paynow/paynow.dart';
import 'package:url_launcher/url_launcher.dart';

class CartModel extends ChangeNotifier {
  Paynow _paynow;
  Payment _payment;
  final String integrationId;
  final String integrationKey;
  final String returnUrl;
  final String resultUrl;

  String _phone;
  var _transactionResponse;
  bool paid;

  /// The private field backing [catalog].
  CatalogModel _catalog;

  /// Internal, private state of the cart. Stores the ids of each item.
  final List<int> _itemIds = [];

  /// The current catalog. Used to construct items from numeric ids.
  CatalogModel get catalog => _catalog;

  CartModel({this.integrationId, this.integrationKey, this.resultUrl, this.returnUrl}){
    this._paynow = Paynow(
      integrationId: this.integrationId,
      integrationKey: this.integrationKey,
      resultUrl: this.resultUrl,
      returnUrl: this.returnUrl
    );

     /// Create Payment Instance
    this._payment = this._paynow.createPayment('Paynow Demo', 'demo@paynow.co.zw');

  }

  set catalog(CatalogModel newCatalog) {
    assert(newCatalog != null);
    assert(_itemIds.every((id) => newCatalog.getById(id) != null),
        'The catalog $newCatalog does not have one of $_itemIds in it.');
    _catalog = newCatalog;
    // Notify listeners, in case the new catalog provides information
    // different from the previous one. For example, availability of an item
    // might have changed.
    notifyListeners();
  }

  /// List of items in the cart.
  List<Item> get items => this._payment.items.map((e) => e['title']).toList();


  /// The current total price of all items in paynow cart
  double get totalPrice =>
      this._payment.total();

  /// Adds [item] to cart. This is the only way to modify the cart from outside.
  void add(Item item) {
//    _itemIds.add(item.id);
    this._payment.add(item.name, item.price);
    // This line tells [Model] that it should rebuild the widgets that
    // depend on it.
    notifyListeners();
  }

  checkTransactionStatus()async{
    final response = await this._paynow.checkTransactionStatus(this._transactionResponse.pollUrl);
    this.paid = response.paid;
    notifyListeners();

  }

  void expressCheckout(String phone)async{
    final response = await this._paynow.sendMobile(this._payment, this._phone); // method is set to 'ecocash' by default
    this._transactionResponse = response;

    // delay
    Future.delayed(Duration(seconds: 6), this.checkTransactionStatus);
  }

  void webCheckout()async{
    final response = await this._paynow.send(this._payment);
    // open in browser
    launch(response.redirectUrl);
  }
}
