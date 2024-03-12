//import 'package:activmind_app/Screens/inscrire.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Screens/homeform.dart';
import 'Screens/login_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'Screens/username.dart';
// import 'Screens/inscrire.dart';
// import 'Screens/adresse.dart';
Future<bool> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

      final response = await http.get(
      Uri.parse("http://10.0.2.2:8000/check_token"),
      headers: <String, String>{
        'Authorization': 'Token $token',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }

  
}



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        } else {
          if (snapshot.data == true) {
            // Token is valid, navigate to home page
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: HomeForm(),
            );
          } else {
            // Token is invalid or not present, navigate to login page
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: LoginForm(),
            );
          }
        }
      },
    );
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'ActivMine',
    //   theme: ThemeData(
        
    //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //     useMaterial3: true,
    //   ),
    //   home: 
      
    //   const LoginForm(),
    // ); //test
  }
}


