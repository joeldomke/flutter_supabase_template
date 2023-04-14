// ignore_for_file: prefer_const_constructors, must_be_immutable
import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_repository/user_repository.dart';
import 'package:very_good_supabase/app/app.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  group('AppBloc', () {
    late UserRepository userRepository;
    late StreamController<bool> isAuthenticatedStreamController;

    setUp(() {
      userRepository = MockUserRepository();
      isAuthenticatedStreamController = StreamController();
      when(
        () => userRepository.isAuthenticated,
      ).thenAnswer((_) => isAuthenticatedStreamController.stream);
    });

    test('initial state is unauthenticated', () {
      expect(
        AppBloc(userRepository).state,
        AppState(),
      );
    });

    group('AppLogoutRequested', () {
      blocTest<AppBloc, AppState>(
        'emits [AppStatus.unauthenticated] when '
        'state is unauthenticated',
        build: () => AppBloc(userRepository),
        act: (bloc) => bloc.add(AppUnauthenticated()),
        expect: () => <AppState>[AppState()],
      );
    });

    group('AppAuthenticated', () {
      blocTest<AppBloc, AppState>(
        'emits [AppStatus.authenticated] when '
        'state is authenticated',
        build: () => AppBloc(userRepository),
        act: (bloc) => bloc.add(AppAuthenticated()),
        expect: () => <AppState>[
          AppState(
            status: AppStatus.authenticated,
          )
        ],
      );
    });

    group('when UserRepository state changes to', () {
      group('true', () {
        blocTest<AppBloc, AppState>(
          'AppBloc emits [AppStatus.authenticated]',
          build: () => AppBloc(userRepository),
          act: (_) => isAuthenticatedStreamController.sink.add(true),
          expect: () => <AppState>[
            AppState(status: AppStatus.authenticated),
          ],
        );
      });

      group('false', () {
        blocTest<AppBloc, AppState>(
          'AppBloc emits [AppStatus.authenticated]',
          build: () => AppBloc(userRepository),
          act: (_) => isAuthenticatedStreamController.sink.add(false),
          expect: () => <AppState>[AppState()],
        );
      });
    });
  });
}
