import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/router/routes.dart';
import '../providers/study_provider.dart';
import '../widgets/flashcard_widget.dart';

class StudyScreen extends StatefulWidget {
  final String deckId;
  const StudyScreen({super.key, required this.deckId});

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  bool _showAnswerButtons = false;

  void onCardFlipped() {
    setState(() {
      _showAnswerButtons = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final studyProvider = context.watch<StudyProvider>();

    if (studyProvider.isSessionFinished) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.goNamed(
          AppRoutes.results,
          pathParameters: {'id': widget.deckId},
        );
      });
      return const Scaffold(body: Center(child: Text("Finalizando sesión...")));
    }

    final progress = (studyProvider.currentIndex + 1) / studyProvider.totalCards;

    return Scaffold(
      appBar: AppBar(
        title: Text(studyProvider.deck.title),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[300],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Tarjeta ${studyProvider.currentIndex + 1} de ${studyProvider.totalCards}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FlashcardWidget(
                question: studyProvider.currentCard.question,
                answer: studyProvider.currentCard.answer,
                onFlip: onCardFlipped,
              ),
            ),
            const SizedBox(height: 20),
            if (_showAnswerButtons)
              _buildAnswerButtons(context, studyProvider)
            else
              _buildInstruction(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInstruction(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Center(
        child: Text(
          'Toca la tarjeta para ver la respuesta',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildAnswerButtons(BuildContext context, StudyProvider provider) {
    return SizedBox(
      height: 120,
      child: Column(
        children: [
          Text(
            '¿La recordaste correctamente?',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.close),
                  label: const Text('Incorrecto'),
                  onPressed: () {
                    setState(() => _showAnswerButtons = false);
                    provider.answerCard(false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade400,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.check),
                  label: const Text('Correcto'),
                  onPressed: () {
                    setState(() => _showAnswerButtons = false);
                    provider.answerCard(true);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade500,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}