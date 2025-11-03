import '../../domain/entities/deck_detail.dart';
import 'flashcard_model.dart';

class DeckDetailModel extends DeckDetail {
  DeckDetailModel({
    required String id,
    required String title,
    required String description,
    required String category,
    required List<FlashcardModel> flashcards,
  }) : super(
      id: id,
      title: title,
      description: description,
      category: category,
      flashcards: flashcards);

  factory DeckDetailModel.fromJson(Map<String, dynamic> json) {
    var flashcardsList = json['flashcards'] as List;
    List<FlashcardModel> flashcards =
    flashcardsList.map((i) => FlashcardModel.fromJson(i)).toList();

    return DeckDetailModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      flashcards: flashcards,
    );
  }
}