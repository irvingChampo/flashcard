import '../entities/deck_detail.dart';

abstract class DeckDetailRepository {
  Future<DeckDetail> getDeckDetails(String id);
}