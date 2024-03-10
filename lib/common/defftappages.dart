import 'package:activmind_app/Screens/tasklist.dart';
import 'package:flutter/material.dart';
import 'package:activmind_app/Screens/tasklist.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  void initState() {
    super.initState();
    // Navigate to TaskList page when ListPage is initialized
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TaskList()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Placeholder widget since this won't be used
    return const Placeholder();
  }
}


class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Calendar Page'));
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Home Page'));
  }
}

class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Game Page'));
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Settings Page'));
  }
}