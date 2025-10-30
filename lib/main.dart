import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/ai_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/ai_chat_screen.dart';

void main() {
  runApp(const GarizoneApp());
}

class GarizoneApp extends StatelessWidget {
  const GarizoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AIProvider()), // ✅ Added here
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Garizone',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Roboto',
        ),
        home: const SplashScreen(),
        routes: {
          '/login': (_) => const LoginScreen(),
          '/register': (_) => const RegisterScreen(),
          '/home': (_) => const HomeScreen(),
          '/ai_chat': (_) => const AIChatScreen(), // ✅ Added route
        },
      ),
    );
  }
}
