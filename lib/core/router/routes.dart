class AppRoutes {
  // Nombres de rutas
  static const String splash = 'splash';
  static const String login = 'login';
  static const String dashboard = 'dashboard';
  static const String deckDetail = 'deckDetail';
  static const String study = 'study';
  static const String results = 'results';

  // Paths de rutas
  static const String splashPath = '/';
  static const String loginPath = '/login';
  static const String dashboardPath = '/dashboard';
  static const String deckDetailPath = 'deck/:id'; // Ruta anidada
  static const String studyPath = 'study'; // Ruta anidada
  static const String resultsPath = 'results'; // Ruta anidada
}