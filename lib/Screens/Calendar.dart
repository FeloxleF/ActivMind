import 'dart:convert';
import 'package:activmind_app/Screens/HomeForm.dart';
import 'package:activmind_app/Screens/appsettingpage.dart';
import 'package:activmind_app/Screens/locationList.dart';
import 'package:activmind_app/Screens/tasklist.dart';
import 'package:activmind_app/common/appandfooterbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../common/csrf.dart';
import '../common/task_class.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  level: Level.all
);



class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => __CalendarState();
}





class __CalendarState extends State<Calendar> {

  DateTime selectedDay = DateTime.now();
  String selectedDayFormatted = DateFormat('yyyy-MM-dd').format(DateTime.now());

  void _selectDay(DateTime day) {
    setState(() {
      selectedDay = day;
      selectedDayFormatted = DateFormat('yyyy-MM-dd').format(selectedDay);
    });
    fetchTasks(selectedDayFormatted);
  }

  final _formKey = GlobalKey<FormState>();
  List<Task> items = [];

  // on charge les tâches de la date du jour lors de l'initialisation du calendrier
  @override
  void initState() {
    super.initState();
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formattedDate = formatter.format(now);
    fetchTasks(formattedDate);
  }

  Future<void> fetchTasks(String date) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final csrfToken = await fetchCSRFToken();
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/tasks/?date=$date'),
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token $token',
      'X-CSRFToken': csrfToken,
      }
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final tasks = jsonBody as List<dynamic>;

      List<Task> taskList = tasks.map((task) => Task.fromJson(task)).toList();

      setState(() {
        items = taskList;
      });
    } else {
      throw Exception('Failed to load tasks');
    }
  }


  // void showFormDialog(BuildContext context, GlobalKey<FormState> formKey) {
  //   showDialog<void>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(backgroundColor: const Color.fromARGB(255, 209, 193, 238),
  //         content: Stack(
  //           clipBehavior: Clip.none,
  //           children: <Widget>[
  //             Positioned(
  //               right: -40,
  //               top: -40,
  //               child: InkResponse(
  //                 onTap: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: const CircleAvatar(
  //                   backgroundColor: Colors.red,
  //                   child: Icon(Icons.close),
  //                 ),
  //               ),
  //             ),
  //             Form(
  //               key: _formKey,
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: <Widget>[
  //                   const Padding(
  //                     padding: EdgeInsets.all(8),
  //                     child: Text(
  //                       'Nom de l’activité',
  //                       textAlign: TextAlign.left,
  //                       style: TextStyle(
  //                         fontSize: 16.0,
  //                         color: Color.fromARGB(255, 23, 79, 124),
  //                       ),
  //                     ),
  //                   ),
  //                   const Padding(
  //                     padding: EdgeInsets.all(8),
  //                     child: TextField(
  //                       keyboardType: TextInputType.multiline,
  //                       maxLines: null,
  //                       decoration: InputDecoration(
  //                         hintText:
  //                         'Veuillez entrer un nom de l\'activité ',
  //                         border: OutlineInputBorder(),
  //                         fillColor:
  //                         Color.fromARGB(255, 232, 217, 255),
  //                         filled: true,
  //                       ),
  //                     ),
  //                   ),
  //                   const Padding(
  //                     padding: EdgeInsets.all(8),
  //                     child: Text(
  //                       'Description (optionnel)',
  //                       textAlign: TextAlign.left,
  //                       style: TextStyle(
  //                         fontSize: 16.0,
  //                         color: Color.fromARGB(255, 23, 79, 124),
  //                       ),
  //                     ),
  //                   ),
  //                   const Padding(
  //                     padding: EdgeInsets.all(8),
  //                     child: TextField(
  //                       keyboardType: TextInputType.multiline,
  //                       maxLines: 3,
  //                       decoration: InputDecoration(
  //                         hintText:
  //                         'Si vous voulez, vous pouvez entrer votre description (c\'est optionnel)',
  //                         border: OutlineInputBorder(),
  //                         fillColor:
  //                         Color.fromARGB(255, 232, 217, 255),
  //                         filled: true,
  //                       ),
  //                     ),
  //                   ),
  //                   Row(
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     children: [
  //                       Padding(
  //                         padding: const EdgeInsets.only(
  //                             left: 10, top: 10),
  //                         child: ElevatedButton(
  //                           style: ElevatedButton.styleFrom(
  //                             foregroundColor: const Color.fromARGB(
  //                                 255, 255, 255, 255), backgroundColor: const Color.fromARGB(255, 65, 64, 155),
  //                           ),
  //                           onPressed: () {
  //                             if (_formKey.currentState!
  //                                 .validate()) {
  //                               _formKey.currentState!.save();
  //                               Navigator.of(context).pop();
  //                             }
  //                           },
  //                           child: const Text('Annuler'),
  //                         ),
  //                       ),
  //                       const Spacer(),
  //                       Padding(
  //                         padding: const EdgeInsets.only(top: 10),
  //                         child: ElevatedButton(
  //                           style: ElevatedButton.styleFrom(
  //                             foregroundColor: const Color.fromARGB(255, 44, 41, 223), backgroundColor: const Color.fromARGB(255, 255, 181, 70),
  //                           ),
  //                           onPressed: () {
  //                             if (_formKey.currentState!
  //                                 .validate()) {
  //                               _formKey.currentState!.save();
  //                             }
  //                           },
  //                           child: const Text('Enregistrer'),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }


  int _currentIndex = 1;

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
        MaterialPageRoute(builder: (context) => const AppSettingPage()),
      );
      return; // Return here to prevent further execution
    }
    setState(() {
      _currentIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    Widget currentPage;
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
      default:
        currentPage = const TaskList(); // Default to the first page
    }
    return Scaffold(
      appBar: const MyAppBar(),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              'Emploi du temps du $selectedDayFormatted',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Arial',
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 5),
                    child: ElevatedButton(
                      onPressed: () {
                        _selectDay(DateTime(selectedDay.year, selectedDay.month, selectedDay.day - 1));
                      },
                      child: const Text('<'),
                    )

                ),
                const Spacer(),
                Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 5),
                    child: ElevatedButton(
                      onPressed: () {
                        _selectDay(DateTime(selectedDay.year, selectedDay.month, selectedDay.day + 1));
                      },
                      child: const Text('>'),
                    )

                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: Text(items[index].startTime.format(context)),
                    title: Text(items[index].title),
                    subtitle: Text(items[index].discription),
                    trailing: items[index].endTime == null ? null : Text(items[index].endTime!.format(context)),
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(items[index].title),
                        content: Text(items[index].discription),
                        actions: <Widget>[
                          // TextButton(
                          //   // child: const Text('Modifier'),
                          //   // onPressed: () => showFormDialog(context, _formKey),
                          // ),
                          TextButton(
                            child: const Text('ّFermer'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 8),
            //   child: FloatingActionButton(
            //     onPressed: () => showFormDialog(context, _formKey),
            //     child: const Icon(Icons.add),
            //   ),


            // ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
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
