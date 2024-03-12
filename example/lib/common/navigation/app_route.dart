import 'package:auto_route/auto_route.dart';
import 'package:example/landing/ui/pages/landing_page.dart';
import 'package:example/paynow/ui/pages/paynow_checkout_page.dart';
import 'package:example/paynow/ui/pages/paynow_return_page.dart';
import 'package:example/products/ui/pages/products_list_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(initial: true, page: LandingPage, path: '/'),
    AutoRoute(page: ProductsListPage, path: "products/list/"),
    AutoRoute(page: PaynowCheckoutPage, path: "paynow/checkout/"),
    AutoRoute(page: PaynowReturnPage, path: '/paynow/return/:payment_id/'),
  ],
)
// extend the generated private router
class $AppRouter {}
