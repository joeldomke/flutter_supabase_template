import 'package:formz/formz.dart';

/// Password Form Input Validation Error
enum PasswordValidationError {
  /// Password is invalid (generic validation error)
  invalid
}

/// {@template email}
/// Reusable password form input.
/// {@endtemplate}
class Password extends FormzInput<String, PasswordValidationError> {
  /// {@macro email}
  const Password.pure() : super.pure('');

  /// {@macro email}
  const Password.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String value) {
    return value.length > 6 ? null : PasswordValidationError.invalid;
  }
}
