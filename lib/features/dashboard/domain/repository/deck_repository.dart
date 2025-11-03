import '../entities/deck.dart';

abstract class DeckRepository {
  Future<List<Deck>> getDecks();
}