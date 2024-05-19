// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;

import '../../landing/ui/pages/landing_page.dart' as _i1;
import '../../paynow/ui/pages/paynow_checkout_page.dart' as _i3;
import '../../paynow/ui/pages/paynow_return_page.dart' as _i4;
import '../../products/ui/pages/products_list_page.dart' as _i2;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    LandingRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.LandingPage(),
      );
    },
    ProductsListRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.WrappedRoute(child: const _i2.ProductsListPage()),
      );
    },
    PaynowCheckoutRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.PaynowCheckoutPage(),
      );
    },
    PaynowReturnRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PaynowReturnRouteArgs>(
          orElse: () => PaynowReturnRouteArgs(
              paymentId: pathParams.getString('payment_id')));
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.PaynowReturnPage(
          key: args.key,
          paymentId: args.paymentId,
        ),
      );
    },
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(
          LandingRoute.name,
          path: '/',
        ),
        _i5.RouteConfig(
          ProductsListRoute.name,
          path: 'products/list/',
        ),
        _i5.RouteConfig(
          PaynowCheckoutRoute.name,
          path: 'paynow/checkout/',
        ),
        _i5.RouteConfig(
          PaynowReturnRoute.name,
          path: '/paynow/return/:payment_id/',
        ),
      ];
}

/// generated route for
/// [_i1.LandingPage]
class LandingRoute extends _i5.PageRouteInfo<void> {
  const LandingRoute()
      : super(
          LandingRoute.name,
          path: '/',
        );

  static const String name = 'LandingRoute';
}

/// generated route for
/// [_i2.ProductsListPage]
class ProductsListRoute extends _i5.PageRouteInfo<void> {
  const ProductsListRoute()
      : super(
          ProductsListRoute.name,
          path: 'products/list/',
        );

  static const String name = 'ProductsListRoute';
}

/// generated route for
/// [_i3.PaynowCheckoutPage]
class PaynowCheckoutRoute extends _i5.PageRouteInfo<void> {
  const PaynowCheckoutRoute()
      : super(
          PaynowCheckoutRoute.name,
          path: 'paynow/checkout/',
        );

  static const String name = 'PaynowCheckoutRoute';
}

/// generated route for
/// [_i4.PaynowReturnPage]
class PaynowReturnRoute extends _i5.PageRouteInfo<PaynowReturnRouteArgs> {
  PaynowReturnRoute({
    _i6.Key? key,
    required String paymentId,
  }) : super(
          PaynowReturnRoute.name,
          path: '/paynow/return/:payment_id/',
          args: PaynowReturnRouteArgs(
            key: key,
            paymentId: paymentId,
          ),
          rawPathParams: {'payment_id': paymentId},
        );

  static const String name = 'PaynowReturnRoute';
}

class PaynowReturnRouteArgs {
  const PaynowReturnRouteArgs({
    this.key,
    required this.paymentId,
  });

  final _i6.Key? key;

  final String paymentId;

  @override
  String toString() {
    return 'PaynowReturnRouteArgs{key: $key, paymentId: $paymentId}';
  }
}
