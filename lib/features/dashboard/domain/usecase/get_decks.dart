import '../entities/deck.dart';
import '../repository/deck_repository.dart';

class GetDecks {
  final DeckRepository repository;

  GetDecks(this.repository);

  Future<List<Deck>> call() async {
    return await repository.getDecks();
  }
}