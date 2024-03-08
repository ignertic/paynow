import 'package:auto_route/auto_route.dart';
import 'package:example/landing/ui/pages/landing_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(initial: true, page: LandingPage, path: '/'),
  ],
)
// extend the generated private router
class $AppRouter {}
