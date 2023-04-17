import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_supabase_template/app/bloc/app_bloc.dart';
import 'package:flutter_supabase_template/app/routes/routes.dart';
import 'package:flutter_supabase_template/l10n/l10n.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  void initState() {
    super.initState();
    final authClient = Supabase.instance.client.auth;
    authClient.onAuthStateChange.listen((authState) {
      switch(authState.event) {
        case AuthChangeEvent.signedOut:
          if (mounted) {
            context.read<AppBloc>().add(AppUnauthenticated());
          }
          break;
        case AuthChangeEvent.signedIn:
          if (mounted) {
            context.read<AppBloc>().add(const AppAuthenticated());
          }
          break;
        default:
          break;
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}
