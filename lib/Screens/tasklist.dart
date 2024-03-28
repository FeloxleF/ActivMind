import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:activmind_app/Screens/Calendar.dart';
import 'package:activmind_app/Screens/HomeForm.dart';
import 'package:activmind_app/common/taskform.dart';
import 'package:flutter/material.dart';
import 'package:activmind_app/common/appandfooterbar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  
  Map<String, dynamic>? currentTask;
  

  void modifyTask(Map<String, dynamic> task) {
  setState(() {
    currentTask = Map.from(task); // Make a copy of the task data
  });
  // Open the form dialog to modify the task
  _openFormDialog(context, _formKey, currentTask,false);
}

void createtask({Map<String, dynamic>? task}) {
  Map<String, dynamic> initialTaskData = task ?? {}; // Use provided task, or empty map if task is null
  setState(() {
    currentTask = Map.from(initialTaskData); // Make a copy of the task data
  });
  // Open the form dialog to modify the task
  _openFormDialog(context, _formKey, currentTask,true);
}


  Future<void> updateTask(Map<String, dynamic>? taskData) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final String apiUrl = 'http://10.0.2.2:8000/tasks/${taskData?["id"]}/'; 

    final response = await http.put(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $token',
        
      },
      body: jsonEncode(taskData), // Convert task data to JSON format
    );

    if (response.statusCode == 200) {
      // Task updated successfully
      print('Task updated successfully');
    } else {
      // Task update failed
      print('Failed to update task. Status code: ${response.statusCode}');
    }
  } catch (error) {
    // Exception occurred while updating task
    print('Error updating task: $error');
  }
}

Future<void> deleteTask(Map<String, dynamic>? taskData) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final String apiUrl = 'http://10.0.2.2:8000/tasks/${taskData?["id"]}/'; 

    final response = await http.delete(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $token',
        
      },
      // body: jsonEncode(taskData), // Convert task data to JSON format
    );

    if (response.statusCode == 204) {
      // Task delete successfully
      print('Task delete successfully');
      Fluttertoast.showToast(
        msg: 'Task deleted successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      // Task update failed
      print('Failed to delete task. Status code: ${response.statusCode}');
    }
  } catch (error) {
    // Exception occurred while updating task
    print('Error delete task: $error');
  }
}


  Future<List<dynamic>> fetchData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  final response = await http.get(
      Uri.parse("http://10.0.2.2:8000/tasks/"),
      headers: <String, String>{
        'Authorization': 'Token $token',
      },
    );
    
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      List<dynamic> data = json.decode(response.body);
      print(data);
      return data;
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load data');
    }
  }


  void _openFormDialog(BuildContext context, GlobalKey<FormState> formKey, Map<String, dynamic>? taskData, bool create) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return MyFormDialog(formKey: formKey, taskData: taskData, create: create);
      },
    );
  }


  final _formKey = GlobalKey<FormState>();
  
  int _currentIndex = 0;

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
    setState(() {
      _currentIndex = index;
    });
  }

  late Future<List<dynamic>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = fetchData();
    print(_futureData);
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
        // currentPage = SettingsPage();
        break;
      default:
        currentPage = const TaskList(); // Default to the first page
    }
  


  return Scaffold(
    appBar: const MyAppBar(),
    body: FutureBuilder<List<dynamic>>(
      future: _futureData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(), // Show a loading indicator while waiting for data
          );
        } else if(snapshot.data == null){
           return const Center(
            child: Text('Error: Failed to load data'), //// Show an error message if data is null
          );
        
        } else if (snapshot.hasError ) {
          return Center(
            child: Text('Error: ${snapshot.error}'), // Show an error message if data fetching fails
          );
        } else {
          // Data fetched successfully, display it
          List<dynamic> items = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Text(
                  'Emploi du temps de la semaine',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Arial',
                  ),
                ),
                
                ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    var task = items[index];
                    return Card(
                      elevation: 5,
                      margin: const EdgeInsets.all(5),
                      child: ListTile(
                        title: Text(task["title"] ?? "No title"),
                        subtitle: Text(task["discription"] ?? "No description"),
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(task["title"] ?? "No title"),
                            // content: Text(task["discription"] ?? "No description"),
                            content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Description: ${task["discription"] ?? "No description"}"),
                              Text("Date: ${task["do_date"] ?? "No date"}"),
                              Text("Start Time: ${task["start_time"] ?? "No start time"}"),
                              Text("End Time: ${task["end_time"] ?? "No end time"}"),
                              Text("Alarm: ${task["alarm"] == true ? 'Yes' : task["alarm"] == false ? 'No' : 'No'}"),
                              Text("repetation: ${task["repetation"] == true ? 'Yes' : task["repetation"] == false ? 'No' : 'No'}"),
                              Text("termine: ${task["done"] == true ? 'Yes' : task["done"] == false ? 'No' : 'No'}"),

                            ],
                          ),
                            actions: <Widget>[

                              TextButton(
                                child: const Text('Modify'),
                                onPressed: () => modifyTask(task),
                              ),

                              TextButton(
                                child: const Text('Supprimer'),
                                onPressed: () => deleteTask(task),
                              ),



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
                Padding(
              padding: const EdgeInsets.only(top: 8),
              child: FloatingActionButton(
                onPressed: () => createtask(),
                // onPressed: () => showFormDialog(context, _formKey),
                child: const Icon(Icons.add),
              ),
            ),
                
              ],
            ),
          );
        }
      },
    ),
    bottomNavigationBar: BottomNavBar(
      currentIndex: _currentIndex,
      onTap: _onItemTapped,
    ),
  );
}
}