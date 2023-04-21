import 'package:supabase_auth_client/supabase_auth_client.dart';
import 'package:supabase_database_client/supabase_database_client.dart';
import 'package:user_repository/user_repository.dart';

/// {@template user_repository}
/// A package which manages the user domain.
/// {@endtemplate}
class UserRepository {
  /// {@macro user_repository}
  UserRepository({
    required SupabaseAuthClient authClient,
    required SupabaseDatabaseClient databaseClient,
  })  : _authClient = authClient,
        _databaseClient = databaseClient;

  final SupabaseAuthClient _authClient;
  final SupabaseDatabaseClient _databaseClient;

  /// Stream of the current authentication status
  Stream<bool> get isAuthenticated => _authClient.isAuthenticated;

  /// Method to access the current user.
  Future<User?> getUser() async {
    final supabaseUser = await _databaseClient.getUserProfile();
    return supabaseUser?.toUser();
  }

  /// Method to update user information on profiles database.
  Future<void> updateUser({required User user}) {
    return _databaseClient.updateUser(user: user.toSupabaseUser());
  }

  /// Method to do signUp with email
  Future<void> signUpWithPassword({
    required String email,
    required String password,
    required bool isWeb,
  }) async {
    return _authClient.signUpWithPassword(
      email: email,
      password: password,
      isWeb: isWeb,
    );
  }

  /// Method to do signIn with email
  Future<void> signInWithPassword({
    required String email,
    required String password,
  }) async {
    return _authClient.signInWithPassword(
      email: email,
      password: password,
    );
  }

  /// Method to do signIn.
  Future<void> signInWithOtp({
    required String email,
    required bool isWeb,
  }) async {
    return _authClient.signInWithOtp(email: email, isWeb: isWeb);
  }

  /// Method to do signOut.
  Future<void> signOut() async => _authClient.signOut();

  /// Method to check whether email is already used by an account
  Future<bool> checkIfEmailIsUsed(String email) async =>
      _authClient.checkIfEmailIsUsed(email);
}

extension on SupabaseUser {
  User toUser() {
    return User(
      id: id,
      userName: userName,
      companyName: companyName,
    );
  }
}

extension on User {
  SupabaseUser toSupabaseUser() {
    return SupabaseUser(
      id: id,
      userName: userName,
      companyName: companyName,
    );
  }
}
