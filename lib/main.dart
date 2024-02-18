// import 'package:activmind_app/Screens/inscrire.dart';
import 'package:flutter/material.dart';

import 'Screens/login_form.dart';
// import 'Screens/username.dart';
// import 'Screens/inscrire.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ActivMine',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginForm(),
    );
  }
}

