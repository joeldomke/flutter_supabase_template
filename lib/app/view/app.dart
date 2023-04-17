// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_supabase_template/app/bloc/app_bloc.dart';
import 'package:flutter_supabase_template/app/view/app_view.dart';
import 'package:user_repository/user_repository.dart';

class App extends StatelessWidget {
  const App({required this.userRepository, super.key});

  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: userRepository,
      child: BlocProvider(
        create: (context) => AppBloc(userRepository),
        child: const AppView(),
      ),
    );
  }
}
