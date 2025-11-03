import 'package:flutter/foundation.dart';
import '../../../deck_detail/domain/entities/deck_detail.dart';
import '../../../deck_detail/domain/entities/flashcard.dart';

class StudyProvider with ChangeNotifier {
  late DeckDetail _deck;
  late List<Flashcard> _flashcards;
  int _currentIndex = 0;
  int _correctAnswers = 0;
  int _incorrectAnswers = 0;

  DeckDetail get deck => _deck;
  int get currentIndex => _currentIndex;
  int get correctAnswers => _correctAnswers;
  int get incorrectAnswers => _incorrectAnswers;
  int get totalCards => _flashcards.length;
  bool get isSessionFinished => _currentIndex >= _flashcards.length;
  Flashcard get currentCard => _flashcards[_currentIndex];

  void startSession(DeckDetail deck) {
    _deck = deck;
    _flashcards = List.from(deck.flashcards)..shuffle();
    _currentIndex = 0;
    _correctAnswers = 0;
    _incorrectAnswers = 0;
    notifyListeners();
  }

  void answerCard(bool isCorrect) {
    if (isSessionFinished) return;

    if (isCorrect) {
      _correctAnswers++;
    } else {
      _incorrectAnswers++;
    }

    _goToNextCard();
  }

  void _goToNextCard() {
    _currentIndex++;
    notifyListeners();
  }
}