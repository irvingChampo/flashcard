import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/router/routes.dart';
import '../providers/study_provider.dart';

class ResultsScreen extends StatelessWidget {
  final String deckId;
  const ResultsScreen({super.key, required this.deckId});

  @override
  Widget build(BuildContext context) {
    final studyProvider = context.read<StudyProvider>();
    final theme = Theme.of(context);

    final total = studyProvider.totalCards;
    final correct = studyProvider.correctAnswers;
    final incorrect = studyProvider.incorrectAnswers;
    final score = total > 0 ? (correct / total * 100).toStringAsFixed(0) : 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '¡Sesión completada!',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              Text(
                '$score%',
                textAlign: TextAlign.center,
                style: theme.textTheme.displayLarge?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Tu Puntuación',
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 48),
              _buildResultRow(
                context,
                icon: Icons.check_circle,
                label: 'Respuestas Correctas',
                value: '$correct',
                color: Colors.green.shade600,
              ),
              const SizedBox(height: 16),
              _buildResultRow(
                context,
                icon: Icons.cancel,
                label: 'Respuestas Incorrectas',
                value: '$incorrect',
                color: Colors.red.shade500,
              ),
              const SizedBox(height: 16),
              _buildResultRow(
                context,
                icon: Icons.functions,
                label: 'Total de Tarjetas',
                value: '$total',
                color: theme.textTheme.bodyLarge?.color,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  context.goNamed(AppRoutes.dashboard);
                },
                child: const Text('Volver a Mis Mazos'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultRow(BuildContext context,
      {required IconData icon,
        required String label,
        required String value,
        Color? color}) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 16),
            Text(label, style: theme.textTheme.titleMedium),
          ],
        ),
        Text(value,
            style: theme.textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }
}