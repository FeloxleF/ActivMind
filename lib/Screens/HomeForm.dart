import 'package:activmind_app/Screens/Calendar.dart';
import 'package:activmind_app/Screens/tasklist.dart';
import 'package:activmind_app/common/appandfooterbar.dart';
import 'package:flutter/material.dart';

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
        MaterialPageRoute(builder: (context) => TaskList()),
      );
      return; // Return here to prevent further execution
    }
    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Calendar()),
      );
      return; // Return here to prevent further execution
    }
    if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeForm()),
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
        // currentPage = SettingsPage();
        break;
      default:
        currentPage = const TaskList(); // Default to the first page
    }
    return Scaffold(
      appBar: MyAppBar(), // Use MyAppBar for header
      body: Text('welcom to ActivMind'),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ), // Use MyFooter for footer
    );
  }
}



// import 'package:activmind_app/common/appandfooterbar.dart';
// import 'package:flutter/material.dart';

// class HomeForm extends StatefulWidget {
//   const HomeForm({super.key});

//   @override
//   State<HomeForm> createState() => _HomeFormState();
// }

// class _HomeFormState extends State<HomeForm> {
//   int _selectedIndex = 1;
//   void _onItemTapped(int index) {
//     setState(() {
//       if (index != _selectedIndex) {
//         _selectedIndex = index; 
//       }
      
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MyAppBar(),
//       // AppBar(
//       //   title: const Center(
//       //     child: Text(
//       //       'Activ\'Mind',
//       //       style: TextStyle(
//       //         fontWeight: FontWeight.bold,
//       //         color: Colors.indigoAccent,
//       //         fontSize: 24,
//       //         fontFamily: 'Arial',
//       //       ),
//       //     ),
//       //   ),
//       //   leading: IconButton(
//       //     icon: Icon(Icons.alarm),
//       //     onPressed: () {},
//       //   ),
//       //   actions: <Widget>[
//       //     IconButton(
//       //       icon: Icon(Icons.notifications_none),
//       //       onPressed: () {},
//       //     ),
//       //   ],
//       // ),
//       body: const Center(child: Text('Log in successful')),
//       bottomNavigationBar: MyFooter(
//         selectedIndex: _selectedIndex,
//         onItemTapped: _onItemTapped,
//       ),
//       // bottomNavigationBar: BottomNavigationBar(
//       //   type: BottomNavigationBarType.fixed,
//       //   backgroundColor: Colors.white,
//       //   currentIndex: _selectedIndex,
//       //   onTap: _onItemTapped,
//       //   items: const <BottomNavigationBarItem>[
//       //     BottomNavigationBarItem(
//       //       icon: Icon(Icons.list_alt),
//       //       label: 'List',
//       //     ),
//       //     BottomNavigationBarItem(
//       //       icon: Icon(Icons.calendar_month),
//       //       label: 'Calendar',
//       //     ),
//       //     BottomNavigationBarItem(
//       //       icon: Icon(Icons.home),
//       //       label: 'Home',
//       //     ),
//       //     BottomNavigationBarItem(
//       //       icon: Icon(Icons.gamepad_outlined),
//       //       label: 'Game',
//       //     ),
//       //     BottomNavigationBarItem(
//       //       icon: Icon(Icons.settings_outlined),
//       //       label: 'Setting',
//       //     ),

//       //     // ...
//       //   ],
//       // ),
//     );
//   }
// }

