//import 'package:activmind_app/Screens/inscrire.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'Screens/homeform.dart';
import 'Screens/login_form.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:activmind_app/common/globalvariable.dart';

// import 'Screens/username.dart';
// import 'Screens/inscrire.dart';
// import 'Screens/adresse.dart';
Future<bool> getToken(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

    final response = await http.get(
      Uri.parse("http://10.0.2.2:8000/check_token"),
      headers: <String, String>{
        'Authorization': 'Token $token',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> userData = json.decode(response.body);
      // ignore: use_build_context_synchronously
      var globalVariables = Provider.of<GlobalVariables>(context, listen: false);
      String username = userData['username'];
      globalVariables.setuser(username);
      // print('Username: $username');
      // print( globalVariables.setuser);
      return true;
    } else {
      print('API Error: ${response.statusCode}');
      return false;
    }
}



// void main() {
//   runApp(const MyApp());
// }


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GlobalVariables(), 
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: getToken(context),
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

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:activmind_app/common/globalvariable.dart';
// import 'Screens/homeform.dart';
// import 'Screens/login_form.dart';









// Future<bool> getToken(BuildContext context) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   final token = prefs.getString('token');

//   final response = await http.get(
//     Uri.parse("http://10.0.2.2:8000/check_token"),
//     headers: <String, String>{
//       'Authorization': 'Token $token',
//     },
//   );

//   if (response.statusCode == 200) {
//     Map<String, dynamic> userData = json.decode(response.body);
//     var globalVariables = Provider.of<GlobalVariables>(context, listen: false);
//     String username = userData['username'];
//     print(response.statusCode);
//     globalVariables.setuser(username);
//     print(globalVariables.setuser);
//     return true;
//   } else {
//     return false;
//   }
// }

// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => GlobalVariables(),
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<bool>(
//       future: getToken(context),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const MaterialApp(
//             debugShowCheckedModeBanner: false,
//             home: Scaffold(
//               body: Center(child: CircularProgressIndicator()),
//             ),
//           );
//         } else {
//           if (snapshot.data == true) {
//             return const MaterialApp(
//               debugShowCheckedModeBanner: false,
//               home: HomeForm(),
//             );
//           } else {
//             return const MaterialApp(
//               debugShowCheckedModeBanner: false,
//               home: LoginForm(),
//             );
//           }
//         }
//       },
//     );
//   }
// }

