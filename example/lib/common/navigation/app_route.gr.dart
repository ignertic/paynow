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
import 'package:auto_route/auto_route.dart' as _i17;
import 'package:flutter/material.dart' as _i18;

import '../../components/dashboard/ui/pages/dashboard_page.dart' as _i6;
import '../../components/qr_code/ui/scanner_page.dart' as _i12;
import '../../dependents/dependent.model.dart' as _i21;
import '../../dependents/ui/forms/dependent_form_page.dart' as _i14;
import '../../dependents/ui/pages/list_dependents_page.dart' as _i11;
import '../../landing/ui/pages/landing_page.dart' as _i5;
import '../../member_accounts/ui/pages/list_member_accounts_page.dart' as _i10;
import '../../members/member.model.dart' as _i20;
import '../../members/ui/forms/member_page.dart' as _i13;
import '../../members/ui/pages/list_members_page.dart' as _i7;
import '../../service_providers/ui/pages/list_service_providers_page.dart'
    as _i8;
import '../../towns/ui/pages/list_towns_page.dart' as _i9;
import '../authentication/model/user.model.dart' as _i19;
import '../authentication/pages/authentication_page.dart' as _i1;
import '../authentication/pages/code_verification_page.dart' as _i3;
import '../authentication/pages/forgot_password_page.dart' as _i2;
import '../authentication/pages/login_page.dart' as _i16;
import '../authentication/pages/new_password_page.dart' as _i4;
import '../authentication/pages/sign_up.widget.dart' as _i15;

class AppRouter extends _i17.RootStackRouter {
  AppRouter([_i18.GlobalKey<_i18.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i17.PageFactory> pagesMap = {
    AuthenticationRoute.name: (routeData) {
      final args = routeData.argsAs<AuthenticationRouteArgs>(
          orElse: () => const AuthenticationRouteArgs());
      return _i17.MaterialPageX<_i19.LocalUser>(
        routeData: routeData,
        child: _i17.WrappedRoute(
            child: _i1.AuthenticationPage(
          key: args.key,
          countryIconPath: args.countryIconPath,
          onSuccessfulLogin: args.onSuccessfulLogin,
        )),
      );
    },
    ForgotPasswordRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.ForgotPasswordPage(),
      );
    },
    CodeVerificationRoute.name: (routeData) {
      final args = routeData.argsAs<CodeVerificationRouteArgs>();
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.CodeVerificationPage(
          key: args.key,
          email: args.email,
        ),
      );
    },
    NewPasswordRoute.name: (routeData) {
      final args = routeData.argsAs<NewPasswordRouteArgs>();
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.NewPasswordPage(
          key: args.key,
          email: args.email,
        ),
      );
    },
    LandingRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i17.WrappedRoute(child: const _i5.LandingPage()),
      );
    },
    DashboardRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.DashboardPage(),
      );
    },
    ListMembersRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.ListMembersPage(),
      );
    },
    ListServiceProvidersRoute.name: (routeData) {
      final args = routeData.argsAs<ListServiceProvidersRouteArgs>();
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.ListServiceProvidersPage(
          townId: args.townId,
          key: args.key,
        ),
      );
    },
    ListTownsRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.ListTownsPage(),
      );
    },
    ListMemberAccountsRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.ListMemberAccountsPage(),
      );
    },
    ListDependentsRoute.name: (routeData) {
      final args = routeData.argsAs<ListDependentsRouteArgs>();
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i17.WrappedRoute(
            child: _i11.ListDependentsPage(
          key: args.key,
          memberId: args.memberId,
        )),
      );
    },
    QRScannerRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i12.QRScannerPage(),
      );
    },
    MemberFormRoute.name: (routeData) {
      final args = routeData.argsAs<MemberFormRouteArgs>(
          orElse: () => const MemberFormRouteArgs());
      return _i17.MaterialPageX<_i20.Member?>(
        routeData: routeData,
        child:
            _i17.WrappedRoute(child: _i13.MemberFormPage(member: args.member)),
      );
    },
    DependentFormRoute.name: (routeData) {
      final args = routeData.argsAs<DependentFormRouteArgs>();
      return _i17.MaterialPageX<_i21.Dependent?>(
        routeData: routeData,
        child: _i17.WrappedRoute(
            child: _i14.DependentFormPage(
          key: args.key,
          memberId: args.memberId,
          dependent: args.dependent,
        )),
      );
    },
    SignUpRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i17.WrappedRoute(child: const _i15.SignUpPage()),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i17.WrappedRoute(
            child: _i16.LoginPage(
          key: args.key,
          countryIconPath: args.countryIconPath,
        )),
      );
    },
  };

  @override
  List<_i17.RouteConfig> get routes => [
        _i17.RouteConfig(
          AuthenticationRoute.name,
          path: 'auth',
          children: [
            _i17.RouteConfig(
              SignUpRoute.name,
              path: 'signup',
              parent: AuthenticationRoute.name,
            ),
            _i17.RouteConfig(
              LoginRoute.name,
              path: 'login',
              parent: AuthenticationRoute.name,
            ),
          ],
        ),
        _i17.RouteConfig(
          ForgotPasswordRoute.name,
          path: 'forgot-password',
        ),
        _i17.RouteConfig(
          CodeVerificationRoute.name,
          path: 'code-verification',
        ),
        _i17.RouteConfig(
          NewPasswordRoute.name,
          path: 'new-password-page',
        ),
        _i17.RouteConfig(
          LandingRoute.name,
          path: '/',
        ),
        _i17.RouteConfig(
          DashboardRoute.name,
          path: 'dashboard/',
        ),
        _i17.RouteConfig(
          ListMembersRoute.name,
          path: '/members/list/',
        ),
        _i17.RouteConfig(
          ListServiceProvidersRoute.name,
          path: '/service-providers',
        ),
        _i17.RouteConfig(
          ListTownsRoute.name,
          path: '/towns',
        ),
        _i17.RouteConfig(
          ListMemberAccountsRoute.name,
          path: '/member-accounts',
        ),
        _i17.RouteConfig(
          ListDependentsRoute.name,
          path: '/dependents',
        ),
        _i17.RouteConfig(
          QRScannerRoute.name,
          path: '/qr/scan/',
        ),
        _i17.RouteConfig(
          MemberFormRoute.name,
          path: 'member/form/',
        ),
        _i17.RouteConfig(
          DependentFormRoute.name,
          path: 'dependent/form/',
        ),
      ];
}

/// generated route for
/// [_i1.AuthenticationPage]
class AuthenticationRoute extends _i17.PageRouteInfo<AuthenticationRouteArgs> {
  AuthenticationRoute({
    _i18.Key? key,
    String? countryIconPath,
    void Function(
      _i19.LocalUser,
      bool,
    )? onSuccessfulLogin,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          AuthenticationRoute.name,
          path: 'auth',
          args: AuthenticationRouteArgs(
            key: key,
            countryIconPath: countryIconPath,
            onSuccessfulLogin: onSuccessfulLogin,
          ),
          initialChildren: children,
        );

  static const String name = 'AuthenticationRoute';
}

class AuthenticationRouteArgs {
  const AuthenticationRouteArgs({
    this.key,
    this.countryIconPath,
    this.onSuccessfulLogin,
  });

  final _i18.Key? key;

  final String? countryIconPath;

  final void Function(
    _i19.LocalUser,
    bool,
  )? onSuccessfulLogin;

  @override
  String toString() {
    return 'AuthenticationRouteArgs{key: $key, countryIconPath: $countryIconPath, onSuccessfulLogin: $onSuccessfulLogin}';
  }
}

/// generated route for
/// [_i2.ForgotPasswordPage]
class ForgotPasswordRoute extends _i17.PageRouteInfo<void> {
  const ForgotPasswordRoute()
      : super(
          ForgotPasswordRoute.name,
          path: 'forgot-password',
        );

  static const String name = 'ForgotPasswordRoute';
}

/// generated route for
/// [_i3.CodeVerificationPage]
class CodeVerificationRoute
    extends _i17.PageRouteInfo<CodeVerificationRouteArgs> {
  CodeVerificationRoute({
    _i18.Key? key,
    required String email,
  }) : super(
          CodeVerificationRoute.name,
          path: 'code-verification',
          args: CodeVerificationRouteArgs(
            key: key,
            email: email,
          ),
        );

  static const String name = 'CodeVerificationRoute';
}

class CodeVerificationRouteArgs {
  const CodeVerificationRouteArgs({
    this.key,
    required this.email,
  });

  final _i18.Key? key;

  final String email;

  @override
  String toString() {
    return 'CodeVerificationRouteArgs{key: $key, email: $email}';
  }
}

/// generated route for
/// [_i4.NewPasswordPage]
class NewPasswordRoute extends _i17.PageRouteInfo<NewPasswordRouteArgs> {
  NewPasswordRoute({
    _i18.Key? key,
    required String email,
  }) : super(
          NewPasswordRoute.name,
          path: 'new-password-page',
          args: NewPasswordRouteArgs(
            key: key,
            email: email,
          ),
        );

  static const String name = 'NewPasswordRoute';
}

class NewPasswordRouteArgs {
  const NewPasswordRouteArgs({
    this.key,
    required this.email,
  });

  final _i18.Key? key;

  final String email;

  @override
  String toString() {
    return 'NewPasswordRouteArgs{key: $key, email: $email}';
  }
}

/// generated route for
/// [_i5.LandingPage]
class LandingRoute extends _i17.PageRouteInfo<void> {
  const LandingRoute()
      : super(
          LandingRoute.name,
          path: '/',
        );

  static const String name = 'LandingRoute';
}

/// generated route for
/// [_i6.DashboardPage]
class DashboardRoute extends _i17.PageRouteInfo<void> {
  const DashboardRoute()
      : super(
          DashboardRoute.name,
          path: 'dashboard/',
        );

  static const String name = 'DashboardRoute';
}

/// generated route for
/// [_i7.ListMembersPage]
class ListMembersRoute extends _i17.PageRouteInfo<void> {
  const ListMembersRoute()
      : super(
          ListMembersRoute.name,
          path: '/members/list/',
        );

  static const String name = 'ListMembersRoute';
}

/// generated route for
/// [_i8.ListServiceProvidersPage]
class ListServiceProvidersRoute
    extends _i17.PageRouteInfo<ListServiceProvidersRouteArgs> {
  ListServiceProvidersRoute({
    required String townId,
    _i18.Key? key,
  }) : super(
          ListServiceProvidersRoute.name,
          path: '/service-providers',
          args: ListServiceProvidersRouteArgs(
            townId: townId,
            key: key,
          ),
        );

  static const String name = 'ListServiceProvidersRoute';
}

class ListServiceProvidersRouteArgs {
  const ListServiceProvidersRouteArgs({
    required this.townId,
    this.key,
  });

  final String townId;

  final _i18.Key? key;

  @override
  String toString() {
    return 'ListServiceProvidersRouteArgs{townId: $townId, key: $key}';
  }
}

/// generated route for
/// [_i9.ListTownsPage]
class ListTownsRoute extends _i17.PageRouteInfo<void> {
  const ListTownsRoute()
      : super(
          ListTownsRoute.name,
          path: '/towns',
        );

  static const String name = 'ListTownsRoute';
}

/// generated route for
/// [_i10.ListMemberAccountsPage]
class ListMemberAccountsRoute extends _i17.PageRouteInfo<void> {
  const ListMemberAccountsRoute()
      : super(
          ListMemberAccountsRoute.name,
          path: '/member-accounts',
        );

  static const String name = 'ListMemberAccountsRoute';
}

/// generated route for
/// [_i11.ListDependentsPage]
class ListDependentsRoute extends _i17.PageRouteInfo<ListDependentsRouteArgs> {
  ListDependentsRoute({
    _i18.Key? key,
    required String memberId,
  }) : super(
          ListDependentsRoute.name,
          path: '/dependents',
          args: ListDependentsRouteArgs(
            key: key,
            memberId: memberId,
          ),
        );

  static const String name = 'ListDependentsRoute';
}

class ListDependentsRouteArgs {
  const ListDependentsRouteArgs({
    this.key,
    required this.memberId,
  });

  final _i18.Key? key;

  final String memberId;

  @override
  String toString() {
    return 'ListDependentsRouteArgs{key: $key, memberId: $memberId}';
  }
}

/// generated route for
/// [_i12.QRScannerPage]
class QRScannerRoute extends _i17.PageRouteInfo<void> {
  const QRScannerRoute()
      : super(
          QRScannerRoute.name,
          path: '/qr/scan/',
        );

  static const String name = 'QRScannerRoute';
}

/// generated route for
/// [_i13.MemberFormPage]
class MemberFormRoute extends _i17.PageRouteInfo<MemberFormRouteArgs> {
  MemberFormRoute({_i20.Member? member})
      : super(
          MemberFormRoute.name,
          path: 'member/form/',
          args: MemberFormRouteArgs(member: member),
        );

  static const String name = 'MemberFormRoute';
}

class MemberFormRouteArgs {
  const MemberFormRouteArgs({this.member});

  final _i20.Member? member;

  @override
  String toString() {
    return 'MemberFormRouteArgs{member: $member}';
  }
}

/// generated route for
/// [_i14.DependentFormPage]
class DependentFormRoute extends _i17.PageRouteInfo<DependentFormRouteArgs> {
  DependentFormRoute({
    _i18.Key? key,
    required String memberId,
    _i21.Dependent? dependent,
  }) : super(
          DependentFormRoute.name,
          path: 'dependent/form/',
          args: DependentFormRouteArgs(
            key: key,
            memberId: memberId,
            dependent: dependent,
          ),
        );

  static const String name = 'DependentFormRoute';
}

class DependentFormRouteArgs {
  const DependentFormRouteArgs({
    this.key,
    required this.memberId,
    this.dependent,
  });

  final _i18.Key? key;

  final String memberId;

  final _i21.Dependent? dependent;

  @override
  String toString() {
    return 'DependentFormRouteArgs{key: $key, memberId: $memberId, dependent: $dependent}';
  }
}

/// generated route for
/// [_i15.SignUpPage]
class SignUpRoute extends _i17.PageRouteInfo<void> {
  const SignUpRoute()
      : super(
          SignUpRoute.name,
          path: 'signup',
        );

  static const String name = 'SignUpRoute';
}

/// generated route for
/// [_i16.LoginPage]
class LoginRoute extends _i17.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i18.Key? key,
    String? countryIconPath,
  }) : super(
          LoginRoute.name,
          path: 'login',
          args: LoginRouteArgs(
            key: key,
            countryIconPath: countryIconPath,
          ),
        );

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({
    this.key,
    this.countryIconPath,
  });

  final _i18.Key? key;

  final String? countryIconPath;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, countryIconPath: $countryIconPath}';
  }
}
