import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._userRepository) : super(const LoginState()) {
    on<ContinuedWithEmail>(_onContinuedWithEmail);
    on<NavigatedBackToLandingPage>(_onNavigatedBackToLandingPage);
    on<SignupSubmitted>(_onSignUp);
    on<LoginSubmitted>(_onSignIn);
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
  }

  final UserRepository _userRepository;

  Future<void> _onContinuedWithEmail(
    ContinuedWithEmail event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      final exists = await _userRepository.checkIfEmailIsUsed(event.email);
      if (exists) {
        emit(
          state.copyWith(
            loginScreen: LoginScreen.signIn,
            valid: false,
            status: FormzSubmissionStatus.initial,
          ),
        );
      } else {
        emit(
          state.copyWith(
            loginScreen: LoginScreen.signUp,
            valid: false,
            status: FormzSubmissionStatus.initial,
          ),
        );
      }
    } catch (error) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
      addError(error);
    }
  }

  void _onNavigatedBackToLandingPage(
    NavigatedBackToLandingPage event,
    Emitter<LoginState> emit,
  ) {
    emit(
      state.copyWith(
        valid: true,
        password: const Password.pure(),
        loginScreen: LoginScreen.landingPage,
      ),
    );
  }

  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        valid: Formz.validate([email]),
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        valid: Formz.validate([password]),
      ),
    );
  }

  Future<void> _onSignUp(
    SignupSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      await _userRepository.signUpWithPassword(
        email: event.email,
        password: event.password,
        isWeb: event.isWeb,
      );
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (error) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
      addError(error);
    }
  }

  Future<void> _onSignIn(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      await _userRepository.signInWithPassword(
        email: event.email,
        password: event.password,
      );
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (error) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
      addError(error);
    }
  }
}
