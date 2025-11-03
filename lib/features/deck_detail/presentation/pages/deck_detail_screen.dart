import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/router/routes.dart';
import '../../../study_session/presentation/providers/study_provider.dart';
import '../providers/deck_detail_provider.dart';

class DeckDetailScreen extends StatefulWidget {
  final String deckId;
  const DeckDetailScreen({super.key, required this.deckId});

  @override
  State<DeckDetailScreen> createState() => _DeckDetailScreenState();
}

class _DeckDetailScreenState extends State<DeckDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DeckDetailProvider>(context, listen: false)
          .fetchDeckDetails(widget.deckId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DeckDetailProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(provider.deck?.title ?? 'Cargando...'),
      ),
      body: _buildBody(provider),
    );
  }

  Widget _buildBody(DeckDetailProvider provider) {
    switch (provider.state) {
      case DeckDetailState.loading:
      case DeckDetailState.initial:
        return const Center(child: CircularProgressIndicator());
      case DeckDetailState.error:
        return Center(
          child: Text('Error: ${provider.errorMessage}'),
        );
      case DeckDetailState.loaded:
        final deck = provider.deck!;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                deck.title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                deck.description,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'Número de tarjetas: ${deck.flashcards.length}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Spacer(),
              ElevatedButton.icon(
                icon: const Icon(Icons.play_arrow),
                label: const Text('Empezar a Estudiar'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: Theme.of(context).textTheme.titleMedium,
                ),
                onPressed: deck.flashcards.isEmpty
                    ? null
                    : () {
                  context.read<StudyProvider>().startSession(deck);
                  context.goNamed(
                    AppRoutes.study,
                    pathParameters: {'id': deck.id},
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
    }
  }
}