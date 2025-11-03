import '../../domain/entities/deck_detail.dart';
import '../../domain/repository/deck_detail_repository.dart';
import '../datasource/deck_detail_remote_datasource.dart';

class DeckDetailRepositoryImpl implements DeckDetailRepository {
  final DeckDetailRemoteDatasource remoteDatasource;

  DeckDetailRepositoryImpl({required this.remoteDatasource});

  @override
  Future<DeckDetail> getDeckDetails(String id) async {
    return await remoteDatasource.fetchDeckDetails(id);
  }
}