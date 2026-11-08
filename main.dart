import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // ফায়ারবেস কোর প্যাকেজ इम्पोर्ट করা
import 'loginpage.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // ফায়ারবেস ইনিশিয়ালাইজ করার জন্য এটি জরুরি
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      routes: {
        '/home': (context) => const HomePage(),
      },
    );
  }
}