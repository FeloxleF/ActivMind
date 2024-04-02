import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:activmind_app/common/globalvariable.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var globalVariables = Provider.of<GlobalVariables>(context);

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
        // IconButton(
        //   icon: Icon(Icons.notifications_none),
        //   onPressed: () {},
        // ),
        
        Text(globalVariables.user ?? ''), 
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}



class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      currentIndex: currentIndex,
      onTap: onTap,
      items: 
       const <BottomNavigationBarItem>[
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
