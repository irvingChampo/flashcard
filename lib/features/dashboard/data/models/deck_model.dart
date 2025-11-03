import '../../domain/entities/deck.dart';

class DeckModel extends Deck {
  DeckModel({
    required String id,
    required String title,
    required String description,
    required String category,
    required String color,
    required int cardCount,
  }) : super(
    id: id,
    title: title,
    description: description,
    category: category,
    color: color,
    cardCount: cardCount,
  );

  factory DeckModel.fromJson(Map<String, dynamic> json) {
    return DeckModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      color: json['color'],
      cardCount: json['cardCount'],
    );
  }
}