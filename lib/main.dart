import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'core/application/app_state.dart';
import 'features/auth/presentation/providers/auth_notifier.dart';
import 'features/dashboard/data/datasource/deck_remote_datasource.dart';
import 'features/dashboard/data/repository/deck_repository_impl.dart';
import 'features/dashboard/domain/usecase/get_decks.dart';
import 'features/dashboard/presentation/providers/dashboard_provider.dart';
import 'features/deck_detail/data/datasource/deck_detail_remote_datasource.dart';
import 'features/deck_detail/data/repository/deck_detail_repository_impl.dart';
import 'features/deck_detail/domain/usecase/get_deck_details.dart';
import 'features/deck_detail/presentation/providers/deck_detail_provider.dart';
import 'features/study_session/presentation/providers/study_provider.dart';
import 'myapp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final appState = AppState();
  appState.checkAuthStatus();

  // Dependency Injection Manual
  final deckRemoteDatasource = DeckRemoteDatasourceImpl();
  final deckRepository = DeckRepositoryImpl(remoteDatasource: deckRemoteDatasource);
  final getDecksUseCase = GetDecks(deckRepository);

  final deckDetailRemoteDatasource = DeckDetailRemoteDatasourceImpl();
  final deckDetailRepository = DeckDetailRepositoryImpl(remoteDatasource: deckDetailRemoteDatasource);
  final getDeckDetailsUseCase = GetDeckDetails(deckDetailRepository);


  runApp(
    DevicePreview(
      enabled: kDebugMode,
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: appState),
          ChangeNotifierProvider(create: (_) => appState),
          ChangeNotifierProvider(create: (_) => AuthNotifier(appState)),
          ChangeNotifierProvider(create: (_) => DashboardProvider(getDecks: getDecksUseCase)),
          ChangeNotifierProvider(create: (_) => DeckDetailProvider(getDeckDetails: getDeckDetailsUseCase)),
          ChangeNotifierProvider(create: (_) => StudyProvider()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}