import 'package:flutter/material.dart';
import '../../domain/entities/deck.dart';

class DeckCard extends StatelessWidget {
  final Deck deck;
  final VoidCallback onTap;

  const DeckCard({super.key, required this.deck, required this.onTap,});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor = Color(int.parse(deck.color));

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: cardColor, width: 2),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                deck.category,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: cardColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                deck.title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                deck.description,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${deck.cardCount} tarjetas',
                    style: theme.textTheme.bodySmall,
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}