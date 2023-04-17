import 'package:flutter/material.dart';
import 'package:flutter_supabase_template/account/account.dart';
import 'package:flutter_supabase_template/app/app.dart';
import 'package:flutter_supabase_template/login/login.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.unauthenticated:
      return [LoginPage.page()];

    case AppStatus.authenticated:
      return [AccountPage.page()];
  }
}
