import 'flashcard.dart';

class DeckDetail {
  final String id;
  final String title;
  final String description;
  final String category;
  final List<Flashcard> flashcards;

  DeckDetail({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.flashcards,
  });
}