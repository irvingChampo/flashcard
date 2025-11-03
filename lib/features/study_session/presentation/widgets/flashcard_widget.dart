import 'dart:math';
import 'package:flutter/material.dart';
class FlashcardWidget extends StatefulWidget {
  final String question;
  final String answer;
  final VoidCallback onFlip;
  const FlashcardWidget({
    super.key,
    required this.question,
    required this.answer,
    required this.onFlip,
  });
  @override
  State<FlashcardWidget> createState() => _FlashcardWidgetState();
}
class _FlashcardWidgetState extends State<FlashcardWidget> {
  bool _isFlipped = false;
  void _flipCard() {
    setState(() {
      _isFlipped = !_isFlipped;
    });
    widget.onFlip();
  }
  @override
  void didUpdateWidget(covariant FlashcardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.question != oldWidget.question) {
      setState(() {
        _isFlipped = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final cardContent = _isFlipped ? widget.answer : widget.question;
    final cardSide = _isFlipped ? 'Respuesta' : 'Pregunta';

    return GestureDetector(
      onTap: _flipCard,
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: _isFlipped ? pi : 0),
        duration: const Duration(milliseconds: 500),
        builder: (context, double value, child) {
          final isUnderHalfway = value < (pi / 2);
          final transform = Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(value);

          return Transform(
            transform: transform,
            alignment: Alignment.center,
            child: isUnderHalfway
                ? _buildCardSide(context, widget.question, 'Pregunta')
                : Transform(
              transform: Matrix4.identity()..rotateY(pi), // Des-espejar
              alignment: Alignment.center,
              child: _buildCardSide(context, widget.answer, 'Respuesta'),
            ),
          );
        },
      ),
    );
  }
  Widget _buildCardSide(BuildContext context, String text, String side) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(24.0),
        width: double.infinity,
        height: 300,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              side,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
            const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}