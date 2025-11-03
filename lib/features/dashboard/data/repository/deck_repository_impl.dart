import '../../domain/entities/deck.dart';
import '../../domain/repository/deck_repository.dart';
import '../datasource/deck_remote_datasource.dart';

class DeckRepositoryImpl implements DeckRepository {
  final DeckRemoteDatasource remoteDatasource;

  DeckRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<Deck>> getDecks() async {
    return await remoteDatasource.fetchDecks();
  }
}