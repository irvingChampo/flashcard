import '../../domain/entities/flashcard.dart';

class FlashcardModel extends Flashcard {
  FlashcardModel({required String question, required String answer})
      : super(question: question, answer: answer);

  factory FlashcardModel.fromJson(Map<String, dynamic> json) {
    return FlashcardModel(
      question: json['question'],
      answer: json['answer'],
    );
  }
}