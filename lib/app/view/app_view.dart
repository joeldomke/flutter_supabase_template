import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_supabase_template/app/bloc/app_bloc.dart';
import 'package:flutter_supabase_template/l10n/l10n.dart';
import 'package:flutter_supabase_template/login/login.dart';
import 'package:go_router/go_router.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  void initState() {
    super.initState();
  }

  final _router = GoRouter(
    routes: [
      GoRoute(path: '/', redirect: (_, __) => '/account '),
      GoRoute(
        name: 'account',
        path: '/account',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(name: 'signin', path: '/signin', builder: (context, state) => const LoginPage()),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final appBloc = context.read<AppBloc>();
      if (appBloc.state.status == AppStatus.unauthenticated) {
        return '/signin';
      } else {
        return null;
      }
    },
  );

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
