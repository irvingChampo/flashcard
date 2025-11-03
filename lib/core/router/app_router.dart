import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flashcard/features/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:flashcard/features/deck_detail/presentation/pages/deck_detail_screen.dart';
import 'package:flashcard/features/study_session/presentation/pages/study_screen.dart';
import 'package:flashcard/features/study_session/presentation/pages/results_screen.dart';
import 'package:flashcard/features/auth/presentation/pages/login_screen.dart';
import '../application/app_state.dart';
import 'routes.dart';

class AppRouter {
  final AppState appState;

  AppRouter({required this.appState});

  late final GoRouter router = GoRouter(
    initialLocation: AppRoutes.loginPath,
    refreshListenable: appState,
    routes: [
      GoRoute(
        path: AppRoutes.loginPath,
        name: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.dashboardPath,
        name: AppRoutes.dashboard,
        builder: (context, state) => const DashboardScreen(),
        routes: [
          GoRoute(
            path: AppRoutes.deckDetailPath,
            name: AppRoutes.deckDetail,
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return DeckDetailScreen(deckId: id);
            },
            routes: [
              GoRoute(
                path: AppRoutes.studyPath,
                name: AppRoutes.study,
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return StudyScreen(deckId: id);
                },
                routes: [
                  GoRoute(
                    path: AppRoutes.resultsPath,
                    name: AppRoutes.results,
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return ResultsScreen(deckId: id);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final authStatus = appState.authStatus;
      final loggingIn = state.matchedLocation == AppRoutes.loginPath;

      if (authStatus == AuthStatus.unauthenticated) {
        return loggingIn ? null : AppRoutes.loginPath;
      }

      if (authStatus == AuthStatus.authenticated && loggingIn) {
        return AppRoutes.dashboardPath;
      }

      return null;
    },
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Ruta no encontrada: ${state.error}'))),
  );
}
