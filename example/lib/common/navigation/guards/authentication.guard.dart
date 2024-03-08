import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

// check if user is authenticated
@singleton
class AuthenticationGuard extends AutoRouteGuard{

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router){
    resolver.next(true);

  }
}
