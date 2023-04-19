import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_supabase_template/login/bloc/login_bloc.dart';
import 'package:formz/formz.dart';

class LandingForm extends StatelessWidget {
  const LandingForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _EmailInput(),
        SizedBox(height: 18),
        _ContinueWithEmailButton(),
      ],
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LoginBloc>().state;
    final inProgress = state.status == FormzSubmissionStatus.inProgress;
    return TextFormField(
      key: const Key('loginView_emailInput_textField'),
      readOnly: inProgress,
      initialValue: state.email.value,
      onChanged: (email) {
        context.read<LoginBloc>().add(LoginEmailChanged(email));
      },
      decoration: const InputDecoration(labelText: 'Email'),
    );
  }
}

class _ContinueWithEmailButton extends StatelessWidget {
  const _ContinueWithEmailButton();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LoginBloc>().state;

    return ElevatedButton(
      key: const Key('loginView_continueWithEmail_button'),
      onPressed: state.status.isInProgress || !state.valid
          ? null
          : () => context
              .read<LoginBloc>()
              .add(ContinuedWithEmail(email: state.email.value)),
      child: Text(
        state.status.isInProgress ? 'Loading' : 'Continue',
      ),
    );
  }
}
