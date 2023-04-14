// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';

import 'package:flutter_supabase_template/app/app.dart';
// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_repository/user_repository.dart';

import '../../helpers/helpers.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late UserRepository userRepository;
  late StreamController<bool> isAuthenticatedStreamController;

  group('App', () {
    setUpAll(() async {
      await initializeSupabase();
    });

    setUp(() async {
      userRepository = MockUserRepository();
      isAuthenticatedStreamController = StreamController();
      when(
            () => userRepository.isAuthenticated,
      ).thenAnswer((_) => isAuthenticatedStreamController.stream);
    });

    testWidgets('renders AppView', (tester) async {
      await tester.pumpApp(App(userRepository: userRepository));

      await tester.pump();
      expect(find.byType(AppView), findsOneWidget);
    });
  });
}
