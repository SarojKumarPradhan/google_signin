import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_signin/controllers/user_controller.dart';
import 'package:google_signin/firebase_options.dart';
import 'package:google_signin/home_screen.dart';
import 'package:google_signin/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'glogin-61023',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Colors.yellow,
      ),
      home: UserController().user != null
          ? const HomeScreen()
          : const LogInScreen(),
    );
  }
}
