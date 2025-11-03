import '../entities/deck_detail.dart';
import '../repository/deck_detail_repository.dart';

class GetDeckDetails {
  final DeckDetailRepository repository;

  GetDeckDetails(this.repository);

  Future<DeckDetail> call(String id) async {
    return await repository.getDeckDetails(id);
  }
}