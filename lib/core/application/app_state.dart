import 'package:flutter/foundation.dart';

enum AuthStatus { authenticated, unauthenticated }

class AppState extends ChangeNotifier {
  AuthStatus _authStatus = AuthStatus.unauthenticated;
  AuthStatus get authStatus => _authStatus;

  Future<void> checkAuthStatus() async {
    _authStatus = AuthStatus.unauthenticated;
    notifyListeners();
  }

  void login() {
    _authStatus = AuthStatus.authenticated;
    notifyListeners();
  }

  void logout() {
    _authStatus = AuthStatus.unauthenticated;
    notifyListeners();
  }
}
