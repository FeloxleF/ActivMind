// import 'package:flutter/material.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
import 'package:activmind_app/main.dart';
import 'package:http/http.dart' as http;
import 'package:activmind_app/Screens/Calendar.dart';
import 'package:activmind_app/Screens/HomeForm.dart';
import 'package:activmind_app/Screens/tasklist.dart';
import 'package:activmind_app/common/appandfooterbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  
  Future<void> signOut() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    const String apiUrl = 'http://10.0.2.2:8000/auth/logout/'; 

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $token',
        
      },
      
    );
    if (response.statusCode == 200) {
      // Task updated successfully
      print('user loged out successfully');
      SharedPreferences.getInstance().then((prefs) {
      prefs.remove('token');
      Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MyApp()),
    );
    });
    } else {
      // Task update failed
      print('Failed to logedout. Status code: ${response.statusCode}');
    }

    

    // Example: Navigate back to the login screen (replace 'LoginScreen()' with your actual login screen)
    
  }
  
  int _currentIndex = 4;

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TaskList()),
      );
      return; // Return here to prevent further execution
    }
    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Calendar()),
      );
      return; // Return here to prevent further execution
    }
    if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeForm()),
      );
      return; // Return here to prevent further execution
    }

    if (index == 4) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProfilePage()),
      );
      return; // Return here to prevent further execution
    }

    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
     final Widget currentPage;
    switch (_currentIndex) {
      case 0:
        currentPage = const TaskList();
        break;
      case 1:
        currentPage = const Calendar();
        break;
      case 2:
        currentPage = const HomeForm();
        break;
      case 4:
        currentPage = const ProfilePage();
        break;
      default:
        currentPage = const TaskList(); // Default to the first page
    }
    return Scaffold(
      appBar: const MyAppBar(), 
      
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
            signOut(); // Call signOut function when the button is pressed
          },
              child: const Text('Se déconnecter'),
            ),
          ),
          const SizedBox(height: 20), // Add some space between button and footer
          const Text('Welcome to ActivMind'),
        ],
      ),
      
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ), 
    );
  }
}
