import 'package:flashcard/features/study_session/presentation/pages/study_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flashcard/features/deck_detail/presentation/pages/deck_detail_screen.dart';
import 'package:flashcard/features/study_session/presentation/pages/results_screen.dart';

import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/auth/presentation/pages/splash_screen.dart';
import '../../features/dashboard/presentation/pages/dashboard_screen.dart';
import '../application/app_state.dart';
import 'routes.dart';

class AppRouter {
  final AppState appState;

  AppRouter({required this.appState});

  late final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splashPath,
    refreshListenable: appState,
    routes: [
      GoRoute(
        path: AppRoutes.splashPath,
        name: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
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
                      )
                    ]
                ),
              ]
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final authStatus = appState.authStatus;
      final isAuthRoute = state.matchedLocation == AppRoutes.loginPath;
      final isSplashRoute = state.matchedLocation == AppRoutes.splashPath;

      // Si el estado es desconocido, siempre muestra Splash
      if (authStatus == AuthStatus.unknown) {
        return isSplashRoute ? null : AppRoutes.splashPath;
      }

      // Si está autenticado
      if (authStatus == AuthStatus.authenticated) {
        // y trata de ir a login o splash, llévalo a dashboard
        if (isAuthRoute || isSplashRoute) {
          return AppRoutes.dashboardPath;
        }
      }
      // Si NO está autenticado
      else {
        // y no está en login o splash, llévalo a login
        if (!isAuthRoute && !isSplashRoute) {
          return AppRoutes.loginPath;
        }
      }

      // En cualquier otro caso, no redirigir
      return null;
    },
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Ruta no encontrada: ${state.error}'),
      ),
    ),
  );
}