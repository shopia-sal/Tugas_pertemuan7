import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/login_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',

      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFe94560),
          brightness: Brightness.dark,
        ),

        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),

        scaffoldBackgroundColor: const Color(0xFF1a1a2e),
      ),

      home: const LoginScreen(),
    );
  }
}
