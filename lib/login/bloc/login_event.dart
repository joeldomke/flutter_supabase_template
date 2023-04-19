part of 'login_bloc.dart';

class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class ContinuedWithEmail extends LoginEvent {
  const ContinuedWithEmail({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class NavigatedBackToLandingPage extends LoginEvent {
  const NavigatedBackToLandingPage();

  @override
  List<Object?> get props => [];
}

class SignupSubmitted extends LoginEvent {
  const SignupSubmitted({
    required this.email,
    required this.password,
    required this.isWeb,
  });

  final String email;
  final String password;
  final bool isWeb;

  @override
  List<Object> get props => [email, password, isWeb];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class LoginEmailChanged extends LoginEvent {
  const LoginEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}


class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}
