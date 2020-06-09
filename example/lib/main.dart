// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:example/models/cart.dart';
import 'package:example/models/catalog.dart';
import 'package:example/screens/cart.dart';
import 'package:example/screens/catalog.dart';
import 'package:example/screens/login.dart';
import 'package:example/common/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String integrationKey = '';
  final String integrationId = '';
  final String returnUrl = '';
  final String resultUrl = '';

  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        // In this sample app, CatalogModel never changes, so a simple Provider
        // is sufficient.
        Provider(create: (context) => CatalogModel()),
        // CartModel is implemented as a ChangeNotifier, which calls for the use
        // of ChangeNotifierProvider. Moreover, CartModel depends
        // on CatalogModel, so a ProxyProvider is needed.
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(
              integrationId : this.integrationId,
              integrationKey : this.integrationKey,
              returnUrl: this.returnUrl,
              resultUrl: this.resultUrl
          ),
          update: (context, catalog, cart) {
            cart.catalog = catalog;
            return cart;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Provider Demo',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => MyCatalog(),
          '/cart': (context) => MyCart(),

        },
      ),
    );
  }
}
