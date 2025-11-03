import 'package:flutter/foundation.dart';
import '../../domain/entities/deck.dart';
import '../../domain/usecase/get_decks.dart';

enum DashboardState { initial, loading, loaded, error }

class DashboardProvider with ChangeNotifier {
  final GetDecks getDecks;

  DashboardProvider({required this.getDecks});

  DashboardState _state = DashboardState.initial;
  List<Deck> _decks = [];
  String _errorMessage = '';

  DashboardState get state => _state;
  List<Deck> get decks => _decks;
  String get errorMessage => _errorMessage;

  Future<void> fetchDecks() async {
    _state = DashboardState.loading;
    notifyListeners();

    try {
      _decks = await getDecks();
      _state = DashboardState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _state = DashboardState.error;
    } finally {
      notifyListeners();
    }
  }
}