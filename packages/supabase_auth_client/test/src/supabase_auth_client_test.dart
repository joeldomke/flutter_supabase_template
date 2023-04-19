// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_auth_client/supabase_auth_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockGoTrueClient extends Mock implements GoTrueClient {}

void main() {
  late SupabaseAuthClient supabaseAuthClient;
  late GoTrueClient goTrueClient;

  const email = 'test@test.com';

  setUp(() {
    goTrueClient = MockGoTrueClient();
    supabaseAuthClient = SupabaseAuthClient(
      auth: goTrueClient,
    );
  });

  group('SupabaseAuthClient', () {
    test('can be instantiated', () {
      expect(
        SupabaseAuthClient(
          auth: goTrueClient,
        ),
        isNotNull,
      );
    });

    group('SignIn', () {
      test('with an email completes', () async {
        when(
          () => goTrueClient.signInWithOtp(
            email: any(named: 'email'),
            emailRedirectTo: any(named: 'emailRedirectTo'),
          ),
        ).thenAnswer(
          (_) async => Future.value(),
        );

        expect(
          supabaseAuthClient.signInWithOtp(email: email, isWeb: false),
          completes,
        );
      });

      test('with an email throw SupabaseSignInFailure', () async {
        when(
          () => goTrueClient.signInWithOtp(
            email: any(named: 'email'),
            emailRedirectTo: any(named: 'emailRedirectTo'),
          ),
        ).thenThrow(Exception('oops'));

        expect(
          supabaseAuthClient.signInWithOtp(email: email, isWeb: false),
          throwsA(isA<SupabaseSignInFailure>()),
        );
      });
    });

    group('SignOut', () {
      test('on completes', () async {
        when(() => goTrueClient.signOut()).thenAnswer(
          (_) async {},
        );
        await supabaseAuthClient.signOut();
        expect(
          supabaseAuthClient.signOut(),
          completes,
        );
      });

      test('throw SupabaseSignOutFailure', () async {
        when(
          () => goTrueClient.signOut(),
        ).thenThrow(Exception('oops'));

        expect(
          supabaseAuthClient.signOut(),
          throwsA(isA<SupabaseSignOutFailure>()),
        );
      });
    });
  });
}
