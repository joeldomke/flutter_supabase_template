import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_supabase_template/app/bloc/app_bloc.dart';
import 'package:flutter_supabase_template/app/routes/routes.dart';
import 'package:flutter_supabase_template/app/routes/utils.dart';
import 'package:flutter_supabase_template/l10n/l10n.dart';
import 'package:go_router/go_router.dart';

class AppView extends StatefulWidget {
  const AppView({required this.appBloc, super.key});

  final AppBloc appBloc;

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = GoRouter(
      routes: $appRoutes,
      redirect: (BuildContext context, GoRouterState state) {
        final appBloc = context.read<AppBloc>();
        final loggedIn = appBloc.state.status == AppStatus.authenticated;
        final loggingIn = state.subloc == const LoginRoute().location;
        if (!loggedIn && !loggingIn) {
          return LoginRoute(from: state.subloc).location;
        }
        if (loggedIn && loggingIn) {
          return const HomeScreenRoute().location;
        }
        return null;
      },
      refreshListenable: GoRouterRefreshStream(widget.appBloc.stream),
      debugLogDiagnostics: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Very Good Supabase',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Colors.teal),
        colorScheme: const ColorScheme.light().copyWith(
          primary: Colors.teal,
        ),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: _router,
    );
  }
}
