import 'package:email_launcher/email_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_supabase_template/login/login.dart';
import 'package:flutter_supabase_template/login/view/landing_form.dart';
import 'package:flutter_supabase_template/login/view/login_form.dart';
import 'package:flutter_supabase_template/login/view/signup_form.dart';
import 'package:formz/formz.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LoginBloc>().state;
    return ListView(
      padding: const EdgeInsets.symmetric(
        vertical: 50,
        horizontal: 32,
      ),
      children: [
        const _Header(),
        const SizedBox(height: 18),
        _buildForm(state.loginScreen)
      ],
    );
  }

  Widget _buildForm(LoginScreen loginScreen) {
    switch (loginScreen) {
      case LoginScreen.landingPage:
        return const LandingForm();
      case LoginScreen.signIn:
        return const LoginForm();
      case LoginScreen.signUp:
        return const SignupForm();
    }
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LoginBloc>().state;

    return Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Text(
          _getHeaderText(state),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      );
  }

  String _getHeaderText(LoginState state) {
    switch (state.loginScreen) {
      case LoginScreen.landingPage:
        return 'Welcome!';
      case LoginScreen.signIn:
        return 'Welcome back!';
      case LoginScreen.signUp:
        return 'Sign Up';
    }
  }
}

@visibleForTesting
class OpenEmailButton extends StatelessWidget {
  OpenEmailButton({
    EmailLauncher? emailLauncher,
    super.key,
  }) : _emailLauncher = emailLauncher ?? EmailLauncher();

  final EmailLauncher _emailLauncher;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LoginBloc>().state;

    return OutlinedButton(
      key: const Key('loginView_openEmail_button'),
      onPressed: state.status.isInProgress || !state.valid
          ? null
          : _emailLauncher.launchEmailApp,
      child: const Text('Open Email App'),
    );
  }
}
