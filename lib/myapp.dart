// lib/myapp.dart (CORREGIDO)

import 'package:device_preview/device_preview.dart' show DevicePreview;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/application/app_state.dart';
import 'core/router/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Escuchamos el AppState aquí para construir el router
    final appState = Provider.of<AppState>(context, listen: false);

    // final appState = Provider.of<AppState>(context, listen: false); // ESTA LÍNEA YA NO ES NECESARIA
    // appState.checkAuthStatus(); // <<<<----- ELIMINA ESTA LÍNEA

    final appRouter = AppRouter(appState: appState);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter.router,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.light),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
    );
  }
}