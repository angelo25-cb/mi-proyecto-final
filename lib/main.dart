import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dao/mock_dao_factory.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const SmartBreakApp());
}

class SmartBreakApp extends StatelessWidget {
  const SmartBreakApp({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Provider(
      create: (_) => MockDAOFactory(),
=======
    return MultiProvider(
      providers: [
        Provider<MockDAOFactory>(
          create: (_) => MockDAOFactory(),
        ),
      ],
>>>>>>> main
      child: MaterialApp(
        title: 'Smart Break',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
<<<<<<< HEAD
            seedColor: const Color(0xFF1976D2),
=======
            seedColor: const Color(0xFFFF772D), 
>>>>>>> main
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
<<<<<<< HEAD
            backgroundColor: Color(0xFF1976D2),
=======
            backgroundColor: Color(0xFFFF772D),
>>>>>>> main
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
<<<<<<< HEAD
              backgroundColor: const Color(0xFF1976D2),
=======
              backgroundColor: const Color(0xFFFF772D),
>>>>>>> main
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          cardTheme: CardThemeData(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
        home: const WelcomeScreen(),
      ),
    );
  }
}
