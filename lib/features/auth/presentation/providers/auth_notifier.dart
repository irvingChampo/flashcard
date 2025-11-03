import 'package:flutter/foundation.dart';
import '../../../../core/application/app_state.dart';

class AuthNotifier extends ChangeNotifier {
  final AppState _appState;
  AuthNotifier(this._appState);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> login() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;
    _appState.login();
    notifyListeners();
  }

  void logout() {
    _appState.logout();
  }
}