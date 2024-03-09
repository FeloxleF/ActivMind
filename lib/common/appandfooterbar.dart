import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: const Center(
          child: Text(
            'Activ\'Mind',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.indigoAccent,
              fontSize: 24,
              fontFamily: 'Arial',
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.alarm),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}


class MyFooter extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const MyFooter({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt),
          label: 'List',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month),
          label: 'Calendar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.gamepad_outlined),
          label: 'Game',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_outlined),
          label: 'Setting',
        ),
      ],
    );
  }
}

// class MyFooter extends StatelessWidget {
  
//   final int selectedIndex;
//   final ValueChanged<int> onItemTapped;
  
//   void _onItemTapped(int index) {
//     setState(() {
//       if (index != _selectedIndex) {
//         _selectedIndex = index; 
//       }
      
//     });
//   }

//   const MyFooter({
//     required this.selectedIndex,
//     required this.onItemTapped,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       type: BottomNavigationBarType.fixed,
//       backgroundColor: Colors.white,
//       currentIndex: selectedIndex,
//       onTap: onItemTapped,
//       items: const <BottomNavigationBarItem>[
//         BottomNavigationBarItem(
//           icon: Icon(Icons.list_alt),
//           label: 'List',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.calendar_month),
//           label: 'Calendar',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.gamepad_outlined),
//           label: 'Game',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.settings_outlined),
//           label: 'Setting',
//         ),
//       ],
//     );
//   }
// }