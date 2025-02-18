import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socketio_chat_app/screens/home_screen.dart';
import 'package:socketio_chat_app/mytheme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Mytheme.darkTheme,
      home: HomeScreen(),
    );
  }
}

