import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart/rxdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// {@template supabase_auth_exception}
/// Abstract class to handle the supabase auth exceptions.
/// {@endtemplate}
abstract class SupabaseAuthException implements Exception {
  /// {@macro supabase_auth_exception}
  const SupabaseAuthException(this.error);

  /// The error which was caught.
  final Object error;
}

/// {@template supabase_sign_up_failure}
/// Thrown during the sign up process if a failure occurs.
/// {@endtemplate}
class SupabaseSignUpFailure extends SupabaseAuthException {
  /// {@macro supabase_sign_up_failure}
  const SupabaseSignUpFailure(super.error);
}

/// {@template supabase_sign_in_failure}
/// Thrown during the sign in process if a failure occurs.
/// {@endtemplate}
class SupabaseSignInFailure extends SupabaseAuthException {
  /// {@macro supabase_sign_in_failure}
  const SupabaseSignInFailure(super.error);
}

/// {@template supabase_sign_out_failure}
/// Thrown during the sign out process if a failure occurs.
/// {@endtemplate}
class SupabaseSignOutFailure extends SupabaseAuthException {
  /// {@macro supabase_sign_out_failure}
  const SupabaseSignOutFailure(super.error);
}

/// {@template supabase_auth_client}
/// Supabase auth client
/// {@endtemplate}
class SupabaseAuthClient {
  /// {@macro supabase_auth_client}
  SupabaseAuthClient({
    required SupabaseClient supabaseClient,
  })  : _auth = supabaseClient.auth,
        _supabaseClient = supabaseClient;

  final GoTrueClient _auth;
  final SupabaseClient _supabaseClient;

  /// Stream of the current auth state
  Stream<bool> get isAuthenticated =>
      _auth.onAuthStateChange.map((authStateChange) {
        switch (authStateChange.event) {
          case AuthChangeEvent.signedOut:
            return false;
          case AuthChangeEvent.signedIn:
            return true;
        }
      }).whereNotNull();

  /// Method to do sign up using email and password on supabase
  Future<void> signUpWithPassword({
    required String email,
    required String password,
    required bool isWeb,
  }) async {
    try {
      await _auth.signUp(
        email: email,
        password: password,
        emailRedirectTo:
            isWeb ? null : 'io.supabase.flutterquickstart://login-callback/',
      );
    } on AuthException catch (error, stackTrace) {
      Error.throwWithStackTrace(SupabaseSignUpFailure(error), stackTrace);
    }
  }

  /// Method to do sign in using email and password on supabase
  Future<void> signInWithPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithPassword(email: email, password: password);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(SupabaseSignInFailure(error), stackTrace);
    }
  }

  /// Method to do sign in on Supabase.
  Future<void> signInWithOtp({
    required String email,
    required bool isWeb,
  }) async {
    try {
      await _auth.signInWithOtp(
        email: email,
        emailRedirectTo:
            isWeb ? null : 'io.supabase.flutterquickstart://login-callback/',
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(SupabaseSignInFailure(error), stackTrace);
    }
  }

  /// Method to do sign out on Supabase.
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(SupabaseSignOutFailure(error), stackTrace);
    }
  }

  /// Method to check whether email is already used by an account
  Future<bool> checkIfEmailIsUsed(String email) async {
    try {
      final doesEmailExist = await _supabaseClient.rpc(
        'does_email_exist',
        params: {'email': email},
      );
      if (doesEmailExist is bool) {
        return doesEmailExist;
      }
      return false;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
