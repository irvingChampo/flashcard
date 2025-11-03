import 'package:flutter/foundation.dart';
import '../../domain/entities/deck_detail.dart';
import '../../domain/usecase/get_deck_details.dart';

enum DeckDetailState { initial, loading, loaded, error }

class DeckDetailProvider with ChangeNotifier {
  final GetDeckDetails getDeckDetails;

  DeckDetailProvider({required this.getDeckDetails});

  DeckDetailState _state = DeckDetailState.initial;
  DeckDetail? _deck;
  String _errorMessage = '';

  DeckDetailState get state => _state;
  DeckDetail? get deck => _deck;
  String get errorMessage => _errorMessage;

  Future<void> fetchDeckDetails(String id) async {
    _state = DeckDetailState.loading;
    notifyListeners();

    try {
      _deck = await getDeckDetails(id);
      _state = DeckDetailState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _state = DeckDetailState.error;
    } finally {
      notifyListeners();
    }
  }
}