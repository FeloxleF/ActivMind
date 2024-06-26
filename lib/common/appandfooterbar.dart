import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AppBar(
      title: Center(
        child: Text(
          'Activ\'Mind',
          style: GoogleFonts.passeroOne(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.indigoAccent,
          ),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.alarm),
        onPressed: () {},
      ),
      actions: const <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 18.0),
          child: Text('V 1.0'),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      currentIndex: currentIndex,
      onTap: onTap,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt),
          label: 'Liste',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month),
          label: 'Calendrier',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Acceuil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on),
          label: 'Localisation',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_outlined),
          label: 'Parametres',
        ),
      ],
    );
  }
}
