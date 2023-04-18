import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(UserRepository userRepository)
      : _userRepository = userRepository,
        super(const AppState()) {
    on<AppAuthenticated>(_onAppAuthenticated);
    on<AppUnauthenticated>(_onLogoutRequest);

    _authSubscription = _userRepository.isAuthenticated.listen((isAuthenticated) {
      if (isAuthenticated) {
        add(const AppAuthenticated());
      } else {
        add(AppUnauthenticated());
      }
    });
  }

  @override
  Future<void> close() async {
    await _authSubscription.cancel();
    await super.close();
  }

  final UserRepository _userRepository;
  late final StreamSubscription<bool> _authSubscription;

  Future<void> _onAppAuthenticated(
    AppAuthenticated event,
    Emitter<AppState> emit,
  ) async {
    emit(state.copyWith(status: AppStatus.authenticated));
  }

  Future<void> _onLogoutRequest(
    AppUnauthenticated event,
    Emitter<AppState> emit,
  ) async {
    emit(state.copyWith(status: AppStatus.unauthenticated));
  }
}
