import 'package:flutter/widgets.dart';
import 'package:flutter_supabase_template/account/account.dart';
import 'package:flutter_supabase_template/counter/counter.dart';
import 'package:flutter_supabase_template/login/login.dart';
import 'package:go_router/go_router.dart';

part 'routes.g.dart';

@TypedGoRoute<HomeScreenRoute>(
  path: '/',
)
@immutable
class HomeScreenRoute extends GoRouteData {
  const HomeScreenRoute();

  @override
  String redirect(BuildContext context, GoRouterState state) =>
      const AccountRoute().location;
}

@TypedGoRoute<LoginRoute>(
  path: '/login',
)
@immutable
class LoginRoute extends GoRouteData {
  const LoginRoute({this.from});

  final String? from;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginPage();
  }
}

@TypedGoRoute<AccountRoute>(
  path: '/account',
)
@immutable
class AccountRoute extends GoRouteData {
  const AccountRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AccountPage();
  }
}
