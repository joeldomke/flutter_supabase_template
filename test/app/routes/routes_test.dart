import 'package:flutter/material.dart';
import 'package:flutter_supabase_template/account/account.dart';
import 'package:flutter_supabase_template/app/app.dart';
import 'package:flutter_supabase_template/app/routes/routes.dart';
import 'package:flutter_supabase_template/login/login.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('onGenerateAppViewPages', () {
    test('returns [AccountPage] when authenticated', () {
      expect(
        onGenerateAppViewPages(AppStatus.authenticated, []),
        [
          isA<MaterialPage<void>>().having(
            (p) => p.child,
            'child',
            isA<AccountPage>(),
          )
        ],
      );
    });

    test('returns [LoginPage] when unauthenticated', () {
      expect(
        onGenerateAppViewPages(AppStatus.unauthenticated, []),
        [
          isA<MaterialPage<void>>().having(
            (p) => p.child,
            'child',
            isA<LoginPage>(),
          )
        ],
      );
    });
  });
}
