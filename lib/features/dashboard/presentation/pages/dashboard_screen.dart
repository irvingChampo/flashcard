import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/application/app_state.dart';
import '../../../../core/router/routes.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/deck_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DashboardProvider>(context, listen: false).fetchDecks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = context.watch<DashboardProvider>();
    final appState = context.read<AppState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Mazos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => appState.logout(),
            tooltip: 'Cerrar sesión',
          ),
        ],
      ),
      body: _buildBody(dashboardProvider),
    );
  }

  Widget _buildBody(DashboardProvider provider) {
    switch (provider.state) {
      case DashboardState.loading:
      case DashboardState.initial:
        return const Center(child: CircularProgressIndicator());
      case DashboardState.error:
        return Center(
          child: Text('Error al cargar los mazos: ${provider.errorMessage}'),
        );
      case DashboardState.loaded:
        if (provider.decks.isEmpty) {
          return const Center(child: Text('No hay mazos disponibles.'));
        }
        return RefreshIndicator(
          onRefresh: () => provider.fetchDecks(),
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: provider.decks.length,
            itemBuilder: (context, index) {
              final deck = provider.decks[index];
              return DeckCard(
                deck: deck,
                onTap: () {
                  context.goNamed(
                    AppRoutes.deckDetail,
                    pathParameters: {'id': deck.id},
                  );
                },
              );
            },
          ),
        );
    }
  }
}