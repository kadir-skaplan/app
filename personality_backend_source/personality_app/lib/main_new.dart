import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/app_state.dart';
import 'utils/theme.dart';
import 'screens/home_screen_new.dart';
import 'screens/loading_screen_new.dart';
import 'screens/result_screen_new.dart';
import 'screens/chat_screen.dart';
import 'screens/premium_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SoulType',
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: const HomeScreenNew(),
      routes: {
        '/home': (context) => const HomeScreenNew(),
        '/loading': (context) => const LoadingScreenNew(),
        '/result': (context) => const ResultScreenNew(),
        '/chat': (context) => const ChatScreen(),
        '/premium': (context) => const PremiumScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
