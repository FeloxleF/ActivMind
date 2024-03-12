import 'dart:convert';

import 'package:activmind_app/Screens/Calendar.dart';
import 'package:activmind_app/Screens/HomeForm.dart';
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
    showFormDialog(context, _formKey, currentTask);
  }

  Future<void> updateTask(Map<String, dynamic>? taskData) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final String apiUrl = 'http://10.0.2.2:8000/tasks/${taskData?["id"]}'; // Update the URL with your API endpoint

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

  final _formKey = GlobalKey<FormState>();
  void showFormDialog(BuildContext context, GlobalKey<FormState> formKey, Map<String, dynamic>? taskData) {
  final TextEditingController titleController = TextEditingController(text: taskData?["title"]);
  final TextEditingController descriptionController = TextEditingController(text: taskData?["description"]);

  showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 209, 193, 238),
          content: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Positioned(
                right: -40,
                top: -40,
                child: InkResponse(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Icon(Icons.close),
                  ),
                ),
              ),
              Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        controller: titleController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Veuillez entrer un nom de l\'activité ',
                          border: OutlineInputBorder(),
                          fillColor: Color.fromARGB(255, 232, 217, 255),
                          filled: true,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer un nom de l\'activité';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          taskData?["title"] = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        controller: descriptionController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Si vous voulez, vous pouvez entrer votre description (c\'est optionnel)',
                          border: OutlineInputBorder(),
                          fillColor: Color.fromARGB(255, 232, 217, 255),
                          filled: true,
                        ),
                        onSaved: (value) {
                          taskData?["description"] = value;
                        },
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 65, 64, 155),
                              onPrimary: Color.fromARGB(255, 255, 255, 255),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Annuler'),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 255, 181, 70),
                              onPrimary: Color.fromARGB(255, 44, 41, 223),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                // Call your API to update the task here
                                updateTask(taskData);
                                Navigator.of(context).pop();
                              }
                            },
                            child: const Text('Enregistrer'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }



  // void showFormDialog(BuildContext context, GlobalKey<FormState> formKey) {
   
  //   showDialog<void>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(backgroundColor: Color.fromARGB(255, 209, 193, 238),
  //                       content: Stack(
  //                         clipBehavior: Clip.none,
  //                         children: <Widget>[
  //                           Positioned(
  //                             right: -40,
  //                             top: -40,
  //                             child: InkResponse(
  //                               onTap: () {
  //                                 Navigator.of(context).pop();
  //                               },
  //                               child: const CircleAvatar(
  //                                 backgroundColor: Colors.red,
  //                                 child: Icon(Icons.close),
  //                               ),
  //                             ),
  //                           ),
  //                           Form(
  //                             key: _formKey,
  //                             child: Column(
  //                               mainAxisSize: MainAxisSize.min,
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: <Widget>[
  //                                 const Padding(
  //                                   padding: EdgeInsets.all(8),
  //                                   child: Text(
  //                                     'Nom de l’activité',
  //                                     textAlign: TextAlign.left,
  //                                     style: TextStyle(
  //                                       fontSize: 16.0,
  //                                       color: Color.fromARGB(255, 23, 79, 124),
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 const Padding(
  //                                   padding: EdgeInsets.all(8),
  //                                   child: TextField(
  //                                     keyboardType: TextInputType.multiline,
  //                                     maxLines: null,
  //                                     decoration: InputDecoration(
  //                                       hintText:
  //                                           'Veuillez entrer un nom de l\'activité ',
  //                                       border: OutlineInputBorder(),
  //                                       fillColor:
  //                                           Color.fromARGB(255, 232, 217, 255),
  //                                       filled: true,
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 const Padding(
  //                                   padding: EdgeInsets.all(8),
  //                                   child: Text(
  //                                     'Description (optionnel)',
  //                                     textAlign: TextAlign.left,
  //                                     style: TextStyle(
  //                                       fontSize: 16.0,
  //                                       color: Color.fromARGB(255, 23, 79, 124),
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 const Padding(
  //                                   padding: EdgeInsets.all(8),
  //                                   child: TextField(
  //                                     keyboardType: TextInputType.multiline,
  //                                     maxLines: 3,
  //                                     decoration: InputDecoration(
  //                                       hintText:
  //                                           'Si vous voulez, vous pouvez entrer votre description (c\'est optionnel)',
  //                                       border: OutlineInputBorder(),
  //                                       fillColor:
  //                                           Color.fromARGB(255, 232, 217, 255),
  //                                       filled: true,
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 Row(
  //                                   crossAxisAlignment: CrossAxisAlignment.center,
  //                                   children: [
  //                                     Padding(
  //                                       padding: const EdgeInsets.only(
  //                                           left: 10, top: 10),
  //                                       child: ElevatedButton(
  //                                         style: ElevatedButton.styleFrom(
  //                                           primary:
  //                                               Color.fromARGB(255, 65, 64, 155),
  //                                           onPrimary: Color.fromARGB(
  //                                               255, 255, 255, 255),
  //                                         ),
  //                                         onPressed: () {
  //                                           if (_formKey.currentState!
  //                                               .validate()) {
  //                                             _formKey.currentState!.save();
  //                                             Navigator.of(context).pop();
  //                                           }
  //                                         },
  //                                         child: const Text('Annuler'),
  //                                       ),
  //                                     ),
  //                                     Spacer(),
  //                                     Padding(
  //                                       padding: const EdgeInsets.only(top: 10),
  //                                       child: ElevatedButton(
  //                                         style: ElevatedButton.styleFrom(
  //                                           primary:
  //                                               Color.fromARGB(255, 255, 181, 70),
  //                                           onPrimary:
  //                                               Color.fromARGB(255, 44, 41, 223),
  //                                         ),
  //                                         onPressed: () {
  //                                           if (_formKey.currentState!
  //                                               .validate()) {
  //                                             _formKey.currentState!.save();
  //                                           }
  //                                         },
  //                                         child: const Text('Enregistrer'),
  //                                       ),
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     );
  //     },
  //   );
  


  int _currentIndex = 0;

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
    appBar: MyAppBar(),
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
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    var task = items[index];
                    return Card(
                      elevation: 5,
                      margin: EdgeInsets.all(5),
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
                              Text("Description: ${task["description"] ?? "No description"}"),
                              Text("Date: ${task["do_date"] ?? "No date"}"),
                              Text("Start Time: ${task["start_time"] ?? "No start time"}"),
                              Text("Alarm: ${task["alarm"] == true ? 'Yes' : task["alarm"] == false ? 'No' : 'No'}"),
                              Text("repetation: ${task["repetition"] == true ? 'Yes' : task["repetition"] == false ? 'No' : 'No'}"),
                              Text("termine: ${task["done"] == true ? 'Yes' : task["repetition"] == false ? 'No' : 'No'}"),

                            ],
                          ),
                            actions: <Widget>[
                              // TextButton(
                              //   child: Text('Modifier'),
                              //   onPressed: () => showFormDialog(context, _formKey),
                              // ),
                              TextButton(
                                child: Text('Modify'),
                                onPressed: () => modifyTask(task),
                              ),



                              TextButton(
                                child: Text('ّFermer'),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
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