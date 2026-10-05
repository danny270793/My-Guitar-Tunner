import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'pages/auto_tuner_page.dart';
import 'pages/home_page.dart';
import 'pages/legal_info_page.dart';
import 'pages/manual_tuner_page.dart';
import 'pages/settings_page.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

/// Builds the app router. There is no sign-in, so the app opens on the mode picker.
GoRouter createRouter() {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        pageBuilder: (context, state) => _page(state, const HomePage()),
        routes: [
          GoRoute(
            path: 'auto',
            name: 'auto',
            pageBuilder: (context, state) =>
                _page(state, const AutoTunerPage()),
          ),
          GoRoute(
            path: 'manual',
            name: 'manual',
            pageBuilder: (context, state) =>
                _page(state, const ManualTunerPage()),
          ),
        ],
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        pageBuilder: (context, state) => _page(state, const SettingsPage()),
        routes: [
          GoRoute(
            path: 'about',
            name: 'about',
            pageBuilder: (context, state) =>
                _page(state, const LegalInfoPage(kind: LegalInfoKind.about)),
          ),
          GoRoute(
            path: 'privacy',
            name: 'privacy',
            pageBuilder: (context, state) =>
                _page(state, const LegalInfoPage(kind: LegalInfoKind.privacy)),
          ),
          GoRoute(
            path: 'terms',
            name: 'terms',
            pageBuilder: (context, state) =>
                _page(state, const LegalInfoPage(kind: LegalInfoKind.terms)),
          ),
        ],
      ),
    ],
  );
}

/// Routes declare their pages explicitly because go_router only falls back to
/// transition-less pages otherwise, which also drops the iOS swipe-back
/// gesture. [MaterialPage] restores the platform transition and the gesture.
MaterialPage<void> _page(GoRouterState state, Widget child) =>
    MaterialPage<void>(key: state.pageKey, name: state.name, child: child);
