import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'services/app_config_service.dart';
import 'services/xtream_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppConfigService()),
        ChangeNotifierProvider(create: (_) => XtreamService()),
      ],
      child: const TopTVApp(),
    ),
  );
}

class TopTVApp extends StatelessWidget {
  const TopTVApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TopTV Player',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1F1F1F),
          elevation: 0,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}