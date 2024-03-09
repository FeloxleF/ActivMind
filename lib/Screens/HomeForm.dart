import 'package:activmind_app/common/appandfooterbar.dart';
import 'package:flutter/material.dart';

class HomeForm extends StatefulWidget {
  const HomeForm({super.key});

  @override
  State<HomeForm> createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {
  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      if (index != _selectedIndex) {
        _selectedIndex = index; 
      }
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      // AppBar(
      //   title: const Center(
      //     child: Text(
      //       'Activ\'Mind',
      //       style: TextStyle(
      //         fontWeight: FontWeight.bold,
      //         color: Colors.indigoAccent,
      //         fontSize: 24,
      //         fontFamily: 'Arial',
      //       ),
      //     ),
      //   ),
      //   leading: IconButton(
      //     icon: Icon(Icons.alarm),
      //     onPressed: () {},
      //   ),
      //   actions: <Widget>[
      //     IconButton(
      //       icon: Icon(Icons.notifications_none),
      //       onPressed: () {},
      //     ),
      //   ],
      // ),
      body: const Center(child: Text('Log in successful')),
      bottomNavigationBar: MyFooter(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   backgroundColor: Colors.white,
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.list_alt),
      //       label: 'List',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.calendar_month),
      //       label: 'Calendar',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.gamepad_outlined),
      //       label: 'Game',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings_outlined),
      //       label: 'Setting',
      //     ),

      //     // ...
      //   ],
      // ),
    );
  }
}

