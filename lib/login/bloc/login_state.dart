part of 'login_bloc.dart';

enum LoginScreen { landingPage, signUp, signIn }

class LoginState extends Equatable {
  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.valid = false,
    this.loginScreen = LoginScreen.landingPage,
  });

  final Email email;
  final Password password;
  final FormzSubmissionStatus status;
  final bool valid;
  final LoginScreen loginScreen;

  @override
  List<Object> get props => [email, password, status, valid, loginScreen];

  LoginState copyWith({
    Email? email,
    Password? password,
    FormzSubmissionStatus? status,
    bool? valid,
    LoginScreen? loginScreen,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      valid: valid ?? this.valid,
      loginScreen: loginScreen ?? this.loginScreen,
    );
  }
}
