import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/app_state.dart';
import 'screens/home_screen_new.dart';
import 'screens/loading_screen_new.dart';
import 'screens/result_screen_new.dart';
import 'screens/chat_screen_new.dart';
import 'screens/premium_screen_new.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp(
        title: 'SoulType',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          fontFamily: 'Poppins',
          primaryColor: const Color(0xFF7C3AED),
          scaffoldBackgroundColor: const Color(0xFF1a0533),
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.w300,
              letterSpacing: 0.5,
            ),
            displayMedium: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w300,
              letterSpacing: 0.3,
            ),
            displaySmall: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w300,
            ),
            headlineLarge: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w600,
            ),
            headlineMedium: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
            titleLarge: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            bodyLarge: TextStyle(
              color: Colors.white70,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
            bodyMedium: TextStyle(
              color: Colors.white60,
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
            labelSmall: TextStyle(
              color: Colors.white54,
              fontSize: 11,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5,
            ),
          ),
        ),
        home: const HomeScreenNew(),
        routes: {
          '/home': (context) => const HomeScreenNew(),
          '/loading': (context) => const LoadingScreenNew(),
          '/result': (context) => const ResultScreenNew(),
          '/chat': (context) => const ChatScreenNew(),
          '/premium': (context) => const PremiumScreenNew(),
        },
      ),
    );
  }
}
