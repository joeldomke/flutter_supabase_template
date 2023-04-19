import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_supabase_template/login/bloc/login_bloc.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<LoginBloc>().add(const NavigatedBackToLandingPage());
        return false;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 32,
        ),
        child: Column(
          children: const [
            _PasswordInput(),
            SizedBox(height: 28),
            _SendEmailButton(),
          ],
        ),
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    final isInProgress = context.select(
      (LoginBloc bloc) => bloc.state.status == FormzSubmissionStatus.inProgress,
    );
    return TextFormField(
      key: const Key('loginView_password_Input_textField'),
      readOnly: isInProgress,
      onChanged: (password) {
        context.read<LoginBloc>().add(LoginPasswordChanged(password));
      },
      decoration: const InputDecoration(labelText: 'Password'),
    );
  }
}

class _SendEmailButton extends StatelessWidget {
  const _SendEmailButton();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LoginBloc>().state;

    return ElevatedButton(
      key: const Key('loginView_sendEmail_button'),
      onPressed: state.status.isInProgress || !state.valid
          ? null
          : () => context.read<LoginBloc>().add(
                LoginSubmitted(
                  email: state.email.value,
                  password: state.password.value,
                ),
              ),
      child: Text(
        state.status.isInProgress ? 'Loading' : 'Log In',
      ),
    );
  }
}
