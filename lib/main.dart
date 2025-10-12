import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dao/mock_dao_factory.dart';
import 'screens/welcome_screen.dart';
import 'screens/mapa_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const SmartBreakApp());
}

class SmartBreakApp extends StatelessWidget {
  const SmartBreakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<MockDAOFactory>(
          create: (_) => MockDAOFactory(),
        ),
      ],
      child: MaterialApp(
        title: 'Smart Break',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFFF772D),
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFFF772D),
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF772D),
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

        // 👇 Solo rutas reales, sin pantallas falsas
        initialRoute: '/',
        routes: {
          '/': (context) => const WelcomeScreen(),
          '/mapa': (context) => const MapaScreen(),
          '/perfil': (context) => const UserProfileScreen(),
        },
      ),
    );
  }
}
