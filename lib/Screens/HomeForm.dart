import 'package:activmind_app/Screens/Calendar.dart';
import 'package:activmind_app/Screens/locationList.dart';
import 'package:activmind_app/Screens/profilepage.dart';
import 'package:activmind_app/Screens/tasklist.dart';
import 'package:activmind_app/common/appandfooterbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeForm extends StatefulWidget {
  const HomeForm({Key? key}) : super(key: key);

  @override
  State<HomeForm> createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {
  int _currentIndex = 2;

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

    if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LocationList()),
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
      case 3:
        currentPage = const LocationList();
        break;
      case 4:
        currentPage = const ProfilePage();
        break;
      default:
        currentPage = const TaskList(); // Default to the first page
    }
    return Scaffold(
      appBar: const MyAppBar(), // Use MyAppBar for header
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: <Widget>[
          const SizedBox(height: 20),
          Center(
              child: Text(
            "Bienvenue sur Activ'Mind",
            style: GoogleFonts.nunito(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          )),
        ]),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ), // Use MyFooter for footer
    );
  }
}
