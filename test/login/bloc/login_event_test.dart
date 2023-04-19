// ignore_for_file: prefer_const_constructors
import 'package:flutter_supabase_template/login/bloc/login_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const email = 'test@gmail.com';
  const password = '123123123';

  group('LoginEvent', () {
    test('supports value comparisons', () {
      expect(
        LoginEvent(),
        LoginEvent(),
      );
    });

    group('LoginEmailChanged', () {
      test('supports value comparisons', () {
        expect(
          LoginEmailChanged('test@gmail.com'),
          LoginEmailChanged('test@gmail.com'),
        );
        expect(
          LoginEmailChanged(''),
          isNot(LoginEmailChanged('test@gmail.com')),
        );
      });
    });

    group('LoginSubmitted', () {
      test('supports value comparisons', () {
        expect(
          LoginSubmitted(email: email, password: password),
          LoginSubmitted(email: email, password: password),
        );
      });
    });
  });
}
