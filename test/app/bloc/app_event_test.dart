// ignore_for_file: prefer_const_constructors, must_be_immutable
import 'package:flutter_supabase_template/app/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppEvent', () {
    group('AppAuthenticated', () {
      test('supports value comparisons', () {
        expect(
          AppAuthenticated(),
          AppAuthenticated(),
        );
      });
    });

    group('AppUnauthenticated', () {
      test('supports value comparisons', () {
        expect(
          AppUnauthenticated(),
          AppUnauthenticated(),
        );
      });
    });
  });
}
