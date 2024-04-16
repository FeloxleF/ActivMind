import 'dart:async';
import 'dart:convert';
import 'dart:core';
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
import 'createtask.dart';
import 'package:google_fonts/google_fonts.dart';

var logger = Logger(level: Level.all);

extension TimeOfDayExtension on TimeOfDay {
  String formatHHmm24() {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }
}

class Calendar extends StatefulWidget {
  final DateTime? selectedDay;

  const Calendar({super.key, this.selectedDay});

  @override
  State<Calendar> createState() => __CalendarState();
}

class __CalendarState extends State<Calendar> {
  DateTime selectedDay = DateTime.now();
  String selectedDayFormatted = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String selectedDayFormatted2 =
      DateFormat('MM-dd-yyyy').format(DateTime.now());

  void _selectDay(DateTime day) {
    setState(() {
      selectedDay = day;
      selectedDayFormatted = DateFormat('yyyy-MM-dd').format(selectedDay);
      selectedDayFormatted2 = DateFormat('MM-dd-yyyy').format(selectedDay);
    });
    fetchTasks(selectedDayFormatted);
  }

  List<Task> items = [];

  // on charge les tâches de la date du jour lors de l'initialisation du calendrier
  @override
  void initState() {
    super.initState();
    if (widget.selectedDay != null) {
      selectedDay = widget.selectedDay!;
      selectedDayFormatted = DateFormat('yyyy-MM-dd').format(selectedDay);
      selectedDayFormatted2 = DateFormat('MM-dd-yyyy').format(selectedDay);
      fetchTasks(selectedDayFormatted);
    } else {
      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formattedDate = formatter.format(now);
      fetchTasks(formattedDate);
    }
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
        });

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

  Future<void> deleteTask(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final csrfToken = await fetchCSRFToken();
    final response = await http.delete(
        Uri.parse('http://10.0.2.2:8000/tasks/$id/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token',
          'X-CSRFToken': csrfToken,
        });
    if (response.statusCode == 204) {
      fetchTasks(selectedDayFormatted);
    } else {
      throw Exception('Failed to delete task');
    }
  }

  Map<String, String> weekdays = {
    'Monday': 'Lundi',
    'Tuesday': 'Mardi',
    'Wednesday': 'Mercredi',
    'Thursday': 'Jeudi',
    'Friday': 'Vendredi',
    'Saturday': 'Samedi',
    'Sunday': 'Dimanche',
  };

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
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 15),
            Text(
              'Activités du ${weekdays[DateFormat('EEEE').format(selectedDay)]}',
              style: GoogleFonts.nunito(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              selectedDayFormatted2,
              style: GoogleFonts.nunito(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                Padding(
                    padding:
                        const EdgeInsets.only(top: 15.0, left: 8, bottom: 8),
                    child: ElevatedButton(
                      onPressed: () {
                        _selectDay(DateTime(selectedDay.year, selectedDay.month,
                            selectedDay.day - 1));
                      },
                      child: const Text(
                        '<',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                    )),
                const Spacer(),
                Padding(
                    padding:
                        const EdgeInsets.only(top: 15.0, right: 8, bottom: 8),
                    child: ElevatedButton(
                      onPressed: () {
                        _selectDay(DateTime(selectedDay.year, selectedDay.month,
                            selectedDay.day + 1));
                      },
                      child: const Text(
                        '>',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                    )),
              ],
            ),
            const SizedBox(height: 15),
            if (items.isEmpty)
               Padding(
                padding: const EdgeInsets.all(16.0), // Ajustez la valeur selon vos besoins
                child: Center(
                  child: Text(
                    "Vous n'avez pas encore d'activitées prévues à cette date",
                    style: GoogleFonts.nunito(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            else
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    margin:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: ListTile(
                      leading: Text(items[index].startTime.formatHHmm24()),
                      title: Text(items[index].title),
                      subtitle: Text(items[index].discription),
                      trailing: items[index].endTime == null
                          ? null
                          : Text(items[index].endTime!.formatHHmm24()),
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(items[index].title,
                            style: GoogleFonts.nunito(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Description: ${items[index].discription}"),
                              Text(
                                  "Date: ${DateFormat('yyyy-MM-dd').format(items[index].doDate)}"),
                              Text(
                                  "Start Time: ${items[index].startTime.formatHHmm24()}"),
                              Text(
                                  "End Time: ${items[index].endTime?.formatHHmm24()}"),
                              Text(
                                "Alarm: ${items[index].alarm ? 'Yes' : 'No'}",
                              ),
                              Text(
                                  "repetation: ${items[index].repetation ? 'Yes' : 'No'}"),
                              Text(
                                  "termine: ${items[index].done ? 'Yes' : 'No'}"),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('ّFermer'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            TextButton(
                              child: const Text('Supprimer'),
                              onPressed: () {
                                deleteTask(items[index].id!);
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Modify'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => createTask(
                                      taskData: items[index].toJson(),
                                      operation: 'edit',
                                    ), // Pass the task data
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => createTask(
                          taskData: {"do_date": selectedDayFormatted},
                          operation: 'creat'),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Icon(Icons.add),
              ),
            ),

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
